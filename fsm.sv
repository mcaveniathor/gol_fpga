module fsm(input logic clk, loadin, runin, resetin, output logic load, run, reset);
typedef enum logic [1:0] { s_idle, s_load, s_reset, s_run } fsmstate;
fsmstate current_state = s_idle;
fsmstate next_state = s_idle;

always_ff @(posedge clk) begin
    current_state <= next_state;
end


always_comb begin
    case(current_state)
        s_reset:
            if(resetin)
                next_state <= s_reset;
            else
                next_state <= s_idle;
        s_idle:
            if(resetin)
                next_state <= s_reset;
            else
            case({loadin, runin})
                2'b10: // Load, ~run
                    next_state <= s_load;
                2'b01: // ~load, run
                    next_state <= s_run;
                2'b00: // ~load, ~run
                    next_state <= s_idle;
                2'b11: // load, run
				    next_state <= s_idle;
            endcase
        s_load:
            if(resetin)
                next_state <= s_reset;
            else
            case({loadin, runin})
                2'b00: // ~load, ~run
                    next_state <= s_idle;
                2'b11: // load, run
                    next_state <= s_idle;
                2'b10: // Load, ~run
                    next_state <= s_load;
                2'b01: // ~load, run
                    next_state <= s_run;
            endcase
        s_run:
            if(resetin)
                next_state <= s_reset;
            else
            case({loadin, runin})
                2'b00: // ~load, ~run
                    next_state <= s_idle;
                2'b11: // load, run
                    next_state <= s_idle;
                2'b10: // Load, ~run
                    next_state <= s_idle;
                2'b01: // ~load, run
                    next_state <= s_run;
            endcase
        default:
            next_state <= s_idle;
    endcase
end

assign load = current_state == s_load;
assign run = current_state == s_run;
assign reset = current_state == s_reset;
endmodule


