module top_processor ( 
input wire fast_clock ,
input wire start_process ,
output wire g1,
output wire g2,
output wire g3
);  
wire [7:0] dm_out;
wire [15:0] im_out;
wire [23:0] bus_out;
wire dm_en;
wire [15:0] ar_out;
wire im_en;
wire [7:0] pc_out;
wire end_process ;
wire [1:0] status;
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



processor processor1( .clock(clock),
 .dm_out(dm_out),
 .im_out(im_out),
 .status(status),
 .rst_r(rst),
 .dm_en(dm_en),
 .im_en(im_en),
 .pc_out(pc_out),
 .ar_out(ar_out),
 .bus_out(bus_out),
 .end_process(end_process)
);

state_controller State_controller_1 (
.clock(clock),
.process_finish (end_process),
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

DRAM datamemory(
.address(ar_out),
.clock(clock),
.data(bus_out),
.wren(dm_en),
.q(dm_out)
);

IROM instructionmemory(
.address(pc_out),
.clock(clock),
.q(im_out)
);

endmodule
