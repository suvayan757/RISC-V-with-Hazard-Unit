`timescale 1ns / 1ps

module Hazard_Unit(
StallF,
StallD,
Rs1D,
Rs2D,
FlushD,
FlushE,
RdE,
Rs1E,
Rs2E,
RdM,
RegWriteM,
RdW,
RegWriteW,
ForwardAE,
ForwardBE,
PCSrcE,
ResultSrcE0
    );
    
    input [4:0] Rs1E, Rs2E, RdE, RdM, RdW, Rs1D, Rs2D;
    input RegWriteM, RegWriteW, ResultSrcE0, PCSrcE;
    output reg StallF, StallD, FlushE, FlushD;
    output reg [1:0]ForwardAE, ForwardBE;
    
    reg lwStall = 0;
    
    always @(*) begin //Forward to solve data hazards when possible
        if(((Rs1E == RdM) & RegWriteM) & (Rs1E != 0))
            ForwardAE = 2'b10;
        else if (((Rs1E == RdW) & RegWriteW) & (Rs1E != 0))
            ForwardAE = 2'b01;
        else 
            ForwardAE = 2'b00;

        if(((Rs2E == RdM) & RegWriteM) & (Rs2E != 0))
            ForwardBE = 2'b10;
        else if (((Rs2E == RdW) & RegWriteW) & (Rs2E != 0))
            ForwardBE = 2'b01;
        else 
            ForwardBE = 2'b00;
    end
    
    always @(*) begin 
    //Stall when a load hazard occurs
        lwStall = ResultSrcE0 & ((Rs1D == RdE) | (Rs2D == RdE));
        StallF = lwStall;
        StallD = lwStall;
        
    //Flush when a branch is taken or a load introduces a bubble
        FlushD = PCSrcE;
        FlushE = lwStall | PCSrcE;
    end
    
endmodule
