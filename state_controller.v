module main_control ( input clock,
input process_finish ,
input process_ready ,

output reg [1:0] status,

output reg g1,
output reg g2,
output reg g3);

reg [1:0] CURRENT_STATE = 2'b00;
reg [1:0] NEXT_STATE = 2'b00;

parameter
prepare = 2'b00
process = 2'b01
complete = 2'b11;

always @(posedge clock)
    begin
        if ( CURRENT_STATE == prepare )
            begin
                g1 <= 1;
            end
        if ( CURRENT_STATE == process )
            begin
                g2 <= 1;
            end
        if ( CURRENT_STATE == complete )
            begin
                g3 <= 1;
        end
    end

initial
    begin
        g1 <= 0;
        g2 <= 0;
        g3 <= 0;
    end

always @(posedge clock)
    CURRENT_STATE <= NEXT_STATE;

always @( CURRENT_STATE or process_ready or process_finish)
    case(CURRENT_STATE)
        prepare: 
            begin
                status <= prepare;

                g2 <=0;
                g3 <=0;

                if ( process_ready )
                    NEXT_STATE<= process;
                else
                    NEXT_STATE<= prepare;
            end

        process: 
            begin
                status <= process;

                g3 <=0;

                if ( process_ready && process_finish )
                    NEXT_STATE<=  complete;
                else
                    NEXT_STATE <= process;
            end

        complete : 
            begin
                status <= complete;

                NEXT_STATE <= complete
            end

        endcase

endmodule