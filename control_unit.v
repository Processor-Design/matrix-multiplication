`timescale 1ns / 1ps


module control_unit(
	input clk, Z,
	input [15:0] instruction,
	output reg fetch, finish = 0,

	output reg [16:0] write_enable,
    output reg [4:0] read_enable,
	output reg [5:0] increment,
	output reg [2:0] alu ;

    localparam
    FETCH1 = 8'd1, FETCH2 = 8'd2, FETCH3 = 8'd3,
    NOP = 8'd4,
    ADD = 8'd5,
    MUL = 8'd6,
    SUB = 8'd7,
    LODAC1 = 8'd8, LODAC2 = 8'd9, LODAC3 = 8'd10, LODAC4 = 8'd11, LODAC5 = 8'12,
    LDACAR1 = 8'd13, LDACAR2 = 8'd14,
    STOAC1 = 8'd15, STOSC2 = 8'd16,
    MVAC = 8'd17,
    MOVREG = 8'd18,
    RST = 8'd19,
    JUMP1 = 8'd20, JUMP2 = 8'd20, JUMP3 = 8'd21,
    JUMPZN = 8'd22,
    JUMPZY1 = 8'd23, JUMPZY2 = 8'd24, JUMPZY3 = 8'd25,
    JMNZY1 = 8'd26, JMNZY2 = 8'd27, JMNZY3 = 8'd28,
    INCAC = 8'd29,
    INCR = 8'd30,
    INCR3 = 8'd31,
    SFTR = 8'd32,
    SFTL = 8'd33,
    MOVAR = 8'd34,
    ENDOP = 8'd35;

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
    STXY_W = 17'b0_0000_0100_0000_0000,
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
    Y_R = 5'd7,
    Z_R = 5'd8,
    STXY_R = 5'd9,
    STYZ_R = 5'd10,
    STXY_R = 5'd11,
    R_R = 5'd12,
    R1_R = 5'd13,
    R2_R = 5'd14,
    R3_R = 5'd15,
    DR_R = 5'd16,
    AC_R = 5'd17;

    localparam
    NO_I = 6'b00_0000,
    PC_I = 6'b00_0001,
    AC_I = 6'd00_0010,
    STXY_I = 6'd00_0100,
    STXZ_I = 6'd00_1000,
    R_I = 6'd01_0000,
    R3_I = 6'd10_0000;

    localparam
    NO_OP = 3'd0,
    ADD = 3'd1,
    MUL = 3'd2,
    SUB = 3'd3,
    SFTR = 3'd4,
    SFTL = 3'd5;

    reg [5:0] CONTROL_COMMAND;
    reg [5:0] NEXT_COMMAND = FETCH1;
    always @ (negedge clk) CONTROL_COMMAND <= NEXT_COMMAND;

    always @ (CONTROL_COMMAND or Z or instruction)
	case (CONTROL_COMMAND)
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

                case (instruction[2:0])
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
                write_enable <= DR_W; //Assuming data will be available here
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
    endcase
end module