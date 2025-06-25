module reg_file(clk,wr_en,rd_addr1,rd_addr2,wr_addr,rd_data1,rd_data2,wr_data);
input clk,wr_en;
input [4:0] rd_addr1,rd_addr2,wr_addr;
input [31:0] wr_data;
output [31:0] rd_data1,rd_data2;

reg [31:0] reg_array [0 : 31] ;

integer i;

initial
begin
for(i=0 ; i<32 ; i=i+1 ) 
reg_array[i] = 0;
end

always@(posedge clk)
begin
if(wr_en) 
reg_array[wr_addr] <=  wr_data;
end

assign rd_data1 = ( rd_addr1 != 0) ? reg_array[rd_addr1] : 0;
assign rd_data2 = ( rd_addr2 != 0) ? reg_array[rd_addr2] : 0;

endmodule
