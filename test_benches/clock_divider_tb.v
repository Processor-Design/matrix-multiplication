`timescale 1ns / 10ps

module clock_divider_tb();

reg clockin;
wire clockout;

localparam period = 20;

initial begin
    clockin = 1'b0;
    repeat(32) begin
        #(period/2);
        clockin = ~clockin;
    end
end

clock_divider clock_divider_test(.clockin(clockin), .clockout(clockout));


endmodule 