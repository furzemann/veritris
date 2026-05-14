`timescale 1ns/1ps

module game(
    input clk,
    input rst,

    input move_left,
    input move_right,
    input rotate,

    output reg [9:0] board [0:19],
    output reg [9:0] piece [0:3],
    output reg [4:0] piece_y
);

wire fall;
slow_timer st(clk,rst,fall);

reg [2:0] piece_type;
reg [1:0] rotation;

integer i,j;

reg [9:0] piece_rom [0:6][0:3][0:3];

// PIECE ROM

reg [9:0] piece_rom [0:6][0:3][0:3];

initial begin

//Square

piece_rom[0][0][0]=10'b0000110000;
piece_rom[0][0][1]=10'b0000110000;
piece_rom[0][0][2]=0;
piece_rom[0][0][3]=0;

piece_rom[0][1][0]=10'b0000110000;
piece_rom[0][1][1]=10'b0000110000;
piece_rom[0][1][2]=0;
piece_rom[0][1][3]=0;

piece_rom[0][2][0]=10'b0000110000;
piece_rom[0][2][1]=10'b0000110000;
piece_rom[0][2][2]=0;
piece_rom[0][2][3]=0;

piece_rom[0][3][0]=10'b0000110000;
piece_rom[0][3][1]=10'b0000110000;
piece_rom[0][3][2]=0;
piece_rom[0][3][3]=0;

//L piece

piece_rom[1][0][0]=0;
piece_rom[1][0][1]=10'b0001111000;
piece_rom[1][0][2]=0;
piece_rom[1][0][3]=0;


piece_rom[1][1][0]=10'b0000100000;
piece_rom[1][1][1]=10'b0000100000;
piece_rom[1][1][2]=10'b0000100000;
piece_rom[1][1][3]=10'b0000100000;

piece_rom[1][2][0]=0;
piece_rom[1][2][1]=10'b0001111000;
piece_rom[1][2][2]=0;
piece_rom[1][2][3]=0;

piece_rom[1][3][0]=10'b0000100000;
piece_rom[1][3][1]=10'b0000100000;
piece_rom[1][3][2]=10'b0000100000;
piece_rom[1][3][3]=10'b0000100000;


// T piece

piece_rom[2][0][0]=10'b0000100000;
piece_rom[2][0][1]=10'b0001110000;
piece_rom[2][0][2]=0;
piece_rom[2][0][3]=0;

piece_rom[2][1][0]=10'b0000100000;
piece_rom[2][1][1]=10'b0000110000;
piece_rom[2][1][2]=10'b0000100000;
piece_rom[2][1][3]=0;

piece_rom[2][2][0]=0;
piece_rom[2][2][1]=10'b0001110000;
piece_rom[2][2][2]=10'b0000100000;
piece_rom[2][2][3]=0;

piece_rom[2][3][0]=10'b0000100000;
piece_rom[2][3][1]=10'b0001100000;
piece_rom[2][3][2]=10'b0000100000;
piece_rom[2][3][3]=0;


// L piece

piece_rom[3][0][0]=10'b0000010000;
piece_rom[3][0][1]=10'b0001110000;
piece_rom[3][0][2]=0;
piece_rom[3][0][3]=0;

piece_rom[3][1][0]=10'b0000110000;
piece_rom[3][1][1]=10'b0000100000;
piece_rom[3][1][2]=10'b0000100000;
piece_rom[3][1][3]=0;

piece_rom[3][2][0]=0;
piece_rom[3][2][1]=10'b0001110000;
piece_rom[3][2][2]=10'b0001000000;
piece_rom[3][2][3]=0;

piece_rom[3][3][0]=10'b0000100000;
piece_rom[3][3][1]=10'b0000100000;
piece_rom[3][3][2]=10'b0001100000;
piece_rom[3][3][3]=0;


// J piece

piece_rom[4][0][0]=10'b0001000000;
piece_rom[4][0][1]=10'b0001110000;
piece_rom[4][0][2]=0;
piece_rom[4][0][3]=0;

piece_rom[4][1][0]=10'b0000100000;
piece_rom[4][1][1]=10'b0000100000;
piece_rom[4][1][2]=10'b0000110000;
piece_rom[4][1][3]=0;

piece_rom[4][2][0]=0;
piece_rom[4][2][1]=10'b0001110000;
piece_rom[4][2][2]=10'b0000010000;
piece_rom[4][2][3]=0;

piece_rom[4][3][0]=10'b0001100000;
piece_rom[4][3][1]=10'b0000100000;
piece_rom[4][3][2]=10'b0000100000;
piece_rom[4][3][3]=0;


// S piece

piece_rom[5][0][0]=10'b0000110000;
piece_rom[5][0][1]=10'b0001100000;
piece_rom[5][0][2]=0;
piece_rom[5][0][3]=0;

piece_rom[5][1][0]=10'b0000100000;
piece_rom[5][1][1]=10'b0000110000;
piece_rom[5][1][2]=10'b0000010000;
piece_rom[5][1][3]=0;

piece_rom[5][2][0]=10'b0000110000;
piece_rom[5][2][1]=10'b0001100000;
piece_rom[5][2][2]=0;
piece_rom[5][2][3]=0;

piece_rom[5][3][0]=10'b0000100000;
piece_rom[5][3][1]=10'b0000110000;
piece_rom[5][3][2]=10'b0000010000;
piece_rom[5][3][3]=0;


// Z piece

piece_rom[6][0][0]=10'b0001100000;
piece_rom[6][0][1]=10'b0000110000;
piece_rom[6][0][2]=0;
piece_rom[6][0][3]=0;

piece_rom[6][1][0]=10'b0000010000;
piece_rom[6][1][1]=10'b0000110000;
piece_rom[6][1][2]=10'b0000100000;
piece_rom[6][1][3]=0;

piece_rom[6][2][0]=10'b0001100000;
piece_rom[6][2][1]=10'b0000110000;
piece_rom[6][2][2]=0;
piece_rom[6][2][3]=0;

piece_rom[6][3][0]=10'b0000010000;
piece_rom[6][3][1]=10'b0000110000;
piece_rom[6][3][2]=10'b0000100000;
piece_rom[6][3][3]=0;

end/////////////////////////////////////////////////
wire [2:0] rand_piece 
wire left_wall;
wire right_wall;

lfsr_rng rng(
    .clk(clk),
    .rst(rst),
    .rand_piece(rand_piece)
);

assign left_wall=
piece[0][9]|
piece[1][9]|
piece[2][9]|
piece[3][9];

assign right_wall=
piece[0][0]|
piece[1][0]|
piece[2][0]|
piece[3][0];

wire collision;

assign collision=
((piece[0]&board[piece_y+1])!=0)||
((piece[1]&board[piece_y+2])!=0)||
((piece[2]&board[piece_y+3])!=0)||
((piece[3]&board[piece_y+4])!=0);

wire floor_collision;

assign floor_collision=(piece_y>=18);

task spawn_piece;
begin

piece_type <= rand_piece;
rotation<=0;

piece_y<=0;

for(i=0;i<4;i=i+1)
    piece[i]<=piece_rom[0][0][i];

end
endtask

task clear_lines;
begin

for(i=0;i<20;i=i+1) begin

    if(board[i]==10'b1111111111) begin

        for(j=i;j>0;j=j-1)
            board[j]<=board[j-1];

        board[0]<=0;

    end

end

end
endtask

always @(posedge clk or posedge rst) begin

if(rst) begin

    for(i=0;i<20;i=i+1)
        board[i]<=0;

    spawn_piece();

end

else begin

if(move_left && !left_wall) begin

    for(i=0;i<4;i=i+1)
        piece[i]<=piece[i]<<1;

end


if(move_right && !right_wall) begin

    for(i=0;i<4;i=i+1)
        piece[i]<=piece[i]>>1;

end

if(rotate) begin

    rotation<=rotation+1;

    for(i=0;i<4;i=i+1)
        piece[i]<=piece_rom[piece_type]
                           [(rotation+1)&2'b11]
                           [i];

end

/////////////////////////////////////////////////
// FALL
/////////////////////////////////////////////////

if(fall) begin

    if(collision || floor_collision) begin

        board[piece_y+0]
        <=board[piece_y+0]|piece[0];

        board[piece_y+1]
        <=board[piece_y+1]|piece[1];

        board[piece_y+2]
        <=board[piece_y+2]|piece[2];

        board[piece_y+3]
        <=board[piece_y+3]|piece[3];

        clear_lines();

        spawn_piece();

    end

    else begin
        piece_y<=piece_y+1;
    end

end

end
end

endmodule
