`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module ALU_tb;

reg [2:0] control_signal;
reg [23:0] A_in;
reg [23:0] B_in;
wire Z;
wire [23:0] C_out;

localparam period = 20;  

ALU alu_test(.control_signal(control_signal), .A_in(A_in), .C_out(C_out), .B_in(B_in), .Z(Z));
reg clk;

initial begin
    clk = 1'b0;
    forever begin
        #(period/2);
        clk = ~clk;
    end
end


initial begin
    @(posedge clk);
    A_in <= 1;
    B_in <= 2;
    control_signal <= 0;

    @(posedge clk);
    A_in <= 1;
    B_in <= 2;
    control_signal <= 1;

    @(posedge clk);
    A_in <= 1;
    B_in <= 2;
    control_signal <= 2;

    @(posedge clk);
    A_in <= 1024;
    control_signal <= 3;

    @(posedge clk);
    A_in <= 1;
    control_signal <= 4;

    @(posedge clk);
    A_in <= 0;
    B_in <= 2;
    control_signal <= 0;

    $stop;
end

endmodule