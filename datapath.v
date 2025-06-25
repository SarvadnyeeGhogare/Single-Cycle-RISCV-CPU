module datapath(instr,clk,rst,regwr_sgn,imm_sgn,alu_main,alu_sgn,memwr_sgn,result_sgn,pc_sgn,read_data,zero,pc,wr_data,datamem_rd,datamem_wr,jalr,alu_result_31);
input clk,rst;
input [31:0] instr,read_data;
input regwr_sgn,alu_sgn,memwr_sgn,pc_sgn,jalr;
input [1:0] result_sgn,imm_sgn;
input [3:0] alu_main;
output zero;
output [31:0] pc;
output [31:0] wr_data;
output [31:0] datamem_rd,datamem_wr;
output alu_result_31 ;


wire [31:0] pc_out,pc_4,pc_imm,pc_aui,pc_jalr,imm_ext,aui_lui_result,rd_data1,rd_data2,rd_final2,alu_result;
wire [31:0] pc_internal;

//pc
mux2 mx2_4(pc_out,alu_result,jalr,pc_jalr);
reset_ff pf1(pc_jalr,clk,rst,pc_internal);
adder ad1(pc_internal,32'd4,pc_4);
adder ad2(pc_internal,imm_ext,pc_imm);
mux2 mx2_1(pc_4,pc_imm,pc_sgn,pc_out);

assign pc = pc_internal;

//reg_file
reg_file rf1(clk,regwr_sgn,instr[19:15],instr[24:20],instr[11:7],rd_data1,rd_data2,wr_data);
imm_extend ime1(instr[31:7],imm_sgn,imm_ext);

//alu
mux2 mx2_2(rd_data2,imm_ext,alu_sgn,rd_final2);
alu al1(rd_data1,rd_final2,alu_main,alu_result,zero);

//auipc,lui
adder ad3( {instr[31:12],12'b0} , pc_internal , pc_aui) ;
mux2 mx2_3( pc_aui , {instr[31:12],12'b0}   , instr[5] , aui_lui_result );

// auipc
mux4 mx4_1(alu_result,read_data,pc_4,aui_lui_result,result_sgn,wr_data);


assign alu_result_31 = alu_result[31] ; 
assign datamem_rd= alu_result;
assign datamem_wr= rd_data2;

endmodule

