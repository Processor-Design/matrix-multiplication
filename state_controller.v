module state_controller ( input clock,
input process_finish ,
input start_process,

output reg [1:0] status,
output reg rst,
output reg g1,
output reg g2,
output reg g3);

reg [1:0] CURRENT_STATE = 2'b00;
reg [1:0] NEXT_STATE = 2'b00;

reg process_ready = 1'b0;
reg [9:0] process_switch_buffer = 10'd0;

parameter
prepare = 2'b00,
process = 2'b01,
complete = 2'b11;

initial
    begin
        g1 <= 0;
        g2 <= 0;
        g3 <= 0;
    end

always @(posedge clock)
begin
    if (start_process )
    begin
        if (process_switch_buffer == 10'd10 )
        begin
            process_ready <=1;
            rst <=0;
        end
        else
        begin
            process_switch_buffer <= process_switch_buffer + 10'd1;
            process_ready <=0;
            rst <= 1;
        end
    end 
    else 
    begin 
        process_switch_buffer <= 10'd0;
        process_ready <= 0;
        rst <= 0;
    end 
end

always @(posedge clock)
    CURRENT_STATE <= NEXT_STATE;

always @( CURRENT_STATE or process_ready or process_finish)
    case(CURRENT_STATE)
        prepare: 
            begin
                status <= prepare;

                g1 <=1;

                if ( process_ready )
                    NEXT_STATE<= process;
                else
                    NEXT_STATE<= prepare;
            end

        process: 
            begin
                status <= process;

                g2 <=1;

                if ( process_ready && process_finish )
                    NEXT_STATE<=  complete;
                else
                    NEXT_STATE <= process;
            end

        complete : 
            begin
                status <= complete;

                g3 <=1;

                NEXT_STATE <= complete;
            end

        endcase

endmodule