transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/thor/src/gol {/home/thor/src/gol/vgasync.sv}
vlog -sv -work work +incdir+/home/thor/src/gol {/home/thor/src/gol/vga.sv}
vlog -sv -work work +incdir+/home/thor/src/gol {/home/thor/src/gol/game.sv}
vlog -sv -work work +incdir+/home/thor/src/gol {/home/thor/src/gol/falling_edge.sv}
vlog -sv -work work +incdir+/home/thor/src/gol {/home/thor/src/gol/fsm.sv}
vlog -sv -work work +incdir+/home/thor/src/gol {/home/thor/src/gol/gol.sv}
vlog -sv -work work +incdir+/home/thor/src/gol {/home/thor/src/gol/clock_halver.sv}

