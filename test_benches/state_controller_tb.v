`timescale 1ns / 10ps

module state_controller_tb();

reg clock,process_finish,process_ready;
wire [1:0] status;
wire g1;
wire g2;
wire g3;


localparam period = 20;

initial begin
    clock = 1'b0;
    forever begin
        #(period/2);
        clock = ~clock;
    end
end

state_controller state_controller_test(.clock(clock),.process_finish(process_finish),.process_ready(process_ready),
.status(status), .g1(g1),.g2(g2),.g3(g3));

initial begin

    @(posedge clock);
    process_finish <= 1;
    process_ready <= 1;

    @(posedge clock);
    process_finish <= 1;
    process_ready <= 0;

    @(posedge clock);
    process_finish <= 0;
    process_ready <= 1;

    @(posedge clock);
    process_finish <= 1;
    process_ready <= 1;

    @(posedge clock);
    process_finish <= 0;
    process_ready <= 0;


    #10

    $stop;
end

endmodule 