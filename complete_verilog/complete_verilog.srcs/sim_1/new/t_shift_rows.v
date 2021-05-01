`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2021 21:55:24
// Design Name: 
// Module Name: t_shift_rows
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


module t_shift_rows();
    reg [128:1]cipher=128'hff0b844a0853bf7c6934ab4364148fb9;
   
    reg [128:1] out ,out2;
    shift_rows sr1();
    shift_rows sr2();
    initial 
    begin
        out=sr1.shift_rows_func(cipher,1'b1);
        #10 out2=sr2.shift_rows_func(out,1'b0);
        #10 $finish;
    end
endmodule
