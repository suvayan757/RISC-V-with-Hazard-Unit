`timescale 1ns / 1ps

module MainDecoder(
op,
RegWrite_CU_D,
ResultSrcD,
MemWriteD,
JumpD,
BranchD,
ALUSrcD,
ImmSrcD,
ALUOp
    );
    
    input [6:0]op;
    output reg RegWrite_CU_D, MemWriteD, JumpD, BranchD, ALUSrcD;
    output reg [1:0] ALUOp;
    output reg [1:0]ResultSrcD,ImmSrcD;
    
    always @(*) begin
                          RegWrite_CU_D = 0;
                          ImmSrcD = 2'b00;
                          ALUSrcD = 0;
                          MemWriteD = 0;
                          ResultSrcD = 2'b00;
                          BranchD = 0;
                          ALUOp = 2'b00; 
                          JumpD = 0;
       case(op)
          7'b0000011 : begin  // lw instruction
                          RegWrite_CU_D = 1;
                          ImmSrcD = 2'b00;
                          ALUSrcD = 1;
                          MemWriteD = 0;
                          ResultSrcD = 2'b01;
                          BranchD = 0;
                          ALUOp = 2'b00; 
                          JumpD = 0;
                       end
          7'b0100011 : begin  // sw instruction
                          RegWrite_CU_D = 0;
                          ImmSrcD = 2'b01;
                          ALUSrcD = 1;
                          MemWriteD = 1;
                          ResultSrcD = 2'b00;
                          BranchD = 0;
                          ALUOp = 2'b00; 
                          JumpD = 0;
                       end
          7'b0110011 : begin  // R-type instruction
                          RegWrite_CU_D = 1;
                          ImmSrcD = 2'b00;
                          ALUSrcD = 0;
                          MemWriteD = 0;
                          ResultSrcD = 2'b00;
                          BranchD = 0;
                          ALUOp = 2'b10; 
                          JumpD = 0;
                       end   
          7'b1100011 : begin  // beq instruction
                          RegWrite_CU_D = 0;
                          ImmSrcD = 2'b10;
                          ALUSrcD = 0;
                          MemWriteD = 0;
                          ResultSrcD = 2'b00;
                          BranchD = 1;
                          ALUOp = 2'b01; 
                          JumpD = 0;
                       end 
          7'b0010011 : begin  // I-type ALU instruction
                          RegWrite_CU_D = 1;
                          ImmSrcD = 2'b00;
                          ALUSrcD = 1;
                          MemWriteD = 0;
                          ResultSrcD = 2'b00;
                          BranchD = 0;
                          ALUOp = 2'b10; 
                          JumpD = 0;
                      end
         7'b1101111 : begin  // jal instruction
                          RegWrite_CU_D = 1;
                          ImmSrcD = 2'b11;
                          ALUSrcD = 1'bx;
                          MemWriteD = 0;
                          ResultSrcD = 2'b10;
                          BranchD = 0;
                          ALUOp = 2'bxx; 
                          JumpD = 1;
                       end                                   
       endcase
    end
endmodule
