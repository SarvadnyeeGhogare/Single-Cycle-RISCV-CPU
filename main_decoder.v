module main_decoder(op,result_sgn,memwr_sgn,alu_sgn,imm_sgn,regwr_sgn,alu_wire,branch,jalr,func3,zero,alu_result_31,jump);

input [6:0] op;
input [2:0] func3;
input zero,alu_result_31 ;
output memwr_sgn,alu_sgn,regwr_sgn;
output [1:0] result_sgn,imm_sgn;
output [1:0] alu_wire;
output branch,jalr,jump;

reg [10:0] controls;
reg takebranch;

always @(*)
begin
takebranch = 0;
case(op)
7'b0000011 : controls = 11'b1_00_1_0_01_00_0_0 ; //lw
7'b0100011 : controls = 11'b0_01_1_1_xx_00_0_0 ; //sw
7'b0110011 : controls = 11'b1_xx_0_0_00_10_0_0 ; //r_type
7'b0010011 : controls = 11'b1_00_1_0_00_10_0_0 ; //i_type
7'b0110111 : controls = 11'b1_xx_0_0_11_xx_0_0 ; //lui 
7'b0010111 : controls = 11'b1_xx_0_0_11_xx_0_0 ; //AuiPC
7'b1100111 : controls = 11'b1_00_1_0_10_00_1_0 ; // jalr
7'b1101111 : controls = 11'b1_11_0_0_10_00_0_1; // jal
7'b1100011 : begin
             controls = 11'b0_10_0_0_xx_01_0_0 ; //branch //? includes unsigned case also use casez
              casez(func3)
                    3'b0?0: takebranch=  zero;         //beq
                    3'b0?1: takebranch= !zero;         // bne
                    3'b1?1: takebranch= !alu_result_31 ; //bge
						  3'b1?0: takebranch=  alu_result_31 ; //blt
				  endcase
				 end
default    : controls = 11'bx_xx_x_x_xx_xx_x_x ; // ???
endcase
end

assign branch = takebranch ; 

assign {regwr_sgn,imm_sgn,alu_sgn,memwr_sgn,result_sgn,alu_wire,jalr,jump} = controls;

endmodule

