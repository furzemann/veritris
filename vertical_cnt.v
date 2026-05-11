`timescale 1ns/1ps

module verical_cnt(input clk,
    input enable_vert_cnt,
    output reg [15:0] V_count_value = 0);
    always @(posedge clk) begin
        if (V_count_value < 525 && enable_vert_cnt == 1'b1) begin
            V_count_value <= V_count_value + 1;
        end 
        else begin
            V_count_value <= 0
        end 
    end
endmodule
