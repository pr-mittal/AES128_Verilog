`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2021 15:24:02
// Design Name: 
// Module Name: expand_key
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

module expand_key();
    
    s_box key_s1();
    
    function [32:1] g_func(input [32:1]word,input [8:1]rcon);
        reg [32:1] tf;
        reg [32:1] sub;
        reg [32:1] temp;
        //byte subsitution
        
        begin
        temp=32'h00000000;
        tf[24:1]=word[32:9];
        tf[32:25]=word[8:1];
        
        sub[32-:8]=key_s1.s_box_func(tf[32-:8] ,1'b1);
        sub[24-:8]=key_s1.s_box_func(tf[24-:8] ,1'b1);
        sub[16-:8]=key_s1.s_box_func(tf[16-:8] ,1'b1);
        sub[8-:8]=key_s1.s_box_func(tf[8-:8] ,1'b1);
        
        temp[8:1]=rcon;
    //    $strobe("%h",word);
    //    $strobe("%h",tf);
        //$strobe("%h %h",tf,sub);
        g_func= sub^temp;
        end
    endfunction
    
    function [1408:1] expand_key_func(input [128:1] key);
    integer i;
    reg [80:1] rcon;
    reg [32:1]sys;
    reg [8:1] r;
    reg [32:1] gres;
    begin
        rcon =80'h361B8040201008040201;
        expand_key_func[128:1]=key;
        
        sys = key[32*4:32*3+1];
        r=rcon[8:1];
        //$display("%h %h",sys,r);
        r=rcon[8:1];
        for(i=1;i<11;i=i+1) begin
            gres=g_func(sys,r);
            expand_key_func[(128*i+1)+:32]= gres^expand_key_func[(128*(i-1)+1)+:32];
                //$display("%h",gres);$display("%h",ekey[(128*i+1)+:32]);
               expand_key_func[(128*i+1+32)+:32]= expand_key_func[(128*i+1)+:32]^expand_key_func[(128*(i-1)+1+32)+:32];
               expand_key_func[(128*i+1+32*2)+:32]= expand_key_func[(128*i+1+32)+:32]^expand_key_func[(128*(i-1)+1+32*2)+:32];
               expand_key_func[(128*i+1+32*3)+:32]= expand_key_func[(128*i+1+32*2)+:32]^expand_key_func[(128*(i-1)+1+32*3)+:32];
//               $display("%h",ekey[128*i+:128]);
//                $display("%h",gres);               
            sys=expand_key_func[(128*i+1+32*3)+:32];               
            r=rcon[(i*8+1)+:8];
            //$display("%h %h",sys,r);   
        end
//        $display("%h",ekey);
    end
    endfunction
endmodule
