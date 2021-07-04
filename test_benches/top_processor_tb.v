`timescale 1 ns/1 ps  // time-unit = 1 ns, precision = 10 ps

module top_processor_tb;

    reg pc_out2 = 8'd10;
    reg clk;
    reg start_process;
    wire g1, g2, g3;
    wire [15:0] q ;
    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;  

    top_processor UUT (.fast_clock(clk), .start_process(start_process), .pc_out1(pc_out2), .q(q), .g1(g1), .g2(g2), .g3(g3));


// note that sensitive list is omitted in always block
// therefore always-block run forever
// clock period = 2 ns
reg [9:0] start_buffer = 10'd0;
reg [14:0] stop_buffer = 14'd0;
initial 
		begin
			clk = 1'b0;
			forever begin
				#1 clk = ~clk;
			end
		end

always @(posedge clk)
    begin
        if (start_buffer == 10'd10 )
            begin
                //pc_out1 <= pc_out1 + 8'd1;
                start_process <=1;
                stop_buffer <= stop_buffer + 14'd1;
                if ( stop_buffer == 14'd1000)
                    begin
                        $stop;
                    end
            end
        else
            begin
                //pc_out1 <= pc_out1 + 8'd1;
                start_buffer <= start_buffer + 10'd1;
                start_process <=0;
            end
    end 
endmodule