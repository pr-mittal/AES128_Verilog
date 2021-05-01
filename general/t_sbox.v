`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2021 18:33:02
// Design Name: 
// Module Name: t_sbox
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


module t_sbox();
    reg [4:1] row, col;
    reg [0:127] sbox;
    reg [8:1] out;
    integer i,j; 
    s_box s1();
    initial begin
        //The first row contains {00}, {01}, {02},{0F};
        //63 7C 77 7B F2 6B 6F C5 30 01 67 2B FE D7 AB 76
        sbox[0+:128]= 128'h637C777BF26B6FC53001672BFED7AB76;
        
        row=4'b0000;
        for(i=0;i<16;i=i+1)
        begin
            col=4'b0000;
            for(j=0;j<16;j=j+1) begin
                out=s1.s_box_func({row,col},1'b1);
                #20 col=col+4'd1;
            end
            row =row +1 ;
        end
        #20 $finish;
    end
    
endmodule
