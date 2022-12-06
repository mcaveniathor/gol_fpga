module clock_halver(input logic clk, output logic div_clk);
logic clk_ctr = 0;
// need a 25MHz clock for VGA @ 640x480 60Hz
// Tiny clock divider to take 50MHz down to 25MHz with a 1-bit counter
always_ff @(posedge clk) begin
	if (clk_ctr) begin
		clk_ctr <= 0;
		div_clk <= 1;
	end
	else begin
		clk_ctr <= 1;
		div_clk <= 0;
	end
end
endmodule