`timescale 1ns/1ps;

module game(
    input clk,
    input rst,

    input move_left,
    input move_right,

    output reg [9:0] board [0:19],

    output reg [9:0] piece [0:1],
    output reg [4:0] piece_y

);

wire fall;
slow_timer st(clk,rst,fall);

//line clear logic

integer i;
for (i = 0; i<20; i++) begin
    if (board[i]==10b'1111111111) begin
        board[i] <= 10b'0000000000
    end
end
