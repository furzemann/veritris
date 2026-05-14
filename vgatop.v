`timescale 1ns/1ps

module vgatop(input clk,
output H_sync,
output V_sync,
output [9:0] pixel_x,
output [9:0] pixel_y,
output visible);
wire divclk;
wire enable_vert_cnt;
wire [15:0] H_count_value;
wire [15:0] V_count_value;

clock_divider clockgen(clk,divclk);
horizontal_counter h_counter(divclk,enable_vert_cnt,H_count_value);
vertical_counter v_counter(divclk,enable_vert_cnt,V_count_value);

assign H_sync = (H_count_value < 96);
assign V_sync = (V_count_value < 96);

assign visible =
(H_count_value >=144 &&
 H_count_value <784 &&
 V_count_value >=35 &&
 V_count_value <515);

assign pixel_x =
    H_count_value - 144;

assign pixel_y =
    V_count_value - 35;

endmodule

