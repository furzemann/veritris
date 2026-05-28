module nexys_tetris_top (
    input CLK100MHZ,       
    input BTNC, BTNL, BTNR, BTNU,
    output VGA_HS, VGA_VS,
    output [3:0] VGA_R, VGA_G, VGA_B,
    output [7:0] AN, 
    output [6:0] SEG 
);
    wire clk_25, video_on, gravity_tick;
    wire [9:0] x_pix, y_pix;
    
    // Explicit 12-bit wire
    wire [11:0] engine_rgb; 
    
    wire p_l, p_r, p_u;
    wire [15:0] current_score;

    ClockMod c1 (.clock(CLK100MHZ), .reset(BTNC), .mod_clock(clk_25));
    
    debouncer dL (.clk(clk_25), .btn_in(BTNL), .btn_pulse(p_l));
    debouncer dR (.clk(clk_25), .btn_in(BTNR), .btn_pulse(p_r));
    debouncer dU (.clk(clk_25), .btn_in(BTNU), .btn_pulse(p_u));

    reg [26:0] grav_cnt;
    always @(posedge clk_25 or posedge BTNC) begin
        if (BTNC) grav_cnt <= 0;
        else grav_cnt <= (grav_cnt == 25000000) ? 0 : grav_cnt + 1;
    end
    assign gravity_tick = (grav_cnt == 25000000);

    vga_controller v1 (
        .clk_25(clk_25), .reset(BTNC),
        .hsync(VGA_HS), .vsync(VGA_VS),
        .video_on(video_on), .x_loc(x_pix), .y_loc(y_pix)
    );

    tetris_engine engine (
        .clk(clk_25), .reset(BTNC),
        .btn_l(p_l), .btn_r(p_r), .btn_u(p_u),
        .gravity_tick(gravity_tick),
        .x_loc(x_pix), .y_loc(y_pix),
        .video_on(video_on),
        .rgb_out(engine_rgb), // Passing full 12 bits
        .score(current_score) 
    );

    seven_seg_driver display (
        .clk(clk_25), .reset(BTNC),
        .score(current_score), 
        .AN(AN), .SEG(SEG)              
    );

    // Split the 12-bit internal RGB into the physical 4-bit VGA channels
    assign VGA_R = (video_on) ? engine_rgb[11:8] : 4'h0;
    assign VGA_G = (video_on) ? engine_rgb[7:4]  : 4'h0;
    assign VGA_B = (video_on) ? engine_rgb[3:0]  : 4'h0;

endmodule
