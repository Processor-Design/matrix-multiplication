`timescale 1ns / 1ps

module Register
#( parameter word_size = 16,
   parameter increment = 1)
(
    input clk,
    input write_en,
    input [word_size-1:0] data_in,
    input inc,
    input rst,
    output reg [word_size-1:0] data_out
);


always @(posedge clk or posedge rst)
	begin
		if (write_en)
			data_out <= data_in;
		else if (inc)
			data_out <= data_out + {word_size{1'b0}} +increment ;
		else if (rst)
			data_out <= 16'b0;
	end

endmodule