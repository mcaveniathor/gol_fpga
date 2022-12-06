lint: gol.sv fsm.sv falling_edge.sv game.sv
	verilator -Wall --lint-only gol.sv fsm.sv game.sv falling_edge.sv
all: lint
