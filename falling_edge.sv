module falling_edge(input logic clk, input logic button, output logic falling);
logic ff1, ff2;

always_ff @(posedge clk) begin
    ff1 <= button;
    ff2 <= ff1;
end

assign falling = ~ff1 && ff2;

endmodule
