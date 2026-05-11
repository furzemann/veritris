`timescale 1ns/1ps

module vgatop(input clk,
output H_sync,
output V_sync,
output [3:0] Red,
output [3:0] Green,
output [3:0] Blue);
wire divclk;
wire enable_vert_cnt;
wire [15:0] H_count_value;
wire [15:0] V_count_value;

clock_divider clockgen(clk,divclk);
horizontal_counter h_counter(divclk,enable_vert_cnt,H_count_value);
vertical_counter v_counter(divclk,enable_vert_cnt,V_count_value);

assign H_sync = (H_count_value < 96) ? 1'b1:1'b0;
assign V_sync = (V_count_value < 96) ? 1'b1:1'b0;

assign Red = (H_count_value < 784 && H_count_value > 143 && V_count_value < 515 &&& V_count_value>35) ? 4'hF:4'h0;
assign Green = (H_count_value < 784 && H_count_value > 143 && V_count_value < 515 &&& V_count_value>35) ? 4'hF:4'h0;
assign Blue = (H_count_value < 784 && H_count_value > 143 && V_count_value < 515 &&& V_count_value>35) ? 4'hF:4'h0;
endmodule

