`timescale 1ns / 1ps

module Memory(
MemWriteM,
ALUResultM,
WriteDataM,
ReadDataM,
clk,
reset
    );
    
    input MemWriteM, clk, reset;
    input [31:0]ALUResultM, WriteDataM;
    output wire [31:0]ReadDataM;
    
    
    DataMemory DataMemory(.A(ALUResultM),
                          .WD(WriteDataM),
                          .RD(ReadDataM),
                          .WE(MemWriteM),
                          .clk(clk),
                          .reset(reset));                
endmodule
