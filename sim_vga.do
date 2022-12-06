if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###

vlog -sv -work work [pwd]/fsm.sv
vlog -sv -work work [pwd]/game.sv
vlog -sv -work work [pwd]/falling_edge.sv
vlog -sv -work work [pwd]/vgasync.sv
vlog -sv -work work [pwd]/vga.sv
vlog -sv -work work [pwd]/clock_halver.sv
vlog -sv -work work [pwd]/gol.sv
vlog -sv -work work [pwd]/vga_testbench.sv

### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelModule with the name of your top level module (no .sv) ###
### Do not duplicate! ###
vsim vga_testbench -voptargs="+acc"

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals ###
add wave clk
add wave dut/vga_clk
add wave -radix 10 dut/vga_inst/CounterX
add wave -radix 10 dut/vga_inst/CounterY
add wave vga_blank;
add wave -radix 10 R
add wave -radix 10 G
add wave -radix 10 B
add wave hsync_out
add wave vsync_out
add wave -radix 2 board
### ---------------------------------------------- ###
### Run simulation ###
### Do not modify ###
# to see your design hierarchy and signals 
view structure 

# to see all signal names and current values
view signals 

### ---------------------------------------------- ###
### Edit run time ###
### run 4500
run 1800000

### ---------------------------------------------- ###
### Will create large wave window and zoom to show all signals
view wave
wave zoomfull 
