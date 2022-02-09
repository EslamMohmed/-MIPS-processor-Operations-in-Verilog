module CPU (clock);
input clock;
reg[31:0] PC, RegFile[0:31], IMemory[0:1023],DMemory[0:1023], IR,ALUOut;
wire [4:0] rs, rt;
wire [31:0] Ain, Bin;
wire [5:0] op;
assign rs = IR[25:21];
assign rt = IR[20:16];			
assign op = IR[31:26];


assign Ain=RegFile[rs];		
assign Bin=RegFile[rt];


initial begin
PC = 0;
//add s3,s1,s2
IMemory[0]=32'b00000010001100101001100000100000;
//sub s3,s1,s2
IMemory[1]=32'b00000010001100101001100000100010;
//and s3,s1,s2
IMemory[2]=32'b00000010001100101001100000100100;
//or s3,s1,s2
IMemory[3]=32'b00000010001100101001100000100101;

RegFile[17]=20; 	
RegFile[18]=10; 

end
always @ (posedge clock)
begin

IR <= IMemory[PC>>2];
PC <= PC + 4;
if (op == 6'b000000)
case (IR[5:0])
32 : ALUOut <= Ain + Bin;
36 : ALUOut <= Ain & Bin;
37 : ALUOut <= Ain | Bin;
34 : ALUOut <= Ain - Bin;

endcase
end
endmodule





