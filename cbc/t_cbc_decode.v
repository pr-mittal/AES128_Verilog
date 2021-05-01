`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2021 13:09:40
// Design Name: 
// Module Name: t_cbc_decode
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


module t_cbc_decode();
    reg [128:1] img[1:65536];//8 bit
    integer i;
    reg [128:1] key,cipher,prev;
    decrypt t_decrypt();
    integer file_id;
    initial begin
        key=128'h0f1571c947d9e8590cb7add6af7f6798;
        prev=128'h5468617473206D79204B756E67204675;
        //////////////////////////////////////////////read from file////////////////////////////////
        $readmemb("C:\\Users\\prana\\OneDrive\\Desktop\\udyam\\ichip\\ps2\\binary_cbc_encode.txt",img);
        ///////////////////////////////////writing////////////////////////////////////////////
        file_id=$fopen("C:\\Users\\prana\\OneDrive\\Desktop\\udyam\\ichip\\ps2\\binary_cbc_decode.txt","w");
        
        for(i=1;i<=65536;i=i+1)
        begin
        
            cipher=t_decrypt.decrypt_func(key,img[i]);//encoding
            cipher=cipher^prev;
            prev=img[i];
            $fwrite(file_id,"%b\n",cipher);//writing to file
        end
        $fclose(file_id);
        #10
        $finish;
    end
endmodule
