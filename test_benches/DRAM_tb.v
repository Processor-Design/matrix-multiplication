`timescale 1ns/1ps
module DRAM_tb;
	reg clock;
	reg [16:0] address;
	reg  wren;
	reg  [7:0] data;
	wire [7:0] q;
	
	// Clock
	initial 
		begin
			clock = 1'b0;
			forever begin
				#1 clock = ~clock;
			end
		end
	
DRAM DRAM (
	.address(address),
	.clock(clock),
	.data(data),
	.wren(wren),
	.q(q));
	
	// Test
	initial 
		begin
			#1 
			wren = 1'd0;
			address = 16'd5;
			#2 
			wren = 1'd1;
			address = 16'd5;
			#3
			wren = 1'd0;
			address = 16'd400;
			#4
			
			$stop;
		end
endmodule