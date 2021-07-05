module memory_controller(Q,DATA,write_en,address,q11,q12,q13,q14,q2,q31,q32,q33,q34,wren1,wren2,wren3,data11,data12,
data13,data14,data2, data31,data32,data33,data34,address1,address2,address3);

input write_en; 
output reg[31:0] Q;
input [31:0] DATA;
input [15:0] address;

input [7:0] q11;
input [7:0] q12;
input [7:0] q13;
input [7:0] q14;
input [7:0] q2;
input [7:0] q31;
input [7:0] q32;
input [7:0] q33;
input [7:0] q34;
output reg wren1;
output reg wren2;
output reg wren3;
output reg [11:0] address1;
output reg [11:0] address2;
output reg [11:0] address3;
output reg [7:0] data11;
output reg [7:0] data12;
output reg [7:0] data13;
output reg [7:0] data14;
output reg [7:0] data2;
output reg [7:0] data31;
output reg [7:0] data32;
output reg [7:0] data33;
output reg [7:0] data34;


localparam DM1=4'b0000;
localparam DM2=4'b0001;
localparam DM3=4'b0010;

always @*
    begin 
        case(address[15:12])
            DM1:
                begin
                    Q[7:0] <= q11 ;
                    Q[15:8] <= q12 ;
                    Q[23:16] <= q13 ;
                    Q[31:24] <= q14 ;
                    wren1 <= write_en;
                    address1 <= address[11:0];
                    data11 <= DATA[7:0]; 
                    data12 <= DATA[15:8]; 
                    data13 <= DATA[23:16]; 
                    data14 <= DATA[31:24]; 
                    wren2 <= 0;
                    wren3 <= 0;
                end
            DM2:
                begin
                    Q <= {q2,q2,q2,q2} ;
                    wren2 <= write_en;
                    address2 <=address[11:0];
                    data2 <= DATA; 
                    wren1 <= 0;
                    wren3 <= 0;
                end
            DM3:
                begin
                    Q[7:0] <= q31 ;
                    Q[15:8] <= q32 ;
                    Q[23:16] <= q33 ;
                    Q[31:24] <= q34 ;
                    wren3 <= write_en;
                    address3 <=address[11:0];
                    data31 <= DATA[7:0]; 
                    data32 <= DATA[15:8]; 
                    data33 <= DATA[23:16]; 
                    data34 <= DATA[31:24]; 
                    wren1 <= 0;
                    wren2 <= 0;
                end
        endcase
	end
endmodule