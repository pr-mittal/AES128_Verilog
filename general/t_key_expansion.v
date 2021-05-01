`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2021 15:24:30
// Design Name: 
// Module Name: t_key_expansion
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


module t_key_expansion();
//reg [32:1] word=32'h98677faf;
//reg [8:1] rcon=8'h01;
//wire [32:1] result;
//g_func g1(result,word,rcon);
//initial begin
//       #10 $finish;
//end 

reg [128:1] key=128'h98677fafd6adb70c59e8d947c971150f;
reg [1408:1]ekey;
expand_key ke1();
initial
begin
    ekey= ke1.expand_key_func(key);
    #20 $finish;
end
endmodule
