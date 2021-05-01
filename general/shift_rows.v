`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2021 21:55:08
// Design Name: 
// Module Name: shift_rows
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


module shift_rows();
    function [128:1] shift_rows_func(input [128:1]cipher,input mode);
    begin
    if(mode)
    begin
    //encrypt
        shift_rows_func[1+:32]=cipher[1+:32];
        
        shift_rows_func[33+:24]=cipher[41+:24];
        shift_rows_func[57+:8]=cipher[33+:8];
        
        shift_rows_func[65+:16]=cipher[81+:16];
        shift_rows_func[81+:16]=cipher[65+:16];
        
        shift_rows_func[97+:8]=cipher[121+:8];
        shift_rows_func[105+:24]=cipher[97+:24];
    end
    else
    begin
    //decrypt
        shift_rows_func[1+:32]=cipher[1+:32];
        
        shift_rows_func[41+:24]=cipher[33+:24];
        shift_rows_func[33+:8]=cipher[57+:8];
        
        shift_rows_func[65+:16]=cipher[81+:16];
        shift_rows_func[81+:16]=cipher[65+:16];
        
        shift_rows_func[121+:8]=cipher[97+:8];
        shift_rows_func[97+:24]=cipher[105+:24];
    end
    end
    endfunction
endmodule
