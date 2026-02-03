`timescale 1ns / 1ps

module Decode(
InstrD, PCD, PCPlus4D, RegWriteD, ResultD, RD1, RD2, A3, ImmExtD, RegWrite_CU_D, MemWriteD, JumpD, BranchD, ALUSrcD, ResultSrcD, ALUControlD, clk, reset
    );
    
    input clk, reset, RegWriteD;
    input [31:0]InstrD, PCD, PCPlus4D, ResultD;
    input [4:0]A3;
    
    output wire [31:0]RD1, RD2, ImmExtD;
    output wire RegWrite_CU_D, MemWriteD, JumpD, BranchD, ALUSrcD;
    output wire [1:0]ResultSrcD;
    output wire [2:0]ALUControlD;
    
    wire [1:0]ImmSrcD;
    
    //Control Unit
    ControlUnit ControlUnit(.op(InstrD[6:0]),
                            .funct3(InstrD[14:12]),
                            .funct7(InstrD[30]),
                            .RegWrite_CU_D(RegWrite_CU_D),
                            .ResultSrcD(ResultSrcD),
                            .MemWriteD(MemWriteD),
                            .JumpD(JumpD),
                            .BranchD(BranchD),
                            .ALUControlD(ALUControlD),
                            .ALUSrcD(ALUSrcD),
                            .ImmSrcD(ImmSrcD));
    
    //Register File
    RegisterFile RegisterFile(.A1(InstrD[19:15]),
                              .A2(InstrD[24:20]),
                              .A3(A3),
                              .WD3(ResultD),
                              .WE3(RegWriteD),
                              .RD1(RD1),
                              .RD2(RD2),
                              .clk(clk),
                              .reset(reset));
    
    //Extend
    Extend Extend(.in(InstrD[31:0]),
                  .ImmSrcD(ImmSrcD),
                  .ImmExtD(ImmExtD));
    
    
    
endmodule
