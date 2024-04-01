module fifo (
    input clk,       // Clock input
    input reset,     // Reset input
    input enq,       // Enqueue signal
    input deq,       // Dequeue signal
    input [7:0] data_in,  // Data input
    output reg [7:0] data_out,  // Data output
    output reg full,           // FIFO full flag
    output reg empty           // FIFO empty flag
);

// Parameters
parameter DEPTH = 8; // Depth of the FIFO

// Internal signals
reg [7:0] fifo[0:DEPTH-1];
reg [2:0] head, tail;
reg [3:0] count;

// Initialize signals
initial begin
    head = 0;
    tail = 0;
    count = 0;
    full = 0;
    empty = 1;
end

// FIFO full and empty logic
always @* begin
    full = (count == DEPTH);
    empty = (count == 0);
end

// Enqueue logic
always @(posedge clk) begin
    if (reset) begin
        head <= 0;
        tail <= 0;
        count <= 0;
    end else if (enq && !full) begin
        fifo[head] <= data_in;
        head <= head + 1;
        count <= count + 1;
    end
end

// Dequeue logic
always @(posedge clk) begin
    if (reset) begin
        head <= 0;
        tail <= 0;
        count <= 0;
    end else if (deq && !empty) begin
        data_out <= fifo[tail];
        tail <= tail + 1;
        count <= count - 1;
    end
end

endmodule
