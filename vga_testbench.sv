module vga_testbench #(parameter HEIGHT=20, parameter WIDTH=20)();
logic clk =0, run_btn, load_btn, reset_btn;
logic [0:WIDTH-3] data_in;
logic [0:HEIGHT-1][0:WIDTH-1] board;
logic [7:0] R,G,B;
logic hsync_out, vsync_out, vga_blank, vga_sync, vga_clk;


always #1 clk <= ~clk;
gol #(.HEIGHT(HEIGHT), .WIDTH(WIDTH)) dut (.clk(clk), .run_btn(run_btn), .reset_btn(reset_btn), .load_btn(load_btn), .data_in(data_in), .board(board),
.r(R), .g(G), .b(B), .hsync_out(hsync_out), .vsync_out(vsync_out), .vga_blank(vga_blank), .vga_sync(vga_sync), .vga_clk(vga_clk));

task load_row(input logic [0:WIDTH-3] data);
    @(negedge clk) begin
        $display("%0t Pressing load button.", $time);
        load_btn <= 0;
        reset_btn <= 1;
        run_btn <= 1;
        data_in <= data;
    end
    @(negedge clk) load_btn <= 1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
endtask

task reset();
    @(negedge clk) begin
        $display("%0t Pressing reset button.", $time);
        reset_btn <= 0;
        load_btn <= 1;
        run_btn <= 1;
    end
    @(negedge clk) reset_btn <= 1;
endtask

task run();
    @(negedge clk) begin
        $display("%0t Pressing run button.", $time);
        reset_btn <= 1;
        load_btn <= 1;
        run_btn <= 0;
    end
    @(negedge clk) run_btn <= 1;
endtask

task print_board();
    $display("%0t Current board:", $time);
    for(int i=1; i<HEIGHT-1; i++) begin
        $write("\t");
        for(int j=1; j<WIDTH-1; j++) begin
            $write("%b",board[i][j]);
        end
        $write("\n");
    end
endtask

initial begin
    @(posedge clk) begin
        load_btn <= 1;
        run_btn <= 1;
        reset_btn <= 1;
    end
    repeat(2) @(posedge clk);
    reset();
    load_row(3'b011);
    load_row(3'b010);
    load_row(3'b100);
    repeat(200) begin
        print_board();
        run();
    end
end

endmodule
