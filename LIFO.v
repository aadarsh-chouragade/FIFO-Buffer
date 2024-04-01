module lifo (
    input clk,       // Clock input
    input reset,     // Reset input
    input push,      // Push signal
    input pop,       // Pop signal
    input [7:0] data_in,  // Data input
    output reg [7:0] data_out,  // Data output
    output reg full,           // LIFO full flag
    output reg empty           // LIFO empty flag
);

// Parameters
parameter DEPTH = 8; // Depth of the LIFO

// Internal signals
reg [7:0] lifo[0:DEPTH-1];
reg [2:0] top;
reg [3:0] count;

// Initialize signals
initial begin
    top = 0;
    count = 0;
    full = 0;
    empty = 1;
end

// LIFO full and empty logic
always @* begin
    full = (count == DEPTH);
    empty = (count == 0);
end

// Push logic
always @(posedge clk) begin
    if (reset) begin
        top <= 0;
        count <= 0;
    end else if (push && !full) begin
        lifo[top] <= data_in;
        top <= top + 1;
        count <= count + 1;
    end
end

// Pop logic
always @(posedge clk) begin
    if (reset) begin
        top <= 0;
        count <= 0;
    end else if (pop && !empty) begin
        top <= top - 1;
        count <= count - 1;
        data_out <= lifo[top];
    end
end

endmodule
