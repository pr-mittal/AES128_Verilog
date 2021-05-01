`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2021 20:55:42
// Design Name: 
// Module Name: decrypt
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


module decrypt();
    expand_key decrypt_ekey();
    s_box decrypt_s();
    shift_rows decrypt_sr();
    mix_columns decrypt_mc();
    function [128:1]  decrypt_func(input [128:1] key,word);
    reg [128:1] decrypt;
    reg [1408:1] ekey;
    integer i,j;
    begin
        //exapnd key
        ekey=decrypt_ekey.expand_key_func(key);
        //add round key
        decrypt=word^ekey[1281+:128];
//        $display(" %h %h",ekey,decrypt);
        
        //rounds
        for(i=1281-128;i>128;i=i-128)
        begin
            //inverse shift rows
            decrypt=decrypt_sr.shift_rows_func(decrypt,1'b0);
//            $display(" %h ",decrypt);
            //inverse subsitute bytes
            for(j=1;j<128;j=j+8)
            begin
                decrypt[j+:8]=decrypt_s.s_box_func(decrypt[j+:8],1'b0);
            end
//            $display(" %h ",decrypt);
            //add round key
            decrypt=decrypt^ekey[i+:128];
//            $display(" %h %d %h",decrypt,i,ekey[i+:128]);
            //inverse mix columns
            decrypt=decrypt_mc.mix_columns_func(decrypt,1'b0);
//            $display(" %h ",decrypt);
        end
        //for last round 
         //inverse shift rows
        decrypt=decrypt_sr.shift_rows_func(decrypt,1'b0);
//        $display(" %h ",decrypt);
        //inverse subsitute bytes
        for(j=1;j<128;j=j+8)
        begin
            decrypt[j+:8]=decrypt_s.s_box_func(decrypt[j+:8],1'b0);
        end
//       $display(" %h ",decrypt);
        //add round key
        decrypt_func=decrypt^ekey[1+:128];
//        $display(" %h ",decrypt_func);
    end
    endfunction
endmodule
