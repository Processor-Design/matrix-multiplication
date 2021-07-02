module top_processor ( 
//input wire data_from_pc ,
input wire fast_clock ,
input wire start_process ,
//input wire start_transmit ,
//output wire data_to_pc ,
//output wire l0,
//output wire l1,
//output wire l2,
//output wire l3,
output wire g1,
output wire g2,
output wire g3,
output wire end_process);  
wire [7:0] dm_out;
wire [15:0] im_out;
wire [23:0] bus_out;
wire dm_en;
wire [15:0] ar_out;
wire im_en;
wire [15:0] pc_out;
//wire end_process ;
//wire end_transmitting ;
wire [1:0] status;
//wire [15:0] data_out_com ;
//wire en_com ;
//wire [15:0] addr_com ;
//wire [7:0] data_in_com ;
wire clock;
reg begin_process ;
//reg begin_transmit ;
wire [15:0] datain;
reg rst;
wire data_write_en ;
wire [15:0] data_addr ;
wire [15:0] instr_in ;
wire instr_write_en ;
wire [15:0] instr_addr ;
reg [9:0] process_switch_buffer = 10'd0;
//reg [9:0] transmit_switch_buffer = 10'd0;
always @(posedge clock)
begin
    if (start_process )
    begin
        if (process_switch_buffer == 10'd1023 )
        begin
            //process_switch_buffer <= process_switch_buffer ;
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

/*
always @(posedge clock)
begin
    if (start_transmit )
    begin
        if (transmit_switch_buffer == 10'd1023 )
        begin
            transmit_switch_buffer <= transmit_switch_buffer ;
            begin_transmit <=1;
        end
        else
        begin
            transmit_switch_buffer <= transmit_switch_buffer + 10'd1;
            begin_transmit <=0;
        end
    end
    else
    begin
        transmit_switch_buffer <= 10'd0;
        begin_transmit <= 0;
    end
end
*/

processor processor1( .dm_out(dm_out),
 .im_out(im_out),
 .status(status),
 .rst(rst),
 .dm_en(dm_en),
 .im_en(im_en),
 .pc_out(pc_out),
 .ar_out(ar_out),
 .bus_out(bus_out),
 .end_process()
);


main_control main_control1 (
.clk(clock),
//.end_receiving (end_receiving ),
.process_finish (end_process),
//.end_transmitting (end_transmitting ),
.process_ready (begin_process ),
//.begin_transmit (begin_transmit ),
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

