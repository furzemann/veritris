module debouncer (
    input clk,
    input btn_in,
    output reg btn_pulse
);
    reg [19:0] count;
    reg btn_reg;

    always @(posedge clk) begin
        if (btn_in == btn_reg) begin
            count <= 0;
        end else begin
            count <= count + 1;
            if (count == 20'd1000000) begin
                btn_reg <= btn_in;
            end
        end
    end

    reg btn_prev;
    always @(posedge clk) begin
        btn_prev <= btn_reg;
        btn_pulse <= (btn_reg && !btn_prev);
    end
endmodule
