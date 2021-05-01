`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2021 13:03:40
// Design Name: 
// Module Name: t_read_image
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


module t_read_image();
reg [128:1] img[1:65536];//8 bit
integer i;
//////////////////////////////////////////////read from file////////////////////////////////
initial begin
    #10
    $readmemb("C:\\Users\\prana\\OneDrive\\Desktop\\udyam\\ichip\\ps2\\binary.txt",img); 
    #10
    for(i=0;i<16;i=i+1)
    begin
        $display("%b",img[i]);
    end
    #10
    $finish;
end

integer file_id;
///////////////////////////////////writing////////////////////////////////////////////
//    file_id=$fopen("C:\\Users\\prana\\OneDrive\\Desktop\\udyam\\ichip\\ps2\\binary.txt","w");
//    #10
//    for(i=0;i<16;i=i+1)
//    begin
//        $fwrite(file_id,"%02h",i);
//    end
//    $fclose(file_id);
//    #10
//    $finish;
//   end
    

endmodule
