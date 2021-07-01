module bus(clk,pc,ir,ar,ac,x,y,z,stxy,styz,stxz,r,r1,r2,r3,dm,im,busout,read_en);

input clk,read_en;

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
output reg [bus_width-1:0] busout;

always @(r or r1 or r2 or r3 or x or y or z or stxy or styz or stxz or ar or ir or pc or ac or im or 
dm or read_en )
	begin
		if(read_en)
			if(r) 
				busout <= r;
			if(r1) 
				busout <= r1;
			if(r2) 
				busout <= r2;
			if(r3) 
				busout <= r3;
			if(x) 
				busout <= x;
			if(y) 
				busout <= y;
			if(z) 
				busout <= z;
			if(stxy) 
				busout <= stxy;
			if(styz) 
				busout <= styz;
			if(stxz) 
				busout <= stxz;
			if(ar) 
				busout <= ar;
			if(ir) 
				busout <= ir;
			if(pc) 
				busout <= pc;
			if(ac) 
				busout <= ac;
			if(im) 
				busout <= im;
			if(dm) 
				busout <= dm;
				
			default: busout <= 24'd0;
		
	end
endmodule