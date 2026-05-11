`timescale 1ns/1ps

module horizontal_cnt(input clk,
    output reg enable_vert_cnt = 0,
    output reg [15:0] H_count_value = 0);
    always @(posedge clk) begin
        if (H_count_value < 800) begin
            H_count_value <= H_count_value+1;
            enable_vert_cnt <= 0;
        end 
        else begin
            H_count_value <= 0
            enable_vert_cnt <= 1;
        end 
    end
endmodule
