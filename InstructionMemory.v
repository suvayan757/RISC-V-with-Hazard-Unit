`timescale 1ns / 1ps

module InstructionMemory(
A, RD
    );
    input [31:0]A;
    output [31:0] RD;
    
    reg [31:0]MEM[0:1023];
    
    integer i;
       

    //read the assembly code
    initial begin
//        MEM[0] = 32'hFFC4A303;  //0x0000 L7: lw x6, -4(x9) I
//        MEM[1] = 32'h0064A423;  //0x0004 sw x6, 8(x9)      S
//        MEM[2] = 32'h0062E233;  //0x0008 or x4, x5, x6     R 
//        MEM[3] = 32'hFE420AE3;  //0x000C beq x4, x4, L7    B 
        
        MEM[0] = 32'h00500293;  
        MEM[1] = 32'h00200113;  
        MEM[2] = 32'h005101B3;
        
//        MEM[0] = 32'h00520433;  //0x0000 add x8, x4, x5  R
//        MEM[1] = 32'h40340133;  //0x0004 sub x2, x8, x3  R
//        MEM[2] = 32'h008864B3;  //0x0008 or x9, x16, x8  R 
//        MEM[3] = 32'h00C473B3;  //0x000C and x7, x8, x12 R
//        MEM[4] = 32'h00520433;  //0x0000 add x8, x4, x5  R 


//        MEM[0] = 32'hFFC4A383;  //0x0000 lw x7, -4(x9)  I
//        MEM[1] = 32'h0033F433;  //0x0004 and x8, x7, x3 R 
//        MEM[2] = 32'h00736633;  //0x000C or x12, x6, x7 R
//        MEM[3] = 32'h402381B3;  //0x0008 sub x3, x7, x2 R

        
//        MEM[0]  = 32'h00500113; // 0x0000: addi x2, x0, 5    (Initialize x2 = 5)
//        MEM[1]  = 32'h00C00193; // 0x0004: addi x3, x0, 12   (Initialize x3 = 12)
//        MEM[2]  = 32'hFF718393; // 0x0008: addi x7, x3, -9   (x7 = x3 - 9 = 3)
//        MEM[3]  = 32'h0023E233; // 0x000C: or   x4, x7, x2   (x4 = 3 OR 5 = 7)
//        MEM[4]  = 32'h0041F2B3; // 0x0010: and  x5, x3, x4   (x5 = 12 AND 7 = 4)
//        MEM[5]  = 32'h004282B3; // 0x0014: add  x5, x5, x4   (x5 = 4 + 7 = 11)
//        MEM[6]  = 32'h02728863; // 0x0018: beq  x5, x7, 40   (Branch to 0x40 if x5 == x7)
//        MEM[7]  = 32'h0041A233; // 0x001C: slt  x4, x3, x4   (Set Less Than)
//        MEM[8]  = 32'h00020463; // 0x0020: beq  x4, x0, 8    (Branch to 0x28 if x4 == 0)
//        MEM[9]  = 32'h00000293; // 0x0024: addi x5, x0, 0    (x5 = 0)
//        MEM[10] = 32'h0023A233; // 0x0028: slt  x4, x7, x2   (x4 = (x7 < x2) ? 1 : 0)
//        MEM[11] = 32'h005203B3; // 0x002C: add  x7, x4, x5   (x7 = x4 + x5)
//        MEM[12] = 32'h402383B3; // 0x0030: sub  x7, x7, x2   (x7 = x7 - x2)
//        MEM[13] = 32'h0471AA23; // 0x0034: sw   x7, 84(x3)   (Store x7 to Mem[x3 + 84])
//        MEM[14] = 32'h06002103; // 0x0038: lw   x2, 96(x0)   (Load x2 from Mem[96])
//        MEM[15] = 32'h005104B3; // 0x003C: add  x9, x2, x5   (x9 = x2 + x5)
//        MEM[16] = 32'h008001EF; // 0x0040: jal  x3, 8        (Jump to 0x48, link x3)
//        MEM[17] = 32'h00100113; // 0x0044: addi x2, x0, 1    (x2 = 1)
//        MEM[18] = 32'h00910133; // 0x0048: add  x2, x2, x9   (x2 = x2 + x9)
//        MEM[19] = 32'h0221A023; // 0x004C: sw   x2, 32(x3)   (Store x2 to Mem[x3 + 32])
//        MEM[20] = 32'h00210063; // 0x0050: beq  x2, x2, 0    (Infinite Loop / Stop)
  
    end
    
    //assign RD = MEM[A[11:2]]; //A[1:0] is always 00 as byte addressable
    
    assign RD = MEM[A[11:2]];
endmodule
