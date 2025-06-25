module instr_mem(pc,instr);
input [31:0] pc;                //instr_mem_size=512
output [31:0] instr;

reg [31:0] instr_ram [0:511];

initial 
begin
//$readmemh("rv32i_book.hex", instr_ram);
$readmemh("rv32i_test.hex", instr_ram);
end

assign instr = instr_ram[pc[31:2]];

endmodule
