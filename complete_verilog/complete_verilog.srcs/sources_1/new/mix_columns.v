`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2021 23:57:23
// Design Name: 
// Module Name: mix_columns
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


//delay of 20 sec , i.e 1 clock cycle for this output to be ready for next
module mix_columns();
    
    function [7:0] galios_mul(input [7:0] in,m);
        //{0D}* M(x) = (m0 + m5 + m6) + (m1 + m5 + m7) x + (m0 + m2 + m6) x2 + (m0 + m1 + m3 + m5 + m6 + m7) x3 + (m1 + m2 + m4 + m5 + m7) x4+ (m2 + m3 + m5 + m6) x5 + (m3 + m4 + m6 + m7) x6 + (m4 + m5 + m7) x7. 
        //{0E}* M(x) = (m5 + m6 + m7) + (m0 + m5) x + (m0 + m1 + m6) x2 + (m0 + m1 + m2 + m5 + m6) x3 + (m1 + m2 + m3 + m5) x4+ (m2 + m3 + m4 + m6) x5 + (m3 + m4 + m5 + m7) x6 + (m4 + m5 + m6) x7.                                                                        
        //{0B}* M(x)= (m0 + m5 + m7) + (m0 + m1 + m5 + m6 + m7) x + (m1 + m2 + m6 + m7) x2 + (m0 + m2 + m3 + m5) x3 + (m1 + m3 + m4 + m5 + m6 + m7) x4+ (m2 + m4 + m5 + m6 + m7) x5 + (m3 + m5 + m6 + m7) x6 + (m4 + m6 + m7) x7.               
        //{09}* M(x) = (m0 + m5) + (m1 + m5 + m6) x + (m2 + m6 + m7) x2 + (m0 + m3 + m5 + m7) x3 + (m1 + m4 + m5 + m6) x4+ (m2 + m5 + m6 + m7) x5 + (m3 + m6 + m7) x6 + (m4 + m7) x7.                                                                                                   
        
        //{03}* M(x) = (m0 + m7) + (m0 + m1 + m7) x + (m1 + m2) x2 + (m2 + m3 + m7) x3 + (m3 + m4 + m7) x4+ (m4 + m5) x5 + (m5 + m6) x6 + (m6 + m7) x7.      
        //{02}* M(x) = (m7) + (m0 +m7) x + (m1) x2 + (m2 + m7) x3 + (m3 + m7) x4+ (m4) x5 + (m5) x6 + (m6) x7.                                                                  
        //{01}* M(x) = M(x)
        
        begin
           
           case(in)
               8'h0D:galios_mul={m[4]^m[5]^m[7],m[3]^m[4]^m[6]^m[7],m[2]^m[3]^m[5]^m[6],m[1]^m[2]^m[4]^m[5]^m[7],m[0]^m[1]^m[3]^m[5]^m[6]^m[7],m[0]^m[2]^m[6],m[1]^m[5]^m[7],m[0]^m[5]^m[6]};
               8'h0E:galios_mul={m[4]^m[5]^m[6],m[3]^m[4]^m[5]^m[7],m[2]^m[3]^m[4]^m[6],m[1]^m[2]^m[3]^m[5],m[0]^m[1]^m[2]^m[5]^m[6],m[0]^m[1]^m[6],m[0]^m[5],m[5]^m[6]^m[7]};
               8'h0B:galios_mul={m[4]^m[6]^m[7],(m[3]^m[5]^m[6]^m[7]),(m[2]^m[4]^m[5]^m[6]^m[7]),(m[1]^m[3]^m[4]^m[5]^m[6]^m[7]),(m[0]^m[2]^m[3]^m[5]),(m[1]^m[2]^m[6]^m[7]),(m[0]^m[1]^m[5]^m[6]^m[7]),(m[0]^m[5]^m[7])};
               8'h09:galios_mul={(m[4]^m[7]),(m[3]^m[6]^m[7]),(m[2]^m[5]^m[6]^m[7]),(m[1]^m[4]^m[5]^m[6]),(m[0]^m[3]^m[5]^m[7]),(m[2]^m[6]^m[7]),(m[1]^m[5]^m[6]),(m[0]^m[5])};
               
               8'h03:galios_mul={m[6]^m[7],m[5]^m[6],m[4]^m[5],m[3]^m[4]^m[7],m[2]^m[3]^m[7],m[1]^m[2],m[0]^m[1]^m[7],m[0]^m[7]};
               8'h02:galios_mul={m[6],m[5],m[4],m[3]^m[7],m[2]^m[7],m[1],m[0]^m[7],m[7]};
               8'h01:galios_mul=m;
           endcase
    //	   $display("%h",val);   
        end
    endfunction
    function [7:0] mix_mul(input [7:0] in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
        reg [7:0] val1,val2,val3,val4;
        begin
            val1=galios_mul(in1,cipher1);
            val2=galios_mul(in2,cipher2);
            val3=galios_mul(in3,cipher3);
            val4=galios_mul(in4,cipher4);
            mix_mul =val1^val2^val3^val4;
        end
    endfunction
    
    
    function [128:1] mix_columns_func(input [128:1] cipher,input mode);
    reg [8:1] val1,val2,val3,val4;
    reg [8:1] cipher1,cipher2,cipher3,cipher4;
    reg [8:1] in1,in2,in3,in4;
    integer i,j;
    begin
        if(mode)
        begin
        //encrypt
        //02 03 01 01
        //01 02 03 01
        //01 01 02 03
        //03 01 01 02
        
        //1st column
        for(i=8;i<=32;i=i+8)
        begin
            cipher1=cipher[i-:8];cipher2=cipher[i+32-:8];cipher3=cipher[i+64-:8];cipher4=cipher[i+96-:8];
            in1=8'h02;in2=8'h03;in3=8'h01;in4=8'h01;
            mix_columns_func[i-:8]=mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
            //        $strobe("%b",mix[8:1]);
            in1=8'h01;in2=8'h02;in3=8'h03;in4=8'h01;
            mix_columns_func[i+32-:8] =mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
            //        $strobe("%b",mix[40:33]);
            in1=8'h01;in2=8'h01;in3=8'h02;in4=8'h03;
            mix_columns_func[i+64-:8] =mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
            //        $strobe("%b",mix[72:65]);
            in1=8'h03;in2=8'h01;in3=8'h01;in4=8'h02;
            mix_columns_func[i+96-:8] =mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
        end
        
//        //2nd column
//        cipher1=cipher[16:9];cipher2=cipher[48:41];cipher3=cipher[80:73];cipher4=cipher[112:105];
//        in1=8'h02;in2=8'h03;in3=8'h01;in4=8'h01;
//        mix[16:9] =mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
////        $strobe("%b",mix[16:9]);
//        in1=8'h01;in2=8'h02;in3=8'h03;in4=8'h01;
//        mix[48:41] =mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
////        $strobe("%b",mix[48:41]);
//        in1=8'h01;in2=8'h01;in3=8'h02;in4=8'h03;
//        mix[80:73] =mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
////        $strobe("%b",mix[80:73]);
//        in1=8'h03;in2=8'h01;in3=8'h01;in4=8'h02;
//        mix[112:105] =mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
////        $strobe("%b",mix[112:105]);
        
        end
        else
        begin
        //decrypt
        //0E 0B 0D 09
        //09 0E 0B 0D
        //0D 09 0E 0B
        //0B 0D 09 0E
        //1st column
        for(i=8;i<=32;i=i+8)
        begin
            cipher1=cipher[i-:8];cipher2=cipher[i+32-:8];cipher3=cipher[i+64-:8];cipher4=cipher[i+96-:8];
            in1=8'h0E;in2=8'h0B;in3=8'h0D;in4=8'h09;
            mix_columns_func[i-:8]=mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
            //        $strobe("%b",mix[8:1]);
            in1=8'h09;in2=8'h0E;in3=8'h0B;in4=8'h0D;
            mix_columns_func[i+32-:8] =mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
            //        $strobe("%b",mix[40:33]);
            in1=8'h0D;in2=8'h09;in3=8'h0E;in4=8'h0B;
            mix_columns_func[i+64-:8] =mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
            //        $strobe("%b",mix[72:65]);
            in1=8'h0B;in2=8'h0D;in3=8'h09;in4=8'h0E;
            mix_columns_func[i+96-:8] =mix_mul(in1,in2,in3,in4,cipher1,cipher2,cipher3,cipher4);
        end
       
//        //2nd column
//        cipher1<=cipher[16:9];cipher2<=cipher[48:41];cipher3<=cipher[80:73];cipher4<=cipher[112:105];
//        in1<=8'h0E;in2<=8'h0B;in3<=8'h0D;in4<=8'h09;
//        mix[16:9] =val1^val2^val3^val4;
//        $strobe("%b",mix[16:9]);
//        in1<=8'h09;in2<=8'h0E;in3<=8'h0B;in4<=8'h0D;
//        mix[48:41] =val1^val2^val3^val4;
//        $strobe("%b",mix[48:41]);
//        in1<=8'h0D;in2<=8'h09;in3<=8'h0E;in4<=8'h0B;
//        mix[80:73] =val1^val2^val3^val4;
//        $strobe("%b",mix[80:73]);
//        in1<=8'h0B;in2<=8'h0D;in3<=8'h09;in4<=8'h0E;
//        mix[112:105] =val1^val2^val3^val4;
//        $strobe("%b",mix[112:105]);
        
        end
    end
    endfunction
endmodule
