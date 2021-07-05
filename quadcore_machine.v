module quadcore_machine ( 
input wire fast_clock ,
input wire start_process ,
//input wire [7:0] pc_out1,
output wire g1,
output wire g2,
output wire g3,
output wire [1:0] status
//output wire [15:0] temp_out
);  
wire [31:0] dm_out;
wire [15:0] im_out;
wire [31:0] bus_out;
wire dm_en;
wire [15:0] ar_out;
wire im_en;
wire [7:0] pc_out;
wire end_process0 ;
wire end_process1 ;
wire end_process2 ;
wire end_process3 ;
wire clock;
reg begin_process ;
wire [15:0] datain;
reg rst;
reg [9:0] process_switch_buffer = 10'd0;

always @(posedge clock)
begin
    if (start_process )
    begin
        if (process_switch_buffer == 10'd10 )
        begin
            begin_process <=1;
            rst <=0;
        end
        else
        begin
            process_switch_buffer <= process_switch_buffer + 10'd1;
            begin_process <=0;
            rst <= 1;
        end
    end 
    else 
    begin 
        process_switch_buffer <= 10'd0;
        begin_process <= 0;
        rst <= 0;
    end 
end



processor core0( .clock(clock),
 .dm_out(dm_out[7:0]),
 .im_out(im_out),
 .status(status),
 .rst_r(rst),
 .dm_en(dm_en),
 .pc_out(pc_out),
 .ar_out(ar_out),
 .bus_out(bus_out[7:0]),
 .end_process(end_process0)
);

processor core1( .clock(clock),
 .dm_out(dm_out[15:8]),
 .im_out(im_out),
 .status(status),
 .rst_r(rst),
 //.dm_en(dm_en),
 //.pc_out(pc_out),
 //.ar_out(ar_out),
 .bus_out(bus_out[15:8])
 //.end_process(end_process)
);

processor core2( .clock(clock),
 .dm_out(dm_out[23:16]),
 .im_out(im_out),
 .status(status),
 .rst_r(rst),
 //.dm_en(dm_en),
 //.pc_out(pc_out),
 //.ar_out(ar_out),
 .bus_out(bus_out[23:16])
 //.end_process(end_process)
);

processor core3( .clock(clock),
 .dm_out(dm_out[31:24]),
 .im_out(im_out),
 .status(status),
 .rst_r(rst),
 //.dm_en(dm_en),
 //.pc_out(pc_out),
 //.ar_out(ar_out),
 .bus_out(bus_out[31:24])
 //.end_process(end_process)
);

state_controller State_controller_1 (
.clock(clock),
.process_finish (end_process0),
.process_ready (begin_process ),
.status(status),
.g1(g1),
.g2(g2),
.g3(g3)
);

clock_divider clock_divider1(
.clockin(fast_clock),
.clockout(clock)
);

// DRAM_copy datamemory(
// .address(ar_out),
// .clock(~clock),
// .data(bus_out),
// .wren(dm_en),
// .q(dm_out)
// );

Memory memory1(
    .address(ar_out),
    .clock(~clock),
    .data(bus_out),
    .wren(dm_en),
    .q(dm_out)
);



IROM instructionmemory(
.address(pc_out),
.clock(clock),
.q(im_out)
);

// IROM_PROXY instructionmemory(
// .clock(clock),
// .address(pc_out1),
// .q(temp_out)
// );

endmodule
