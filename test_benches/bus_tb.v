`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module bus_tb;

    localparam bus_width =24;
    localparam period = 20;

    reg clk;
    reg [4:0] read_en;
    reg [15:0] pc;
    reg [15:0] ir;
    reg [15:0] ar;
    reg [23:0] ac;
    reg [7:0] x;
    reg [7:0] y;
    reg [7:0] z;
    reg [15:0] stxy;
    reg [15:0] styz;
    reg [15:0] stxz;
    reg [15:0] r;
    reg [7:0] r1;
    reg [23:0] r2;
    reg [15:0] r3;
    reg [7:0] dm;
    reg [15:0] im;
    wire [bus_width-1:0] busout;

    initial begin
    clk = 1'b0;
    forever begin
            #(period/2);
            clk = ~clk;
        end
    end

    bus bus_test(.clk(clk), .pc(pc), .ir(ir), .ar(ar), .ac(ac), .x(x), .y(y), .z(z), .stxy(stxy),
    .styz(styz), .stxz(stxz), .r(r), .r1(r1), .r2(r2), .r3(r3), .dr(dr),.dm(dm), .im(im), .busout(busout), .read_en(read_en));

    
    initial begin
    
    @(posedge clk);
    pc <=16;
    read_en <=5'd3;
    ir <=0;

    @(posedge clk);
    pc <=0;
    ir <=16;
    read_en <=5'd4;

    @(posedge clk);
    ir <=0;
    ar <=16;
    read_en <=5'd5;

    @(posedge clk);
    ar <=0;
    ac <=16;
    read_en <=5'd6;

    @(posedge clk);
    ac <= 0;
    x <= 16;
    read_en <=5'd7;
    dm<=0;

    $stop;
end


endmodule