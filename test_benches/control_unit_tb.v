`timescale 1ns / 10ps

module control_unit_tb();


reg clk,Z;
reg [15:0] instruction;
reg [1:0] status;

wire finish;
wire [16:0] write_enable;
wire [4:0] read_enable;
wire [6:0] increment;
wire [2:0] alu;

localparam period = 20;

initial begin
    clk = 1'b0;
    forever begin
        #(period/2);
        clk = ~clk;
    end
end

control_unit control_unit_test(.clk(clk),.Z(Z),.instruction(instruction),.status(status),.finish(finish), .write_enable(write_enable),
.read_enable(read_enable), .increment(increment), .alu(alu));

initial begin
    @(posedge clk);
    Z <= 1;

    @(posedge clk);
    Z <= 0;
    status <= 2;

    @(posedge clk);
    Z <=1;
    status <= 3;
    instruction <= 20;
    
    repeat (10) @(posedge clk) begin
        instruction <= $random;
        status <= $random;
        $display("%16b",instruction);
    end

    $stop;
end

endmodule 