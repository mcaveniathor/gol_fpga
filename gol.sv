module gol #( parameter HEIGHT=20, parameter WIDTH=20) // 18 slide switches on the DE2-115 board plus zeros all around the edges
(
input logic clk, run_btn, load_btn, reset_btn,
input logic [0:WIDTH-3] data_in, // one row of input from the switches
output logic [7:0] r,g,b, // r,g,b values for the pixel currently being drawn
output logic hsync_out, vsync_out,  vga_clk, // vga sync signals
vga_blank, vga_sync, // CRT control signals, used by the ADV7123
output logic [0:HEIGHT-1][0:WIDTH-1] board // Only used for testbenching
);
logic load , run, reset, reset_falling, load_falling, run_falling;


falling_edge load_fe(.clk(clk), .button(load_btn), .falling(load_falling));
falling_edge run_fe(.clk(clk), .button(run_btn), .falling(run_falling));
falling_edge reset_fe(.clk(clk), .button(reset_btn), .falling(reset_falling));
fsm fsm_inst(.clk(clk), .loadin(load_falling), .runin(run_falling), .resetin(reset_falling), .load(load), .run(run), .reset(reset));



// need a 25MHz clock for VGA @ 640x480 60Hz
// Use a tiny clock divider to take 50MHz down to 25MHz with a 1-bit counter
clock_halver clkdiv(.clk(clk), .div_clk(vga_clk));

/* 
	Use the 25MHz VGA clock for this for some extra wiggle room timing-wise
*/
// Handles loading, resetting, and running the game
game #(.HEIGHT(HEIGHT), .WIDTH(WIDTH)) game_inst(.clk(clk), .load(load), .reset(reset), .run(run), .board(board), .data_in(data_in));


// generates VGA sync signals and the correct RGB values for the current pixel
vga #(.HEIGHT(HEIGHT), .WIDTH(WIDTH)) vga_inst(.board(board), .clk_25(vga_clk), .R(r), .G(g), .B(b), .hsync_out(hsync_out), .vsync_out(vsync_out), .vga_blank(vga_blank), .vga_sync(vga_sync));

endmodule
