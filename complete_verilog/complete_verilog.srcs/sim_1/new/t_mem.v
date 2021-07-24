`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2021 17:42:16
// Design Name: 
// Module Name: t_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module t_mem(    );
    parameter Mbit=32;
    integer adr; 
    reg [7:0] mem[32:0]; //each address is a byte
//    wire [Mbit-1:0] inst;
//    inst_memory IM(.out(inst),.Adr(adr));
//    wire [Mbit-1:0] rd;
//    data_memory DM(.rd(rd),.Adr(Adr),.wrtData(rd2),.mwr(mwr),.moe(moe),.clk(clk));
    
    initial
    begin
        $readmemb("C:\\Users\\prana\\OneDrive\\Documents\\GitHub\\beta-risc\\beta_risc\\beta_risc.srcs\\sources_1\\new\\mem\\mem_inst.txt",mem);
    end
    initial 
    begin
        for(adr=0;adr<33;adr=adr+1)
        begin
            $display("%b",mem[adr]);
        end
        $finish;
    end
    
    
    
endmodule
