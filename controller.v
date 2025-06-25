module controller(op,func3,func7,zero,pc_sgn,result_sgn,memwr_sgn,alu_sgn,imm_sgn,regwr_sgn,alu_main,jalr,alu_result_31);
input [6:0] op;
input [2:0] func3;
input func7,zero,alu_result_31;
output pc_sgn,memwr_sgn,alu_sgn,regwr_sgn,jalr;
output [1:0] result_sgn,imm_sgn;
output [3:0] alu_main;

wire branch,jump;
wire [1:0] alu_wire;

main_decoder md(op,result_sgn,memwr_sgn,alu_sgn,imm_sgn,regwr_sgn,alu_wire,branch,jalr,func3,zero,alu_result_31,jump);
alu_decoder ad(op,func3,func7,alu_wire,alu_main);


assign pc_sgn = branch | jump ;  //jal and branch

endmodule
