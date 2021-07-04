`timescale 1ns/1ps
module IROM_tb;
	reg clock;
	reg [7:0] address;
	wire [15:0] q;


	// Clock
	initial 
		begin
			clock = 1'b0;
			forever begin
				#1 clock = ~clock;
			end
		end

IROM IROM1 (
	.address(address),
	.clock(clock),
	.q(q));


	// Test
	initial 
		begin
			#1 
			address = 8'd1;
			#2 
			address = 8'd10;
			#2
			address = 8'd100;
            #2
			
			$stop;
		end
endmodule
	