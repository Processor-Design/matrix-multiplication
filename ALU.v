`timescale 1ns / 1ps

module ALU(control_signal,A_in,C_out,B_in,Z
    );

input [2:0] control_signal;
input [23:0] A_in;
input [23:0] B_in;
output Z;
output reg [23:0] C_out;
reg Z;


parameter ADD=3'd0, MUL=3'd1,
		SUB=3'd2, 
	    SFTR=3'd3,               //shift right
        SFTL=3'd4;               //shift left
	
always @(control_signal or A_in or B_in)
	begin
		case (control_signal)
			MUL: 
				begin
					C_out=A_in*B_in;
					Z=(C_out==0)?1'b1:1'b0;
				end
			ADD:
				begin
					C_out=A_in+B_in;
					Z=(C_out==0)?1'b1:1'b0;
				end
			SUB:
				begin
					C_out=A_in-B_in;
					Z=(C_out==0)?1'b1:1'b0;
				end
			SFTR:
				begin
					C_out=A_in>>8;
					Z=(C_out==0)?1'b1:1'b0;
				end
			SFTL: 
				begin
					C_out=A_in<<8;
					Z=(C_out==0)?1'b1:1'b0;
				end
			
		endcase
	end
	
endmodule
