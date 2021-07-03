module processor (input clock,
 input [7:0] dm_out,
 input [15:0] im_out,
 input [1:0] status,
 input rst_r,
 output reg dm_en,
 output reg im_en,
 output [7:0] pc_out,
 output [15:0] ar_out,
 output [7:0] bus_out,
 output end_process);
 
 wire [7:0] ir_pc;
 wire [2:0] alu_op;
 wire [23:0] alu_out;
 wire [15:0] regr_out;
 wire [7:0] regr1_out;
 wire [23:0] regr2_out;
 wire [15:0] regr3_out;
 wire [7:0] dr_out;
 wire [23:0] ac_out;
 wire [15:0] ir_out;
 wire [16:0] write_en;
 wire [4:0] read_en;
 wire [6:0] inc_en;
 wire [7:0] X_out;
 wire [7:0] Y_out;
 wire [7:0] Z_out;
 wire [15:0] STXY_out;
 wire [15:0] STYZ_out;
 wire [15:0] STXZ_out;
 
 
 wire z ;


//changed write enable values & Increment Values
Register #(.word_size(16)) reg_r(.clk(clock), .write_en (write_en [11]),.data_in(bus_out),.data_out(regr_out ),.inc(inc_en[4]),.rst(rst_r));
Register #(.word_size(08)) reg_r1(.clk(clock), .write_en (write_en [12]),.data_in(bus_out),.data_out(regr1_out ),.inc(1'b0),.rst(rst_r));
Register #(.word_size(24)) reg_r2(.clk(clock), .write_en (write_en [13]),.data_in(bus_out),.data_out(regr2_out ),.inc(1'b0),.rst(rst_r));
Register #(.word_size(16)) reg_r3(.clk(clock), .write_en (write_en [14]),.data_in(bus_out),.data_out(regr3_out ),.inc(inc_en[5]),.rst(rst_r));
Register #(.word_size(08)) X(.clk(clock), .write_en (write_en [5]),.data_in(bus_out),.inc(1'b0),.data_out(X_out),.rst(rst_r));
Register #(.word_size(08)) Y(.clk(clock), .write_en (write_en [6]),.data_in(bus_out),.inc(1'b0),.data_out(Y_out),.rst(rst_r));
Register #(.word_size(08)) Z(.clk(clock), .write_en (write_en [7]),.data_in(bus_out),.inc(1'b0),.data_out(Z_out),.rst(rst_r));
Register #(.word_size(16)) STXY(.clk(clock), .write_en (write_en [8]),.data_in(bus_out),.inc(inc_en[2]),.data_out(STXY_out),.rst(rst_r));
Register #(.word_size(16)) STYZ(.clk(clock), .write_en (write_en [9]),.data_in(bus_out),.inc(1'b0),.data_out(STYZ_out),.rst(rst_r));
Register #(.word_size(16), .increment(3)) STXZ(.clk(clock), .write_en (write_en [10]),.data_in(bus_out),.inc(inc_en[3]),.data_out(STXZ_out),.rst(rst_r));
Register #(.word_size(16)) AR(.clk(clock), .write_en(write_en [4]), .data_in(bus_out), .inc(inc_en[6]), .data_out(ar_out), .rst(rst_r));
Register #(.word_size(08)) PC(.clk(clock), .write_en(write_en [2]), .data_in(ir_out), .inc(inc_en[0]), .data_out(pc_out), .rst(rst_r));
Register #(.word_size(16)) IR(.clk(clock), .write_en(write_en [3]), .data_in(bus_out), .inc(1'b0), .data_out(ir_out), .rst(rst_r));
Register #(.word_size(08)) DR(.clk(clock), .write_en(write_en [15]), .data_in(bus_out), .inc(1'b0), .data_out(dr_out), .rst(rst_r));

ALU alu(.control_signal(alu_op), .A_in(ac_out), .C_out(alu_out), .B_in(bus_out), .Z(z));

ACRegister AC(.clk(clock), .data_in(bus_out), .data_out(ac_out), .write_en(write_en [16]), .alu_to_ac(write_en[1]),
.alu_out(alu_out), .incre(inc_en[1]), .rst(rst_r));

control_unit ControlUnit(.clk(clock), .Z(z), .instruction(ir_out), .status(status), .finish(end_process), .write_enable(write_en), .read_enable(read_en), .increment(inc_en), .alu(alu_op));

bus bus1(.clk(clock), .pc(pc_out), .ir(ir_out), .ar(ar_out), .ac(ac_out), .x(X_out), .y(Y_out), .z(Z_out), .stxy(STXY_out),
.styz(STYZ_out), .stxz(STXZ_out), .r(regr_out), .r1(regr1_out), .r2(regr2_out), .r3(regr3_out),
.dm(dm_out), .im(im_out), .dr(dr_out), .busout(bus_out), .read_en(read_en));     

endmodule