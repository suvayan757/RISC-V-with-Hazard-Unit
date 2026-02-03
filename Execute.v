`timescale 1ns / 1ps

module Execute(
JumpE,
BranchE,
ALUControlE,
ALUSrcE,
RD1E,
RD2E,
PCE,
ImmExtE,
PCTargetE,
PCSrcE,
ALUResultE,
WriteDataE,
ResultW,
ALUResultM,
ForwardAE, //Hazard signal
ForwardBE  //Hazard signal
    );
    
    input JumpE, BranchE, ALUSrcE;
    input [2:0]ALUControlE;
    input [31:0]RD1E, RD2E, PCE, ImmExtE;
    input [1:0]ForwardAE, ForwardBE;
    input [31:0] ALUResultM, ResultW;
    
    output wire PCSrcE;
    output wire [31:0]PCTargetE, ALUResultE, WriteDataE;
    
    wire zeroE, negE, carryE, overflowE;
    reg [31:0]SrcBE;
    reg [31:0]SrcAE, SrcBE_inter;
    
    
    assign PCSrcE = (BranchE & zeroE) | JumpE;
//    assign SrcBE = ALUSrcE ? ImmExtE : SrcBE_inter;
    assign WriteDataE = SrcBE_inter;
    assign PCTargetE = PCE + ImmExtE;
    
//    assign SrcAE = (ForwardAE == 2'b00) ? RD1E :
//                   (ForwardAE == 2'b01) ? ResultW : 
//                   (ForwardAE == 2'b10) ? ALUResultM : RD1E;
               
//   assign SrcBE_inter = (ForwardBE == 2'b00) ? RD2E :
//                        (ForwardBE == 2'b01) ? ResultW : 
//                        (ForwardBE == 2'b10) ? ALUResultM : RD2E; 
    always @(*) begin
        case(ForwardAE)
            2'b00 : SrcAE = RD1E;
            2'b01 : SrcAE = ResultW;
            2'b10 : SrcAE = ALUResultM;
            default : SrcAE = RD1E;
        endcase
    end
    
    always @(*) begin
    
        
        case(ForwardBE)
            2'b00 : SrcBE_inter = RD2E;
            2'b01 : SrcBE_inter = ResultW;
            2'b10 : SrcBE_inter = ALUResultM;
            default : SrcBE_inter = RD2E;
        endcase
        
        SrcBE = ALUSrcE ? ImmExtE : SrcBE_inter;
    end
    
    ALU ALU(.A(SrcAE),
            .B(SrcBE),
            .ALUControlE(ALUControlE),
            .ALUResultE(ALUResultE),
            .zeroE(zeroE),
            .negE(negE),
            .carryE(carryE),
            .overflowE(overflowE));
endmodule
