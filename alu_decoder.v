module alu_decoder(op,func3,func7,alu_wire,alu_main);
input [6:0] op;
input [2:0] func3;
input func7;
input [1:0] alu_wire;
output reg [3:0] alu_main;


always@(*)
begin
case(alu_wire)
2'b00 : alu_main = 4'b0000 ; //add (lw/sw)
2'b01 : alu_main = 4'b0001 ; //sub (beq)
default :
begin 
case(func3)
3'b000 :begin 
       if((op[5] & func7)) alu_main = 4'b0001 ; //sub
       else alu_main = 4'b0000 ; //add,addi
       end
3'b010 : alu_main = 4'b0101 ; //slt,slti
3'b110 : alu_main = 4'b0011 ; //or,ori
3'b111 : alu_main = 4'b0010 ; //and,andi
3'b011 : alu_main = 4'b0111 ;//sltui,sltu
3'b100 : alu_main = 4'b0100 ;//xor,xori
3'b001 : if (!(func7)) alu_main = 4'b1000;//sll or slli
3'b101 : begin 
        if (!(func7) ) alu_main = 4'b1111;          //srl or srli
        else  alu_main = 4'b1001;              //srai ,sra
        end
3'b011 : alu_main = 4'b0111;//sltui,sltu	 
default: alu_main = 4'bxxxx ;
endcase
end

endcase
end

endmodule

