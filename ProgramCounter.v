`timescale 1ns / 1ps

module ProgramCounter(
PC_NEXT,
PC,
clk,
reset,
EN
    );
    input [31:0] PC_NEXT;
    input clk, reset, EN;
    output reg [31:0]PC;
    
    always @(posedge clk or posedge reset) begin
//       if(~EN) begin
           if(reset)    PC <= {32{1'b0}};
           else if(~EN) PC <= PC_NEXT;
//        end
    end
endmodule
