module vgasync(
    input logic clk, // 25MHz
    output logic vga_h_sync, vga_v_sync, inDisplayArea, vga_sync, vga_blank,
	 output logic [9:0] CounterX=0, CounterY=0
	 );
    logic vga_HS, vga_VS, CounterXmaxed, CounterYmaxed;

    assign CounterXmaxed = (CounterX == 800); // 16 + 48 + 96 + 640
    assign CounterYmaxed = (CounterY == 525); // 10 + 2 + 33 + 480
	 assign vga_blank = vga_h_sync & vga_v_sync; // this is a signal specific to the DAC on the DE2-115
	 assign vga_sync = 1'b0;

    always @(posedge clk)
    if (CounterXmaxed)
      CounterX <= 0;
    else
      CounterX <= CounterX + 10'd1;

    always @(posedge clk)
    begin
      if (CounterXmaxed)
      begin
        if(CounterYmaxed)
          CounterY <= 0;
        else
          CounterY <= CounterY + 10'd1;
      end
    end

    always @(posedge clk)
    begin
      vga_HS <= (CounterX > (640 + 16) && (CounterX < (640 + 16 + 96)));   // active for 96 clocks
      vga_VS <= (CounterY > (480 + 10) && (CounterY < (480 + 10 + 2)));   // active for 2 clocks
    end

    always @(posedge clk)
    begin
        inDisplayArea <= (CounterX < 640) && (CounterY < 480);
    end

    assign vga_h_sync = ~vga_HS;
    assign vga_v_sync = ~vga_VS;

endmodule
