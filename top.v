`timescale 1ns/1ps;

module top(input clk, 
    input rst, 
    input move_left,
    input move_right, 
    input rotate,
    output H_sync,
    output V_sync,

    output [3:0] Red,
    output [3:0] Green,
    output [3:0] Blue);

wire [9:0] pixel_x;
wire [9:0] pixel_y;
wire visible;

wire [9:0] board[0:19];
wire [9:0] piece[0:3];
wire [4:0] piece_y;

wire [3:0] r,g,b;

vgatop vga(
    .clk(clk),

    .H_sync(H_sync),
    .V_sync(V_sync),

    .pixel_x(pixel_x),
    .pixel_y(pixel_y),

    .visible(visible)
);

game g(.clk(clk),
    .rst(rst),

    .move_left(move_left),
    .move_right(move_right),
    .rotate(rotate),

    .board(board),
    .piece(piece),
    .piece_y(piece_y)
);

renderer r1(

    .board(board),
    .piece(piece),
    .piece_y(piece_y),

    .pixel_x(pixel_x),
    .pixel_y(pixel_y),

    .Red(r),
    .Green(g),
    .Blue(b)
);

assign Red=
    visible ? r:0;

assign Green=
    visible ? g:0;

assign Blue=
    visible ? b:0;

endmodule
