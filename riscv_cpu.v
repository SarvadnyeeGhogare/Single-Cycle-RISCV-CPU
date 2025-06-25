module riscv_cpu(instr,clk,rst,pc,read_data,wr_data,memwr_sgn,datamem_rd,datamem_wr);
input [31:0] instr,read_data;
input clk,rst;
output [31:0] pc;
output [31:0] wr_data;
output memwr_sgn;
output [31:0] datamem_rd,datamem_wr;

wire zero, pc_sgn,alu_sgn,regwr_sgn,jalr,alu_result_31;
wire [1:0] result_sgn,imm_sgn;
wire [3:0] alu_main;
wire [31:0] pc_internal;  // internal signal from datapath

controller c(instr[6:0],instr[14:12],instr[30],zero,pc_sgn,result_sgn,memwr_sgn,alu_sgn,imm_sgn,regwr_sgn,alu_main,jalr,alu_result_31);

datapath dp(instr,clk,rst,regwr_sgn,imm_sgn,alu_main,alu_sgn,memwr_sgn,result_sgn,pc_sgn,read_data,zero,pc_internal,wr_data,datamem_rd,datamem_wr,jalr,alu_result_31);

assign pc = pc_internal;  // connect datapath pc to module output

endmodule
