`timescale 1ns / 1ps

module WriteBack(
ALUResultW,
ReadDataW,
PCPlus4W,
ResultW,
ResultSrcW
    );
    
    input [31:0]ALUResultW, ReadDataW, PCPlus4W;
    input [1:0]ResultSrcW;
    output reg [31:0]ResultW;
    
    always @(*) begin
       case(ResultSrcW)
          2'b00 : ResultW = ALUResultW;
          2'b01 : ResultW = ReadDataW;
          2'b10 : ResultW = PCPlus4W;
       endcase
    end
    
endmodule
