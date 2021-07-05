module memory_controller(Q,DATA,write_en,address,q11,q12,q13,q14,q2,q31,q32,q33,q34,wren,data11,data12,
data13,data14,data2, data31,data32,data33,data34,address1,address2,address3);

input write_en; 
output [31:0] Q;
input [31:0] DATA;
input [15:0] address;

input wire [7:0] q11;
input wire [7:0] q12;
input wire [7:0] q13;
input wire [7:0] q14;
input wire [7:0] q2;
input wire [7:0] q31;
input wire [7:0] q32;
input wire [7:0] q33;
input wire [7:0] q34;
output wire wren1;
output wire wren2;
output wire wren3;
output wire [11:0] address1;
output wire [11:0] address2;
output wire [11:0] address3;
output wire [7:0] data11;
output wire [7:0] data12;
output wire [7:0] data13;
output wire [7:0] data14;
output wire [7:0] data2;
output wire [7:0] data31;
output wire [7:0] data32;
output wire [7:0] data33;
output wire [7:0] data34;

parameter DM1=4'b0000;
parameter DM2=4'b0001;
parameter DM3=4'b0010;

assign selector[3:0]=address[15:12];

always @(address)
    begin 
	case(selector)
        DM1:
            assign Q[7:0] <= q11 ;
            assign Q[15:8] <= q12 ;
            assign Q[23:16] <= q13 ;
            assign Q[31:24] <= q14 ;
			assign wren1 <= write_en;
            assign address1<=address[11:0];
            assign data11<= DATA[7:0]; 
            assign data12<= DATA[15:8]; 
            assign data13<= DATA[23:16]; 
            assign data14<= DATA[31:24]; 
		
		DM2:
            assign Q <= {q2,q2,q2,q2} ;
			assign wren2 <= write_en;
            assign address2<=address[11:0];
            assign data2<= DATA; 

        DM3:
            assign Q[7:0] <= q31 ;
            assign Q[15:8] <= q32 ;
            assign Q[23:16] <= q33 ;
            assign Q[31:24] <= q34 ;
			assign wren3 <= write_en;
            assign address3<=address[11:0];
            assign data31<= DATA[7:0]; 
            assign data32<= DATA[15:8]; 
            assign data33<= DATA[23:16]; 
            assign data44<= DATA[31:24]; 
		endcase
	end
endmodule