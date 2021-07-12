`timescale 1 ms/10 ns  // time-unit = 1 ns, precision = 10 ps

module sample_tb;
    reg clk;

always 
    begin
        clk = 1'b1; 
        #500; // high for 20 * timescale = 20 ns

        clk = 1'b0;
        #500; // low for 20 * timescale = 20 ns
    end

endmodule