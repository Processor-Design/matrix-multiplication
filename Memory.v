module Memory (
    input wire clock,
    input wire[31:0] data,
    input wire[15:0] address,
    input wire wren,
    output wire[31:0] q
);

wire[10:0] address1;
wire[11:0] address2;
wire[11:0] address3;

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

memory_controller memory_control(
  .Q(q),
  .DATA(data),
  .write_en(wren),
  .address(address),
  .q11(q11),
  .q12(q12),
  .q13(q13),
  .q14(q14),
  .q2(q2),
  .q31(q31),
  .q32(q32),
  .q33(q33),
  .q34(q34),
  .wren1(wren1),
  .wren2(wren2),
  .wren3(wren3),
  .data11(data11),
  .data12(data12),
  .data13(data13),
  .data14(data14),
  .data2(data2), 
  .data31(data31),
  .data32(data32),
  .data33(data33),
  .data34(data34),
  .address1(address1),
  .address2(address2),
  .address3(address3));



DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAMInit_M11.mif"),
          .DEPTH(1038),
          .ADDWIDTH(11)) 
            M11(
            .address(address1),
            .clock(clock),
            .data(data11),
            .wren(wren1),
            .q(q11)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAMInit_M12.mif"),
          .DEPTH(1038),
          .ADDWIDTH(11)) 
            M12(
            .address(address1),
            .clock(clock),
            .data(data12),
            .wren(wren1),
            .q(q12)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAMInit_M13.mif"),
          .DEPTH(1038),
          .ADDWIDTH(11)) 
            M13(
            .address(address1),
            .clock(clock),
            .data(data13),
            .wren(wren1),
            .q(q13)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAMInit_M14.mif"),
          .DEPTH(1038),
          .ADDWIDTH(11)) 
            M14(
            .address(address1),
            .clock(clock),
            .data(data14),
            .wren(wren1),
            .q(q14)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAMInit_M2.mif"),
          .DEPTH(4096),
          .ADDWIDTH(12)) 
            M2(
            .address(address2),
            .clock(clock),
            .data(data2),
            .wren(wren2),
            .q(q2)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAMInit_M31.mif"),
          .DEPTH(3072),
          .ADDWIDTH(12)) 
            M31(
            .address(address3),
            .clock(clock),
            .data(data31),
            .wren(wren3),
            .q(q31)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAMInit_M32.mif"),
          .DEPTH(3072),
          .ADDWIDTH(12)) 
            M32(
            .address(address3),
            .clock(clock),
            .data(data32),
            .wren(wren3),
            .q(q32)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAMInit_M33.mif"),
          .DEPTH(3072),
          .ADDWIDTH(12)) 
            M33(
            .address(address3),
            .clock(clock),
            .data(data33),
            .wren(wren3),
            .q(q33)
            );

DRAM_copy #(.MIF("./python_scripts/MemInitFiles/DRAMInit_M34.mif"),
          .DEPTH(3072),
          .ADDWIDTH(12)) 
            M34(
            .address(address3),
            .clock(clock),
            .data(data34),
            .wren(wren3),
            .q(q34)
            );
    
endmodule