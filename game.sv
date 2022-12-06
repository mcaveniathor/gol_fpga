module game #(
    parameter HEIGHT=20, // 18 switches plus a row of zeros on the top and bottom
    parameter WIDTH=20   // 18 switches plus a zero on either side
    )
(input logic clk, load, run, reset, input logic [0:WIDTH-3] data_in, output logic [0:HEIGHT-1][0:WIDTH-1] board);


int loadrow = 1;
logic [0:HEIGHT-1][0:WIDTH-1] next_board;

always_ff @(posedge clk) begin
    if(reset) begin
        loadrow <= 1; // start the load at row 1 since the first row should remain all zeros
        for(int i=0; i < HEIGHT; i++) begin
            board[i] <= 0;
            next_board[i] <= 0;
        end
    end
    else
    if(load && loadrow < HEIGHT-1) begin
        next_board[loadrow][0] <= 0;
        next_board[loadrow][WIDTH-1] <= 0;
        next_board[loadrow][1:WIDTH-2] <= data_in; // leave the first and last entry in the row as zeros
        board[loadrow][1:WIDTH-2] <= data_in; // This write is solely for display purposes, as it will be overwritten by the value of next_board when the run button is pressed
        board[loadrow][0] <= 0;
        board[loadrow][WIDTH-1] <= 0;
        loadrow <= loadrow+1;
    end
    else if(run) begin
        board <= next_board;
    //else if (loadrow == HEIGHT-1) begin
        // The board has a ring of zeros around the outside to allow the
        // bounds checking to work correctly, so loop bounds will ignore the
        // first and last entries
        for(int i=1; i<HEIGHT-1; i++) begin
            for(int j=1; j<WIDTH-1; j++) begin
                if(board[i][j]) begin // board[i,j] is currently alive
                    //
                    case({val(i-1,j-1),val(i-1,j),val(i-1,j+1),val(i,j-1),val(i,j+1),val(i+1,j-1),val(i+1,j),val(i+1,j+1)}) // Neighbors of board[i][j]
                        /* 
                        * The cases below were generated using combos.py, with
                        * each combination containing either two or three '1'
                        * digits, per the rules
                        */
                        8'b00000011:
                            next_board[i][j] <= 1;
                        8'b00000101:
                            next_board[i][j] <= 1;
                        8'b00000110:
                            next_board[i][j] <= 1;
                        8'b00000111:
                            next_board[i][j] <= 1;
                        8'b00001001:
                            next_board[i][j] <= 1;
                        8'b00001010:
                            next_board[i][j] <= 1;
                        8'b00001011:
                            next_board[i][j] <= 1;
                        8'b00001100:
                            next_board[i][j] <= 1;
                        8'b00001101:
                            next_board[i][j] <= 1;
                        8'b00001110:
                            next_board[i][j] <= 1;
                        8'b00010001:
                            next_board[i][j] <= 1;
                        8'b00010010:
                            next_board[i][j] <= 1;
                        8'b00010011:
                            next_board[i][j] <= 1;
                        8'b00010100:
                            next_board[i][j] <= 1;
                        8'b00010101:
                            next_board[i][j] <= 1;
                        8'b00010110:
                            next_board[i][j] <= 1;
                        8'b00011000:
                            next_board[i][j] <= 1;
                        8'b00011001:
                            next_board[i][j] <= 1;
                        8'b00011010:
                            next_board[i][j] <= 1;
                        8'b00011100:
                            next_board[i][j] <= 1;
                        8'b00100001:
                            next_board[i][j] <= 1;
                        8'b00100010:
                            next_board[i][j] <= 1;
                        8'b00100011:
                            next_board[i][j] <= 1;
                        8'b00100100:
                            next_board[i][j] <= 1;
                        8'b00100101:
                            next_board[i][j] <= 1;
                        8'b00100110:
                            next_board[i][j] <= 1;
                        8'b00101000:
                            next_board[i][j] <= 1;
                        8'b00101001:
                            next_board[i][j] <= 1;
                        8'b00101010:
                            next_board[i][j] <= 1;
                        8'b00101100:
                            next_board[i][j] <= 1;
                        8'b00110000:
                            next_board[i][j] <= 1;
                        8'b00110001:
                            next_board[i][j] <= 1;
                        8'b00110010:
                            next_board[i][j] <= 1;
                        8'b00110100:
                            next_board[i][j] <= 1;
                        8'b00111000:
                            next_board[i][j] <= 1;
                        8'b01000001:
                            next_board[i][j] <= 1;
                        8'b01000010:
                            next_board[i][j] <= 1;
                        8'b01000011:
                            next_board[i][j] <= 1;
                        8'b01000100:
                            next_board[i][j] <= 1;
                        8'b01000101:
                            next_board[i][j] <= 1;
                        8'b01000110:
                            next_board[i][j] <= 1;
                        8'b01001000:
                            next_board[i][j] <= 1;
                        8'b01001001:
                            next_board[i][j] <= 1;
                        8'b01001010:
                            next_board[i][j] <= 1;
                        8'b01001100:
                            next_board[i][j] <= 1;
                        8'b01010000:
                            next_board[i][j] <= 1;
                        8'b01010001:
                            next_board[i][j] <= 1;
                        8'b01010010:
                            next_board[i][j] <= 1;
                        8'b01010100:
                            next_board[i][j] <= 1;
                        8'b01011000:
                            next_board[i][j] <= 1;
                        8'b01100000:
                            next_board[i][j] <= 1;
                        8'b01100001:
                            next_board[i][j] <= 1;
                        8'b01100010:
                            next_board[i][j] <= 1;
                        8'b01100100:
                            next_board[i][j] <= 1;
                        8'b01101000:
                            next_board[i][j] <= 1;
                        8'b01110000:
                            next_board[i][j] <= 1;
                        8'b10000001:
                            next_board[i][j] <= 1;
                        8'b10000010:
                            next_board[i][j] <= 1;
                        8'b10000011:
                            next_board[i][j] <= 1;
                        8'b10000100:
                            next_board[i][j] <= 1;
                        8'b10000101:
                            next_board[i][j] <= 1;
                        8'b10000110:
                            next_board[i][j] <= 1;
                        8'b10001000:
                            next_board[i][j] <= 1;
                        8'b10001001:
                            next_board[i][j] <= 1;
                        8'b10001010:
                            next_board[i][j] <= 1;
                        8'b10001100:
                            next_board[i][j] <= 1;
                        8'b10010000:
                            next_board[i][j] <= 1;
                        8'b10010001:
                            next_board[i][j] <= 1;
                        8'b10010010:
                            next_board[i][j] <= 1;
                        8'b10010100:
                            next_board[i][j] <= 1;
                        8'b10011000:
                            next_board[i][j] <= 1;
                        8'b10100000:
                            next_board[i][j] <= 1;
                        8'b10100001:
                            next_board[i][j] <= 1;
                        8'b10100010:
                            next_board[i][j] <= 1;
                        8'b10100100:
                            next_board[i][j] <= 1;
                        8'b10101000:
                            next_board[i][j] <= 1;
                        8'b10110000:
                            next_board[i][j] <= 1;
                        8'b11000000:
                            next_board[i][j] <= 1;
                        8'b11000001:
                            next_board[i][j] <= 1;
                        8'b11000010:
                            next_board[i][j] <= 1;
                        8'b11000100:
                            next_board[i][j] <= 1;
                        8'b11001000:
                            next_board[i][j] <= 1;
                        8'b11010000:
                            next_board[i][j] <= 1;
                        8'b11100000:
                            next_board[i][j] <= 1;
                    default:
                        begin
                            
                            next_board[i][j] <= 0;
                        end
                    endcase
                end
				else begin // board[i,j] is currently dead
                    case({val(i-1,j-1),val(i-1,j),val(i-1,j+1),val(i,j-1),val(i,j+1),val(i+1,j-1),val(i+1,j),val(i+1,j+1)}) // Neighbors of board[i][j]
                            /*
                            * Neighbor states with exactly two neighbors alive
                            */ 
                            8'b00000011:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00000101:

                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00000110:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00001001:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00001010:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00001100:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00010001:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00010010:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00010100:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00011000:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00100001:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00100010:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00100100:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00101000:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b00110000:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b01000001:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b01000010:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b01000100:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b01001000:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b01010000:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b01100000:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b10000001:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b10000010:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b10000100:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b10001000:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b10010000:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b10100000:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            8'b11000000:
                        begin
                                next_board[i][j] <= 1;
                                
                        end
                            default:
                                next_board[i][j] <= 0;
                    endcase
                end
            end
        end
    end
    else begin
        
        board <= next_board;
    end
end

function logic val(input int x, y);
    if(~inbounds(x,y)) begin
        return 0;
    end
    else begin
        return board[x][y];
    end
endfunction : val

function logic inbounds(input int x, input int y);
    if (x < 0 || y < 0 || x > HEIGHT || y > WIDTH) begin
        return 0;
    end
else
    return 1;
endfunction : inbounds

endmodule
