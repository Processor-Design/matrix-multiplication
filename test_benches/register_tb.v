`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module register_tb();


localparam period = 20;
localparam word_size = 16; 
localparam increment = 1;

reg [word_size-1:0] data_in;
reg rst,inc,clk,write_en;
wire [word_size-1:0] data_out;

initial begin
    clk = 1'b0;
    forever begin
        #(period/2);
        clk = ~clk;
    end
end

Register #(.word_size(word_size),.increment(increment)) register_test(.clk(clk),.write_en(write_en),.data_in(data_in),.inc(inc),.rst(rst), .data_out(data_out));

initial begin
    @(posedge clk);
    rst <=0;

    @(posedge clk);
    rst <= 1;
    data_in <= 20;
    write_en <= 0;

    @(posedge clk);
    data_in <= 43;
    write_en <= 1;
    
    repeat (10) @(posedge clk) begin
        data_in <= $random;
        write_en <= $random;
        $display("%16b",data_in);
    end

    $stop;
end
endmodule