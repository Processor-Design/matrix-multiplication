`timescale 1ns / 1ps

module control_unit(
	input clk, Z,
	input [15:0] instruction,
    input [1:0] status,

	output reg finish = 0,
    output reg [16:0] write_enable,
    output reg [4:0] read_enable,
	output reg [6:0] increment,
	output reg [2:0] alu
    );

localparam 
prepare = 2'b00,
process = 2'b01,
complete = 2'b11;

localparam
IDLE = 6'd0,
FETCH1 = 6'd1, FETCH2 = 6'd2, FETCH3 = 6'd3,
NOP = 6'd4,
ADD1 = 6'd5, ADD2 = 6'd6,
MUL1 = 6'd7, MUL2 = 6'd8,
SUB1 = 6'd9, SUB2 = 6'd10,
LODAC1 = 6'd11, LODAC2 = 6'd12, LODAC3 = 6'd13, LODAC4 = 6'd14, LODAC5 = 6'd15,
LDACAR1 = 6'd16, LDACAR2 = 6'd17,
STOAC1 = 6'd18, STOAC2 = 6'd19, STOAC3 = 6'd41, STOAC4 = 6'd42, STOAC5 = 6'd43, STOAC6 = 6'd44,
MVAC = 6'd20,
MOVREG = 6'd21,
CLAC1 = 6'd22, CLAC2 = 6'd23,
JUMP1 = 6'd24, JUMP2 = 6'd25, JUMP3 = 6'd26,
JUMPZ = 6'd27,
JUMPZN = 6'd28,
JMNZ = 6'd29,
JMNZN = 6'd30,
INCAC = 6'd31,
INCR = 6'd32,
INCR3 = 6'd33,
SFTR1 = 6'd34, SFTR2 = 6'd35,
SFTL1 = 6'd36, SFTL2 = 6'd37,
MOVAR1 = 6'd38,
MOVAR2 = 6'd39,
ENDOP = 6'd40;

localparam
NO_W = 17'b0_0000_0000_0000_0000,
DATA_MEM_W = 17'b0_0000_0000_0000_0001,
ALU_AC_W = 17'b0_0000_0000_0000_0010,
IR_PC_W = 17'b0_0000_0000_0000_0100,
IR_W = 17'b0_0000_0000_0000_1000,
AR_W = 17'b0_0000_0000_0001_0000,
X_W = 17'b0_0000_0000_0010_0000,
Y_W = 17'b0_0000_0000_0100_0000,
Z_W = 17'b0_0000_0000_1000_0000,
STXY_W = 17'b0_0000_0001_0000_0000,
STYZ_W = 17'b0_0000_0010_0000_0000,
STXZ_W = 17'b0_0000_0100_0000_0000,
R_W = 17'b0_0000_1000_0000_0000,
R1_W = 17'b0_0001_0000_0000_0000,
R2_W = 17'b0_0010_0000_0000_0000,
R3_W = 17'b0_0100_0000_0000_0000,
DR_W = 17'b0_1000_0000_0000_0000,
AC_W = 17'b1_0000_0000_0000_0000;

localparam
NO_R = 5'd0,
INS_MEM_R = 5'd1,
DATA_MEM_R = 5'd2,
PC_R = 5'd3,
IR_R = 5'd4,
AR_R = 5'd5,
AC_R = 5'd6,
X_R = 5'd7,
Y_R = 5'd8,
Z_R = 5'd9,
STXY_R = 5'd10,
STYZ_R = 5'd11,
STXZ_R = 5'd12,
R_R = 5'd13,
R1_R = 5'd14,
R2_R = 5'd15,
R3_R = 5'd16,
DR_R = 5'd17;

localparam
NO_I = 7'b000_0000,
PC_I = 7'b000_0001,
AC_I = 7'b000_0010,
STXY_I = 7'b000_0100,
STXZ_I = 7'b000_1000,
R_I = 7'b001_0000,
R3_I = 7'b010_0000,
AR_I = 7'b100_0000;

localparam
NO_OP = 3'd0,
ADD = 3'd1,
MUL = 3'd2,
SUB = 3'd3,
SFTR = 3'd4,
SFTL = 3'd5,
ZERO = 3'd6;

reg [5:0] CONTROL_COMMAND;
reg [5:0] NEXT_COMMAND = FETCH1;
always @ (negedge clk) CONTROL_COMMAND <= NEXT_COMMAND;

always @ (CONTROL_COMMAND or Z or instruction or status)
    case (CONTROL_COMMAND)

        IDLE:
            begin
                write_enable <= NO_W; 
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= (status == process) ? FETCH1: IDLE;
            end
        FETCH1:
            begin
                write_enable <= NO_W; // Merge Fetch 1 and Fetch 2 ?
                read_enable <= INS_MEM_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH2;
            end

        FETCH2:
            begin
                write_enable <= IR_W;
                read_enable <= INS_MEM_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH2;
            end

        FETCH3:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= PC_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= instruction[15:8];
            end
    
        NOP:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end
    
        ADD1:
            begin
                write_enable <= NO_W;

                case (instruction[1:0])
                    1:
                        begin
                            read_enable <= R_R;
                        end
                    2:
                        begin
                            read_enable <= R1_R;
                        end
                    3:
                        begin
                            read_enable <= R2_R;
                        end
                endcase

                increment <= NO_I;
                alu <= ADD;
                finish <= 0;
                NEXT_COMMAND <= ADD2;
            end
        
        ADD2:
            begin
                write_enable <= ALU_AC_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end
        
        MUL1:
            begin
                write_enable <= NO_W;
                read_enable <= R1_R;
                increment <= NO_I;
                alu <= ADD;
                finish <= 0;
                NEXT_COMMAND <= MUL2;
            end
        
        MUL2:
            begin
                write_enable <= ALU_AC_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end

        SUB1:
            begin
                write_enable <= NO_W;
                read_enable <= R_R;
                increment <= NO_I;
                alu <= SUB;
                finish <= 0;
                NEXT_COMMAND <= SUB2;
            end
        
        SUB2:
            begin
                write_enable <= ALU_AC_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end

        LODAC1:
            begin
                write_enable <= NO_W; // Merge Fetch 1 and Fetch 2 ?
                read_enable <= INS_MEM_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= LODAC2;
            end

        LODAC2:
            begin
                write_enable <= IR_W;
                read_enable <= INS_MEM_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= LODAC3;
            end

        LODAC3:
            begin
                write_enable <= AR_W;
                read_enable <= IR_R;
                increment <= PC_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= LODAC4;
            end
        
        LODAC4:
            begin
                write_enable <= DR_W; //Assuming data will be available by next Positive egdge
                read_enable <= DATA_MEM_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= LODAC5;
            end

        LODAC5:
            begin
                write_enable <= AC_W;
                read_enable <= DR_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end
        
        LDACAR1:
            begin
                write_enable <= DR_W;
                read_enable <= DATA_MEM_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= LDACAR2;
            end

        LDACAR2:
            begin
                write_enable <= AC_W;
                read_enable <= DR_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end

        STOAC1:
            begin
                write_enable <= DR_W;
                read_enable <= AC_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= STOAC2;
            end

        STOAC2:
            begin
                write_enable <= DATA_MEM_W;
                read_enable <= DR_R;
                increment <= NO_I;
                alu <= SFTR;
                finish <= 0;
                NEXT_COMMAND <= STOAC3;
            end
        
        STOAC3:
            begin
                write_enable <= DR_W;
                read_enable <= AC_R;
                increment <= AR_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= STOAC4;
            end
        
        STOAC4:
            begin
                write_enable <= DATA_MEM_W;
                read_enable <= DR_R;
                increment <= NO_I;
                alu <= SFTR;
                finish <= 0;
                NEXT_COMMAND <= STOAC5;
            end

        STOAC5:
            begin
                write_enable <= DR_W;
                read_enable <= AC_R;
                increment <= AR_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= STOAC6;
            end

        STOAC6:
            begin
                write_enable <= DATA_MEM_W;
                read_enable <= DR_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end

        MVAC:
            begin

                case (instruction[3:0])
                    1:
                        begin
                            write_enable <= X_W;
                        end
                    2:
                        begin
                            write_enable <= Y_W;
                        end
                    3:
                        begin
                            write_enable <= Z_W;
                        end
                    4:
                        begin
                            write_enable <= STXY_W;
                        end
                    5:
                        begin
                            write_enable <= STYZ_W;
                        end
                    6:
                        begin
                            write_enable <= STXZ_W;
                        end
                    7:
                        begin
                            write_enable <= R_W;
                        end
                    8:
                        begin
                            write_enable <= R1_W;
                        end
                    9:
                        begin
                            write_enable <= R2_W;
                        end
                    10:
                        begin
                            write_enable <= R3_W;
                        end
                    11:
                        begin
                            write_enable <= DR_W;
                        end
                endcase

                read_enable <= AC_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end
        
        MOVREG:
            begin
                write_enable <= AC_W;

                case (instruction[3:0])
                    1:
                        begin
                            read_enable <= X_R;
                        end
                    2:
                        begin
                            read_enable <= Y_R;
                        end
                    3:
                        begin
                            read_enable <= Z_R;
                        end
                    4:
                        begin
                            read_enable <= STXY_R;
                        end
                    5:
                        begin
                            read_enable <= STYZ_R;
                        end
                    6:
                        begin
                            read_enable <= STXZ_R;
                        end
                    7:
                        begin
                            read_enable <= R_R;
                        end
                    8:
                        begin
                            read_enable <= R1_R;
                        end
                    9:
                        begin
                            read_enable <= R2_R;
                        end
                    10:
                        begin
                            read_enable <= R3_R;
                        end
                    11:
                        begin
                            read_enable <= DR_R;
                        end
                endcase

                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end

        CLAC1:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= ZERO;
                finish <= 0;
                NEXT_COMMAND <= CLAC2;
            end

        CLAC2:
            begin
                write_enable <= ALU_AC_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end
        
        JUMP1:
            begin
                write_enable <= NO_W;
                read_enable <= INS_MEM_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= JUMP2;
            end
        JUMP2:
            begin
                write_enable <= IR_W;
                read_enable <= INS_MEM_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= JUMP3;
            end

        JUMP3:
            begin
                write_enable <= IR_PC_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= JUMP3;
            end
        
        JUMPZ:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= (Z) ? JUMPZN: JUMP1;
            end
        
        JUMPZN:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= PC_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end
        
        JMNZ:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= (Z) ? JUMP1: JMNZN;
            end
        
        JMNZN:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= PC_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end

        INCAC:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= AC_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end
        
        INCR:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= R_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end

        INCR3:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= R3_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end
        
        SFTR1:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= SFTR;
                finish <= 0;
                NEXT_COMMAND <= SFTR2;
            end

        SFTR2:
            begin
                write_enable <= ALU_AC_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end

        SFTL1:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= SFTR;
                finish <= 0;
                NEXT_COMMAND <= SFTL2;
            end

        SFTL2:
            begin
                write_enable <= ALU_AC_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end

        MOVAR1:
            begin
                write_enable <= AR_W;

                case (instruction[3:0])
                    1:
                        begin
                            read_enable <= X_R;
                        end
                    2:
                        begin
                            read_enable <= Y_R;
                        end
                    3:
                        begin
                            read_enable <= Z_R;
                        end
                    4:
                        begin
                            read_enable <= STXY_R;
                        end
                    5:
                        begin
                            read_enable <= STYZ_R;
                        end
                    6:
                        begin
                            read_enable <= STXZ_R;
                        end
                    7:
                        begin
                            read_enable <= R_R;
                        end
                    8:
                        begin
                            read_enable <= R1_R;
                        end
                    9:
                        begin
                            read_enable <= R2_R;
                        end
                    10:
                        begin
                            read_enable <= R3_R;
                        end
                    11:
                        begin
                            read_enable <= DR_R;
                        end
                endcase

                increment <= NO_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= (instruction[3:0] == 4 || instruction[3:0] == 6) ? MOVAR2: FETCH1;
            end

        MOVAR2:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= (instruction[2:0] == 4) ? STXY_I: STXZ_I;
                alu <= NO_OP;
                finish <= 0;
                NEXT_COMMAND <= FETCH1;
            end
        
        ENDOP:
            begin
                write_enable <= NO_W;
                read_enable <= NO_R;
                increment <= NO_I;
                alu <= NO_OP;
                finish <= 1;
                NEXT_COMMAND <= ENDOP;
            end
    endcase
endmodule
