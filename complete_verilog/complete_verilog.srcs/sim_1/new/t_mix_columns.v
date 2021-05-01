`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2021 23:57:39
// Design Name: 
// Module Name: t_mix_columns
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


module t_mix_columns();
//    reg [7:0]in,m;
//    wire [7:0] val;
//    galios_mul gm1(val,in,m);
//    reg [2:0]temp;
//    reg [8:1]temp2;
//    initial
//    begin
//        in=8'h02;
//        m=8'h87;
//        #10 
//        in=8'h03;
//        m=8'h6E;
//        temp2=8'b10111010;
//        temp=temp2[5:3];
//        #10 $finish;
//    end

//mix_columns(output reg [128:1] mix,input [128:1] cipher,input mode);
//cipher
//0E 0B 0D 09
//09 0E 0B 0D
//0D 09 0E 0B
//0B 0D 09 0E
    reg [127:0] cipher=128'h0E090D0B0B0E090D0D0B0E09090D0B0E;
//02 03 01 01
//01 02 03 01
//01 01 02 03
//03 01 01 02
    reg [127:0] decipher=128'h02010103030201010103020101010302;
    reg [127:0] mix;
    reg mode=1'b1;
    mix_columns mc1();
    initial
    begin
        mix=mc1.mix_columns_func(cipher,1'b1);
        #100 mix=mc1.mix_columns_func(decipher,1'b0);
        #100 cipher=128'hff0b844a0853bf7c6934ab4364148fb9;mode=1'b1;
        mix=mc1.mix_columns_func(cipher,1'b1);
        #100 cipher=mix;mode=1'b0;
        mix=mc1.mix_columns_func(mix,1'b0);
        #100 $finish;
    end

//cipher then decipher
//ff0b844a0853bf7c6934ab4364148fb9

endmodule
