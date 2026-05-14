module lfsr_rng(
    input clk,
    input rst,
    output [2:0] rand_piece
);

reg [7:0] lfsr;

wire feedback;

assign feedback =
    lfsr[7] ^
    lfsr[5] ^
    lfsr[4] ^
    lfsr[3];

always @(posedge clk or posedge rst) begin

    if(rst)
        lfsr <= 8'hA5;   // non-zero seed

    else
        lfsr <= {lfsr[6:0],feedback};

end

assign rand_piece =
    (lfsr[2:0] > 6) ?
        lfsr[2:0]-1 :
        lfsr[2:0];

endmodule
