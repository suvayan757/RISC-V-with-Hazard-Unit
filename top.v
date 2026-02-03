`timescale 1ns / 1ps

module top(clk, reset, ResultOut);
    input clk, reset;
    output [31:0] ResultOut;
 
    //Pipeline Registers
    
    //Fetch registers
    wire [31:0]RDF, PCF, PCPlus4F;
    wire StallF;
    
    //Decode Registers
    reg [31:0]InstrD, PCD, PCPlus4D;
    wire [31:0] RD1D, RD2D, ImmExtD;
    wire RegWrite_CU_D, MemWriteD, JumpD, BranchD, ALUSrcD;
    wire [1:0]ResultSrcD;
    wire [2:0]ALUControlD;
    wire [4:0] RdD = InstrD[11:7];
    wire [4:0]Rs1D = InstrD[19:15];
    wire [4:0]Rs2D = InstrD[24:20];
    wire EN_IF_D, StallD, FlushD;
    
    //Execute Registers
    reg RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE;
    reg [1:0]ResultSrcE;
    reg [2:0]ALUControlE; 
    reg [4:0] RdE;
    reg [31:0] RD1E, RD2E, PCE, ImmExtE, PCPlus4E;
    wire PCSrcE;
    wire [31:0]PCTargetE, ALUResultE, WriteDataE ;
    reg [4:0]Rs1E, Rs2E;
    wire [1:0] ForwardAE, ForwardBE;
    wire FlushE, CLR_D_EX;
    
    //Memory Registers
    reg RegWriteM, MemWriteM; 
    reg [1:0]ResultSrcM;
    reg [31:0] ALUResultM, WriteDataM, RdM, PCPlus4M;
    wire [31:0] ReadDataM;
    
    //Write Back Registers
    reg [4:0]RdW;
    reg RegWriteW; 
    reg [1:0]ResultSrcW;
    reg [31:0]ALUResultW, ReadDataW, PCPlus4W;
    wire [31:0]ResultW;
    
    
    //Computation
    
    //Fetch Cycle
    Fetch Fetch_Cycle(.PCTargetF(PCTargetE),
                      .PCSrcF(PCSrcE),
                      .RDF(RDF),
                      .PCF(PCF),
                      .PCPlus4(PCPlus4F),
                      .clk(clk),
                      .reset(reset),
                      .PC_EN(StallF));
                      
                           
   
   
   assign EN_IF_D = StallD;                  
   // Fetch - Decode Register               
   always @(posedge clk or posedge reset) begin
//      if(~EN_IF_D) begin
          if((reset == 1) | (FlushD == 1)) begin
             InstrD <= 0;
             PCD <= 0;
             PCPlus4D <= 0;
          end
          else if(~EN_IF_D)begin
             InstrD <= RDF;
             PCD <= PCF;
             PCPlus4D <= PCPlus4F;
          end
//      end
   end      
   
   // Decode Cycle
   Decode Decode_Cycle(.InstrD(InstrD),
                       .PCD(PCD),
                       .PCPlus4D(PCPlus4D),
                       .RegWriteD(RegWriteW),
                       .ResultD(ResultW),
                       .RD1(RD1D),
                       .RD2(RD2D),
                       .A3(RdW),
                       .ImmExtD(ImmExtD),
                       .RegWrite_CU_D(RegWrite_CU_D),
                       .MemWriteD(MemWriteD),
                       .JumpD(JumpD),
                       .BranchD(BranchD),
                       .ALUSrcD(ALUSrcD),
                       .ResultSrcD(ResultSrcD),
                       .ALUControlD(ALUControlD),
                       .clk(clk),
                       .reset(reset));  
                       
                   
   assign CLR_D_EX = FlushE;                    
   //Decode - Execute Register   
   always @(posedge clk or posedge reset) begin
      if((reset == 1) || (CLR_D_EX == 1)) begin
        RegWriteE <= 0;
        MemWriteE <= 0; 
        JumpE     <= 0;
        BranchE   <= 0;
        ALUSrcE   <= 0;
        ResultSrcE <= 0;
        ALUControlE <= 0;
        RdE <= 0;
        RD1E <= 0;
        RD2E <= 0;
        Rs1E <= 0;
        Rs2E <= 0;
        PCE <= 0;
        ImmExtE <= 0;
        PCPlus4E <= 0;
      end
      else begin
        RegWriteE <= RegWrite_CU_D;
        MemWriteE <= MemWriteD; 
        JumpE     <= JumpD;
        BranchE   <= BranchD;
        ALUSrcE   <= ALUSrcD;
        ResultSrcE <= ResultSrcD;
        ALUControlE <= ALUControlD;
        RdE <= RdD;
        RD1E <= RD1D;
        RD2E <= RD2D;
        Rs1E <= Rs1D;
        Rs2E <= Rs2D;
        PCE <= PCD;
        ImmExtE <= ImmExtD;
        PCPlus4E <= PCPlus4D;
      end
   end             
   
   //Execute Cycle
   Execute Execute_Cycle(
                   .JumpE(JumpE),
                   .BranchE(BranchE),
                   .ALUControlE(ALUControlE),
                   .ALUSrcE(ALUSrcE),
                   .RD1E(RD1E),
                   .RD2E(RD2E),
                   .PCE(PCE),
                   .ImmExtE(ImmExtE),
                   .PCTargetE(PCTargetE),
                   .PCSrcE(PCSrcE),
                   .ALUResultE(ALUResultE),
                   .WriteDataE(WriteDataE),
                   .ResultW(ResultW),
                   .ALUResultM(ALUResultM),
                   .ForwardAE(ForwardAE),
                   .ForwardBE(ForwardBE)
                    );
                   
               
   //Execute - Memory Registers
   always @(posedge clk or posedge reset) begin
      if(reset) begin
        RegWriteM <= 0;
        MemWriteM <= 0; 
        ResultSrcM <= 0;
        ALUResultM <= 0;
        WriteDataM <= 0;
        RdM <= 0;
        PCPlus4M <= 0;
      end
      else begin
        RegWriteM <= RegWriteE;
        MemWriteM <= MemWriteE; 
        ResultSrcM <= ResultSrcE;
        ALUResultM <= ALUResultE;
        WriteDataM <= WriteDataE;
        RdM <= RdE;
        PCPlus4M <= PCPlus4E;
      end
   end     
   
   //Memory cycle
   Memory Memory_Cycle(.MemWriteM(MemWriteM),
                       .ALUResultM(ALUResultM),
                       .WriteDataM(WriteDataM),
                       .ReadDataM(ReadDataM),
                       .clk(clk),
                       .reset(reset));
                       
                   
   //Memory - WriteBack Registers
   always @(posedge clk or posedge reset) begin
      if(reset) begin
        RegWriteW <= 0; 
        ResultSrcW <= 0;
        ALUResultW <= 0;
        ReadDataW <= 0;
        RdW <= 0;
        PCPlus4W <= 0;
      end
      else begin
        RegWriteW <= RegWriteM; 
        ResultSrcW <= ResultSrcM;
        ALUResultW <= ALUResultM;
        ReadDataW <= ReadDataM;
        RdW <= RdM;
        PCPlus4W <= PCPlus4M;
      end
   end
   
   //WriteBack Cycle
   WriteBack WriteBack_Cycle(.ALUResultW(ALUResultW),
                             .ReadDataW(ReadDataW),
                             .PCPlus4W(PCPlus4W),
                             .ResultW(ResultW),
                             .ResultSrcW(ResultSrcW));
                             
                         
   assign ResultOut = ResultW;   
   
   //Hazard Unit
   Hazard_Unit Hazard_Unit(
                            .StallF(StallF),
                            .StallD(StallD),
                            .Rs1D(Rs1D),
                            .Rs2D(Rs2D),
                            .FlushE(FlushE),
                            .FlushD(FlushD),
                            .RdE(RdE),
                            .Rs1E(Rs1E),
                            .Rs2E(Rs2E),
                            .PCSrcE(PCSrcE),
                            .RdM(RdM),
                            .RegWriteM(RegWriteM),
                            .RdW(RdW),
                            .RegWriteW(RegWriteW),
                            .ForwardAE(ForwardAE),
                            .ForwardBE(ForwardBE),
                            .ResultSrcE0(ResultSrcE[0]));
   
   //Hazard Unit
//   Hazard_Unit Hazard_Unit(
//                           .StallF(StallF),
//                           .StallD(StallD),
//                           .FlushD(FlushD),
//                           .Rs1D(InstrD[19:15]),
//                           .Rs2D(InstrD[24:20]),
//                           .FlushE(FlushE),
//                           .RdE(RdE),
//                           .Rs2E(Rs2E),
//                           .Rs1E(Rs1E),
//                           .PCSrcE(PCSrcE),
//                           .ResultSrcE0(ResultSrcE[0]),
//                           .RdM(RdM),
//                           .RegWriteM(RegWriteM),
//                           .RdW(RdW),
//                           .RegWriteW(RegWriteW),
//                           .ForwardAE(ForwardAE),
//                           .ForwardBE(ForwardAE));
                              
endmodule
