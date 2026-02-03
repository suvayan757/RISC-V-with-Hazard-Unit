`timescale 1ns / 1ps

module Fetch(
PCTargetF, PCSrcF, RDF, PCF, PCPlus4, clk, reset, PC_EN
    );
    
    input [31:0]PCTargetF;
    input PCSrcF, clk, reset, PC_EN;
    output wire [31:0]RDF, PCF, PCPlus4;
    
    //internal wires
    wire [31:0]PCF_bar;
    
    //Mux one
    assign PCF_bar = PCSrcF ? PCTargetF : PCPlus4;
    
    //Program Counter
    ProgramCounter ProgramCounter(.PC_NEXT(PCF_bar),
                                  .PC(PCF),
                                  .clk(clk),
                                  .reset(reset),
                                  .EN(PC_EN));
    
    //Instruction Memory
    InstructionMemory InstructionMemory(.A(PCF),
                                        .RD(RDF));
                                        
                                    
   //Adder (Next instruction address)
   assign PCPlus4 = PCF + {{29{1'b0}},3'b100};  
                                      
endmodule
