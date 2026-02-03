`timescale 1ns / 1ps

module ControlUnit(
op,
funct3,
funct7,
RegWrite_CU_D,
ResultSrcD,
MemWriteD,
JumpD,
BranchD,
ALUControlD,
ALUSrcD,
ImmSrcD
    );
    
    input [6:0]op;
    input [2:0]funct3;
    input funct7;
    
    output wire RegWrite_CU_D, MemWriteD, JumpD, BranchD, ALUSrcD;
    output wire [2:0] ALUControlD;
    output wire [1:0]ResultSrcD,ImmSrcD;
    
    wire [1:0]ALUOp;
    
    MainDecoder MainDecoder(.op(op),
                            .RegWrite_CU_D(RegWrite_CU_D),
                            .ResultSrcD(ResultSrcD),
                            .MemWriteD(MemWriteD),
                            .JumpD(JumpD),
                            .BranchD(BranchD),
                            .ALUSrcD(ALUSrcD),
                            .ImmSrcD(ImmSrcD),
                            .ALUOp(ALUOp));
    
    ALUDecoder ALUDecoder(.op5(op[5]),
                          .funct3(funct3),
                          .funct7(funct7),
                          .ALUOp(ALUOp),
                          .ALUControlD(ALUControlD));

endmodule
