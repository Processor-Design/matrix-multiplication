module bus(clk,pc,ir,ar,ac,x,y,z,stxy,styz,stxz,r,r1,r2,r3,dm,im,dr,busout,read_en);

input clk;
input [4:0] read_en;

localparam
bus_width =24;

input [15:0] pc;
input [15:0] ir;
input [15:0] ar;
input [23:0] ac;
input [7:0] x;
input [7:0] y;
input [7:0] z;
input [15:0] stxy;
input [15:0] styz;
input [15:0] stxz;
input [15:0] r;
input [7:0] r1;
input [23:0] r2;
input [15:0] r3;
input [7:0] dm;
input [15:0] im;
input [7:0] dr;
output reg [bus_width-1:0] busout;

always @(r or r1 or r2 or r3 or x or y or z or stxy or styz or stxz or ar or ir or pc or ac or im or 
dm or read_en or dr)
	begin
		case(read_en)
			5'd1: busout <= im;
			5'd2: busout <= dm;
			5'd3:	busout <= pc;
			5'd4:	busout <= ir;
			5'd5: busout <= ar;
			5'd6:	busout <= ac;
			5'd7:	busout <= x;
			5'd8:	busout <= y;
         	5'd9:	busout <= z;
			5'd10: busout <= stxy;
			5'd11: busout <= styz;
			5'd12: busout <= stxz;
			5'd13: busout <= r;
			5'd14: busout <= r1;
			5'd15: busout <= r2;
			5'd16: busout <= r3;
			5'd17: busout <= dr;
			default: busout <= 24'd0;
		endcase
	end
endmodule