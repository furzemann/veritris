module slow_timer(

    input clk,
    input rst,

    output reg tick
);

reg [24:0] counter;

always @(posedge clk or posedge rst) begin

    if(rst) begin
        counter <= 0;
        tick <= 0;
    end

    else begin
        tick <= 0;
        if(counter == 24_999_999) begin
            counter <= 0;
            tick <= 1;
        end

        else begin
            counter <= counter + 1;
        end
    end
end

endmodule

