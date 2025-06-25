 Single-Cycle RISC-V Processor

This project implements a complete Single-Cycle RISC-V Processor in Verilog HDL, capable of executing each instruction in a single clock cycle. 
The processor integrates all five classic instruction stages — instruction fetch, decode, execute, memory access, and write-back — into a unified datapath without pipelining.

Includes the following core Verilog modules:

1. t1c_riscv_cpu – Top-level wrapper with optional external memory access

2. riscv_cpu – Processor core connecting datapath and control logic

3. datapath – Unified datapath handling PC, ALU, register file, and data flow

4. controller – High-level control logic combining main and ALU decoders

5. main_decoder – Generates control signals from opcode and funct3

6. alu_decoder – Determines ALU operation from funct fields and instruction type

7. alu – Performs arithmetic, logic, and shift operations; sets zero flag

8. reg_file – 32-register file with dual read and single write capability

9. imm_extend – Immediate value extraction and sign-extension for various formats

10. instr_mem – Instruction memory (ROM) indexed by PC

11. data_mem – Data memory with support for byte/halfword/word access and sign extension

12. reset_ff – Flip-flop for PC register with reset capability

13. mux2,mux3, mux4, adder – Combinational components for selecting inputs and updating addresses

This processor supports a wide range of RV32I instructions, across all standard RISC-V formats (R, I, S, B, U, J).

R-type: add, sub, and, or, xor, slt, sltu, sll, sra, srl

I-type: lw, addi, andi, ori, xori, slti, sltiu, jalr

S-type: sw, sb, sh

B-type: beq, bne, blt, bge

U-type: lui, auipc

J-type: jal

Overall , 
Fully Functional Single-Cycle RISC-V Processor - executes one complete instruction per clock cycle, ideal for foundational CPU design understanding.


