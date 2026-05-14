module debouncer(
    input clk,
    input btn,
    output reg fin,
);

reg [19:0] counter;
reg curr;

always @(posegde clk) begin
    curr <= btn;
    if (curr!=fin) begin
        counter <= counter + 1;
        if (counter == 100000) begin
            fin <= btn;
            counter <= 0;
        end
    end
    else 
        counter <= 0;

end 
endmodule

