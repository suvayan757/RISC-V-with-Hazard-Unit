`timescale 1ns / 1ps

module ALUDecoder(
op5,
funct3,
funct7,
ALUOp,
ALUControlD
    );
    
    input op5, funct7;
    input [2:0]funct3;
    input [1:0]ALUOp;
    output [2:0]ALUControlD;
    
    wire [1:0] concatenation;
    
    assign concatenation = {op5, funct7};
    
    assign ALUControlD = (ALUOp == 2'b00) ? 3'b000 : // lw, sw
                        (ALUOp == 2'b01) ? 3'b001 :  // beq
                        (ALUOp == 2'b10) & (funct3 == 3'b010) ? 3'b101 : //set less than slt
                        (ALUOp == 2'b10) & (funct3 == 3'b110) ? 3'b011 : //or
                        (ALUOp == 2'b10) & (funct3 == 3'b111) ? 3'b010 : //and
                        (ALUOp == 2'b10) & (funct3 == 3'b000) & (concatenation == 2'b11)? 3'b001 : //sub
                        (ALUOp == 2'b10) & (funct3 == 3'b000) & (concatenation != 2'b11)? 3'b000 : 3'b000;//add
endmodule
