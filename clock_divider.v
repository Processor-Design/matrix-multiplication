module clock_divider 
#(parameter divider=1'b1)
(clockin,clockout);

input clockin;
output clockout;

reg clockout = 1'b0;
reg counter = 1'b0;

always @(posedge clockin)
	begin 
		counter <= counter + divider;
		if(counter == 1'b1)
			clockout <= ~clockout ;
	end
endmodule 