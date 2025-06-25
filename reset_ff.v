module reset_ff(in,clk,rst,out);          //d_ff
input [31:0] in;
input clk,rst;
output reg [31:0] out;

always@(posedge clk or posedge rst)
begin
if(rst) out <= 32'd0;
else out <= in;
end

endmodule
