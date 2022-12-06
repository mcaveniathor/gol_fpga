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
vlog -sv -work work [pwd]/game_testbench.sv

### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelModule with the name of your top level module (no .sv) ###
### Do not duplicate! ###
vsim game_testbench -voptargs="+acc"

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals ###
add wave clk
add wave run_btn
add wave load_btn
add wave reset_btn
add wave dut/run
add wave dut/load
add wave dut/reset
add wave -radix 10 dut/game_inst/loadrow
add wave -radix 2 data_in
add wave -radix 2 board
add wave -radix 2 dut/game_inst/next_board
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
run 10000 

### ---------------------------------------------- ###
### Will create large wave window and zoom to show all signals
view wave
wave zoomfull 
