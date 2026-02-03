`timescale 1ns / 1ps

module ALU(
A,
B,
ALUControlE,
ALUResultE,
zeroE,
negE,
carryE,
overflowE
    );
    
    input [31:0]A, B;
    input [2:0]ALUControlE;
    output reg [31:0]ALUResultE;
    output reg zeroE, negE, carryE, overflowE;
    
     //internal wires
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;
    wire [31:0] mux_1;
    wire [31:0] mux_2;
    wire [31:0] sum;
    wire [31:0] slt;
    wire [31:0]zeroExt;
    wire cout;
    
    assign a_and_b = A & B;
    assign a_or_b = A | B;
    assign not_b = ~B;
    assign mux_1 = ALUControlE[0] ? not_b : B;
    assign {cout, sum} = A + mux_1 + ALUControlE[0]; 

    //Flags
    always @(*) begin
        carryE = ~ALUControlE[1] & cout;
        zeroE = &(~ALUResultE);
        negE = ALUResultE[31];
        overflowE = (~ALUControlE[1]) & (~( A[31] ^ B[31] ^ ALUControlE[0])) & (A[31] ^ sum[31]); 
    end
    
    //Zero Extension
    assign zeroExt = {{31{1'b0}}, (overflowE ^ sum[31])};
    
    //MUX 2
    always @(*) begin
       case(ALUControlE)
          3'b000 : ALUResultE = sum;
          3'b001 : ALUResultE = sum;
          3'b010 : ALUResultE = a_and_b;
          3'b011 : ALUResultE = a_or_b;
          3'b101 : ALUResultE = zeroExt;
       endcase
    end
endmodule
