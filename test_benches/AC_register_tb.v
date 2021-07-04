`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module AC_register_tb();

localparam period = 20;
localparam word_size = 24;

reg clk,write_en;
reg incre,rst;
reg alu_to_ac;
reg [word_size-1:0] data_in;
reg [word_size-1:0] alu_out;
wire [word_size-1:0] data_out;


initial begin
    clk = 1'b0;
    forever begin
        #(period/2);
        clk = ~clk;
    end
end


ACRegister AC_test(.clk(clk),.data_in(data_in), .data_out(data_out),.write_en(write_en),.alu_to_ac(alu_to_ac),.alu_out(alu_out),.incre(incre),.rst(rst));


initial begin
    @(posedge clk);
    rst <=1;

    @(negedge clk);
    rst <= 0;
    data_in <= 20;
    write_en <= 1;

     @(posedge clk);
	alu_to_ac <= 1;
    alu_out <= 64;

    @(posedge clk);
    data_in <= 43;
    alu_to_ac <= 0;
	 
    
    repeat (10) @(negedge clk) begin
        data_in <= $random;
        write_en <= $random;
        $display("%24b",data_in);
    end

    $stop;
end
endmodule