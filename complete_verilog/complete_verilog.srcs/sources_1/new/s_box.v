`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2021 17:02:02
// Design Name: 
// Module Name: s_box
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

module s_box();
    function [8:1] s_box_func(input [8:1] in ,input mode);
        //lookup table for s box
        reg  [0:2047] sbox ;
        reg  [0:2047] isbox ;
        begin
            sbox[0+:128]=128'h637C777BF26B6FC53001672BFED7AB76;
            sbox[128+:128] =128'hCA82C97DFA5947F0ADD4A2AF9CA472C0;
            sbox[128*2+:128] =128'hB7FD9326363FF7CC34A5E5F171D83115;
            sbox[128*3+:128] =128'h04C723C31896059A071280E2EB27B275;
            sbox[128*4+:128] =128'h09832C1A1B6E5AA0523BD6B329E32F84;
            sbox[128*5+:128] =128'h53D100ED20FCB15B6ACBBE394A4C58CF;
            sbox[128*6+:128] =128'hD0EFAAFB434D338545F9027F503C9FA8;
            sbox[128*7+:128] =128'h51A3408F929D38F5BCB6DA2110FFF3D2;
            sbox[128*8+:128] =128'hCD0C13EC5F974417C4A77E3D645D1973;
            sbox[128*9+:128] =128'h60814FDC222A908846EEB814DE5E0BDB;
            sbox[128*10+:128]=128'hE0323A0A4906245CC2D3AC629195E479;
            sbox[128*11+:128]=128'hE7C8376D8DD54EA96C56F4EA657AAE08;
            sbox[128*12+:128]=128'hBA78252E1CA6B4C6E8DD741F4BBD8B8A;
            sbox[128*13+:128]=128'h703EB5664803F60E613557B986C11D9E;
            sbox[128*14+:128]=128'hE1F8981169D98E949B1E87E9CE5528DF;
            sbox[128*15+:128]=128'h8CA1890DBFE6426841992D0FB054BB16;
            
            
            isbox[0+:128]=128'h52096AD53036A538BF40A39E81F3D7FB;
            isbox[128+:128]=128'h7CE339829B2FFF87348E4344C4DEE9CB;
            isbox[128*2+:128]=128'h547B9432A6C2233DEE4C950B42FAC34E;
            isbox[128*3+:128]=128'h082EA16628D924B2765BA2496D8BD125;
            isbox[128*4+:128]=128'h72F8F66486689816D4A45CCC5D65B692;
            isbox[128*5+:128]=128'h6C704850FDEDB9DA5E154657A78D9D84;
            isbox[128*6+:128]=128'h90D8AB008CBCD30AF7E45805B8B34506;
            isbox[128*7+:128]=128'hD02C1E8FCA3F0F02C1AFBD0301138A6B;
            isbox[128*8+:128]=128'h3A9111414F67DCEA97F2CFCEF0B4E673;
            isbox[128*9+:128]=128'h96AC7422E7AD3585E2F937E81C75DF6E;
            isbox[128*10+:128]=128'h47F11A711D29C5896FB7620EAA18BE1B;
            isbox[128*11+:128]=128'hFC563E4BC6D279209ADBC0FE78CD5AF4;
            isbox[128*12+:128]=128'h1FDDA8338807C731B11210592780EC5F;
            isbox[128*13+:128]=128'h60517FA919B54A0D2DE57A9F93C99CEF;
            isbox[128*14+:128]=128'hA0E03B4DAE2AF5B0C8EBBB3C83539961;
            isbox[128*15+:128]=128'h172B047EBA77D626E169146355210C7D;
            s_box_func = mode?sbox[(in[8:5]*128+in[4:1]*8)+:8]:isbox[(in[8:5]*128+in[4:1]*8)+:8];
    //        $display("%h",sbox);
    //        $display("%d",(in[8:5]*128+in[4:1]*8));
        end
        
        //out=mode?encrypt(mode=1):decryot(mode=0)
        
    endfunction

endmodule
