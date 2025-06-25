module data_mem(
    input       clk, memwr_sgn,
    input [2:0] func3,
    input [31:0] alu_result, rd_data2,
    output reg [31:0] read_data
);

reg [31:0] data_ram [0:63];
wire [31:0] word_addr = alu_result[31:2] % 64;
wire lb_or_lbu,lh_or_lhu;

always @(posedge clk) begin
    if (memwr_sgn) begin
        case (func3[1:0])
            2'b00: begin // SB 
                case (alu_result[1:0])
                    2'b00: data_ram[word_addr] <= (data_ram[word_addr] & 32'hFFFFFF00) | (rd_data2[7:0] << 0);   
                    2'b01: data_ram[word_addr] <= (data_ram[word_addr] & 32'hFFFF00FF) | (rd_data2[7:0] << 8);   
                    2'b10: data_ram[word_addr] <= (data_ram[word_addr] & 32'hFF00FFFF) | (rd_data2[7:0] << 16);  
                    2'b11: data_ram[word_addr] <= (data_ram[word_addr] & 32'h00FFFFFF) | (rd_data2[7:0] << 24);  
                endcase
            end
            2'b01: begin // SH 
                case (alu_result[1])
                    1'b0: data_ram[word_addr] <= (data_ram[word_addr] & 32'hFFFF0000) | (rd_data2[15:0] << 0);   // Lower Halfword
                    1'b1: data_ram[word_addr] <= (data_ram[word_addr] & 32'h0000FFFF) | (rd_data2[15:0] << 16);  // Upper Halfword
                endcase
            end
            default: data_ram[word_addr] <= rd_data2;  // SW (Store Word)
        endcase
    end
end


always @(*) begin
    read_data = data_ram[word_addr]; 
    case (func3[1:0])
        2'b00: begin  // LB 
            case (alu_result[1:0])
                2'b00: read_data = {{24{~func3[2] & data_ram[word_addr][7]}}, data_ram[word_addr][7:0]};  // Byte 0
                2'b01: read_data = {{24{~func3[2] & data_ram[word_addr][15]}}, data_ram[word_addr][15:8]}; // Byte 1
                2'b10: read_data = {{24{~func3[2] & data_ram[word_addr][23]}}, data_ram[word_addr][23:16]}; // Byte 2
                2'b11: read_data = {{24{~func3[2] & data_ram[word_addr][31]}}, data_ram[word_addr][31:24]}; // Byte 3
            endcase
        end
        2'b01: begin  // LH 
            case (alu_result[1])
                1'b0: read_data = {{16{~func3[2] & data_ram[word_addr][15]}}, data_ram[word_addr][15:0]};   // Lower Halfword
                1'b1: read_data = {{16{~func3[2] & data_ram[word_addr][31]}}, data_ram[word_addr][31:16]};  // Upper Halfword
            endcase
        end
        default: read_data = data_ram[word_addr]; // Default full word read for SW
    endcase
end

endmodule
