module alu(rd_data1,rd_final2,alu_main,alu_result,zero);
input [31:0] rd_data1,rd_final2;
input [3:0] alu_main;
output reg [31:0] alu_result;
output zero;

always@(*)
begin
case(alu_main)
4'b0000 : alu_result = rd_data1 + rd_final2 ; //add
4'b0001 : alu_result = rd_data1 + ~rd_final2 + 1; //sub
4'b0101 : alu_result = ((rd_data1[31] != rd_final2[31]) ? (rd_data1[31] ? 1 : 0 ) : (rd_data1 < rd_final2)) ;            //slt sign                
4'b0011 : alu_result = rd_data1 | rd_final2 ; //or
4'b0010 : alu_result = rd_data1 & rd_final2 ; //and
4'b0111 : alu_result = (rd_data1 < rd_final2);// sltu (unsigned)
4'b0100 : alu_result = (rd_data1 ^ rd_final2);// xor
4'b1000 : alu_result = rd_data1 << rd_final2[4:0];   // SLL
4'b1001 : alu_result = $signed(rd_data1) >>> rd_final2[4:0]; // SRA
4'b1111 : alu_result = rd_data1 >> rd_final2[4:0];   // SRL

default : alu_result = 0 ;

endcase
end

assign zero = (! alu_result) ;

endmodule
