`timescale 1ns/1ps

module renderer(

    input [9:0] board [0:19],
    input [9:0] piece [0:3],
    input [4:0] piece_y,

    input [9:0] pixel_x,
    input [9:0] pixel_y,

    output [3:0] Red,
    output [3:0] Green,
    output [3:0] Blue
);

/////////////////////////////////////////////////
// Layout
/////////////////////////////////////////////////

parameter BLOCK_SIZE = 20;

parameter X_OFFSET = 220;
parameter Y_OFFSET = 40;

/////////////////////////////////////////////////
// Convert pixel -> board coordinates
/////////////////////////////////////////////////

wire inside_board;

assign inside_board =

(pixel_x >= X_OFFSET) &&
(pixel_x < X_OFFSET + 10*BLOCK_SIZE) &&

(pixel_y >= Y_OFFSET) &&
(pixel_y < Y_OFFSET + 20*BLOCK_SIZE);

wire [3:0] board_x;
wire [4:0] board_y;

assign board_x =
    (pixel_x - X_OFFSET)/BLOCK_SIZE;

assign board_y =
    (pixel_y - Y_OFFSET)/BLOCK_SIZE;

/////////////////////////////////////////////////
// Occupancy
/////////////////////////////////////////////////

reg occupied;

always @(*) begin

    occupied = 0;

    if(inside_board) begin

        /////////////////////////////////////////
        // Locked board cells
        /////////////////////////////////////////

        if(board[board_y][9-board_x])
            occupied=1;

        /////////////////////////////////////////
        // Falling piece
        /////////////////////////////////////////

        if(board_y>=piece_y &&
           board_y<piece_y+4)

            if(piece[board_y-piece_y]
                    [9-board_x])

                occupied=1;

    end

end

/////////////////////////////////////////////////
// Grid lines
/////////////////////////////////////////////////

wire grid;

assign grid =

((pixel_x-X_OFFSET)%BLOCK_SIZE==0) ||

((pixel_y-Y_OFFSET)%BLOCK_SIZE==0);

/////////////////////////////////////////////////
// RGB
/////////////////////////////////////////////////

assign Red =
    occupied ? 4'hF :
    grid ? 4'h4 :
    0;

assign Green =
    occupied ? 4'hF :
    grid ? 4'h4 :
    0;

assign Blue =
    occupied ? 4'hF :
    grid ? 4'h4 :
    0;

endmodule
