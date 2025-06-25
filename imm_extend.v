module imm_extend(instr,imm_sgn,imm_ext);
input [31:7] instr;
input [1:0] imm_sgn;
output reg [31:0] imm_ext;

always@(*)
begin
case(imm_sgn)
2'b00 : imm_ext = {{20{instr[31]}},instr[31:20]} ; //I_type
2'b01 : imm_ext = {{20{instr[31]}},instr[31:25],instr[11:7]} ; //S_type
2'b10 : imm_ext = {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0} ; //B_type
2'b10:  imm_ext = {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0}; // J−type (jal)
default : imm_ext = 32'bx;

endcase

end

endmodule
