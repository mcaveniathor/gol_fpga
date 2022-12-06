module vga
#( parameter HEIGHT=20, parameter WIDTH=20) 
(
    input clk_25,
	 input logic [0:HEIGHT-1][0:WIDTH-1] board,
    output logic [7:0] R,G,B,
    output logic hsync_out, vsync_out, vga_blank, vga_sync
);
    logic inDisplayArea;
    logic [9:0] CounterX, CounterY;

    vgasync hvsync(
      .clk(clk_25),
      .vga_h_sync(hsync_out),
      .vga_v_sync(vsync_out),
		.vga_blank(vga_blank),
		.vga_sync(vga_sync),
      .inDisplayArea(inDisplayArea),
		.CounterX(CounterX),
		.CounterY(CounterY)
    );

    always @(posedge clk_25)
    begin
		if(inDisplayArea) begin
			if(CounterX < HEIGHT && CounterY < WIDTH) begin
				if(board[CounterX][CounterY]) begin // if this pixel is alive, render it as green
					R <= 8'd137;
					G <= 8'd235;
					B <= 8'd52;
				end
				else begin // this pixel is inbounds but dead, make it black
					R <= 8'd0;
					G <= 8'd0;
					B <= 8'd0;
				end
			end
			else begin // In the display area but not on the board, make this white
				R <= 8'd255;
				G <= 8'd255;
				B <= 8'd255;
			end
		end
      else begin // out of the display area
        R <= 8'd0;
		  G <= 8'd0;
		  B <= 8'd0;
		end
    end

endmodule
