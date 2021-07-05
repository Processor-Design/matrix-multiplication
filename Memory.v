module Memory (
    input wire clock,
    input wire[31:0] data,
    input wire[15:0] address,
    input wire wren,
    output wire[31:0] q
);

wire[10:0] address1;
wire[10:0] address2;
wire[10:0] address3;

wire wren1;
wire wren2;
wire wren3;

wire[7:0] data11;
wire[7:0] data12;
wire[7:0] data13;
wire[7:0] data14;

wire[7:0] data2;

wire[7:0] data31;
wire[7:0] data32;
wire[7:0] data33;
wire[7:0] data34;

wire[7:0] q11;
wire[7:0] q12;
wire[7:0] q13;
wire[7:0] q14;

wire[7:0] q2;

wire[7:0] q31;
wire[7:0] q32;
wire[7:0] q33;
wire[7:0] q34;


DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAM_DataInt_M11.mif"),
          .(DEPTH(1038)),
          .ADDWIDTH(11)) 
            M11(
            .address(address1),
            .clock(clock),
            .data(data11),
            .wren(wren1),
            .q(q11)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAM_DataInt_M12.mif"),
          .(DEPTH(1038)),
          .ADDWIDTH(11)) 
            M12(
            .address(address1),
            .clock(clock),
            .data(data12),
            .wren(wren1),
            .q(q12)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAM_DataInt_M13.mif"),
          .(DEPTH(1038)),
          .ADDWIDTH(11)) 
            M13(
            .address(address1),
            .clock(clock),
            .data(data13),
            .wren(wren1),
            .q(q13)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAM_DataInt_M14.mif"),
          .(DEPTH(1038)),
          .ADDWIDTH(11)) 
            M14(
            .address(address1),
            .clock(clock),
            .data(data14),
            .wren(wren1),
            .q(q14)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAM_DataInt_M2.mif"),
          .(DEPTH(4096)),
          .ADDWIDTH(12)) 
            M2(
            .address(address2),
            .clock(clock),
            .data(data2),
            .wren(wren2),
            .q(q2)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAM_DataInt_M31.mif"),
          .(DEPTH(3072)),
          .ADDWIDTH(12)) 
            M31(
            .address(address3),
            .clock(clock),
            .data(data31),
            .wren(wren3),
            .q(q31)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAM_DataInt_M32.mif"),
          .(DEPTH(3072)),
          .ADDWIDTH(12)) 
            M32(
            .address(address3),
            .clock(clock),
            .data(data32),
            .wren(wren3),
            .q(q32)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAM_DataInt_M33.mif"),
          .(DEPTH(3072)),
          .ADDWIDTH(12)) 
            M33(
            .address(address3),
            .clock(clock),
            .data(data33),
            .wren(wren3),
            .q(q33)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAM_DataInt_M34.mif"),
          .(DEPTH(3072)),
          .ADDWIDTH(12)) 
            M34(
            .address(address4),
            .clock(clock),
            .data(data34),
            .wren(wren3),
            .q(q34)
            );
    
endmodule

  assign Q = {q2,q2,q2,q2}