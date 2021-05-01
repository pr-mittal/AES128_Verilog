`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2021 21:33:04
// Design Name: 
// Module Name: t_cipher_128b
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


module t_cipher_128b();
    reg [128:1] cipher,key;
    reg [128:1] out_enc,out_dec;
    decrypt cipher_128b_dec();
    encrypt cipher_128b_enc();
    initial begin
    cipher=128'hff0b844a0853bf7c6934ab4364148fb9;
    key=128'h0f1571c947d9e8590cb7add6af7f6798;
    out_enc=cipher_128b_enc.encrypt_func(key,cipher);
    #20 out_dec=cipher_128b_dec.decrypt_func(key,out_enc);
    #20 $finish;
    end
endmodule
