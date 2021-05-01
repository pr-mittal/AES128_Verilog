`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2021 20:55:25
// Design Name: 
// Module Name: encrypt
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


module encrypt();
    
    expand_key encrypt_ekey();
    s_box encrypt_s();
    shift_rows encrypt_sr();
    mix_columns encrypt_mc();
    function [128:1] encrypt_func(input [128:1]key,word);
        reg [128:1] encrypt;
        reg [1408:1] ekey;
        integer i,j;
        begin
            
            //expand key
             ekey=encrypt_ekey.expand_key_func(key);
            //round key
            encrypt=word^ekey[128:1];
//            $display(" %h %h",ekey,encrypt);
            //rounds
            for(i=129;i<(1408-128);i=i+128)
            begin
                //subsitute bytes
                for(j=1;j<128;j=j+8)
                begin
                    encrypt[j+:8]=encrypt_s.s_box_func(encrypt[j+:8],1'b1);
                end
//                $display(" %h ",encrypt);
                //shift rows
                encrypt=encrypt_sr.shift_rows_func(encrypt,1'b1);
//                $display(" %h ",encrypt);
                //mix columns
                encrypt=encrypt_mc.mix_columns_func(encrypt,1'b1);
//                $display(" %h ",encrypt);
                //add round key
                encrypt=encrypt^ekey[i+:128];
//                $display(" %h %d %h ",encrypt,i,ekey[i+:128]);
            end
            //for last round 
            //subsitute bytes
            for(j=1;j<128;j=j+8)
            begin
                encrypt[j+:8]=encrypt_s.s_box_func(encrypt[j+:8],1'b1);
            end
//            $display(" %h ",encrypt);
            //shift rows
            encrypt=encrypt_sr.shift_rows_func(encrypt,1'b1);
//            $display(" %h ",encrypt);
            //add round key
            encrypt_func=encrypt^ekey[1281+:128];
//            $display(" %h Encrypt Finisised",encrypt_func);
            
        end
    endfunction
endmodule
