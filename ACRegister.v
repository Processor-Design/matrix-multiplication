`timescale 1ns / 1ps

module ACRegister(clk,data_in,data_out,write_en,alu_to_ac,alu_out,incre,rst);

localparam
word_size = 24;

input clk,write_en;
input incre,rst;
input alu_to_ac;
input [word_size-1:0] data_in;
input [word_size-1:0] alu_out;
output [word_size-1:0] data_out;
reg [word_size-1:0] data_out=0;


always @(posedge clk or negedge rst)
	begin
		if (rst==0)
        	data_out <= 0;
		else if (incre)
			data_out <= data_out + 16'b1;
		else if (write_en)
			data_out <= data_in;
		else if (alu_to_ac)
         data_out <= alu_out;
	end

endmodule