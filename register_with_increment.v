`timescale 1ns / 1ps

module register_with_increment(clk,data_in,data_out,write_en,incre
    );
word_size=16;
input clk,write_en;
input incre;
input [word_size-1:0] data_in;
output [word_size-1:0] data_out;
reg [word_size-1:0] data_out=0;

always @(posedge clk)
	begin
		if (write_en)
			data_out <= data_in;
		if (incre)
			data_out <= data_out + 16'b1;
	end

endmodule