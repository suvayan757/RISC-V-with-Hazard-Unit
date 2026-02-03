`timescale 1ns / 1ps

module Extend(
in,
ImmSrcD,
ImmExtD
    );
    
    input [31:0]in;
    input [1:0]ImmSrcD;
    output reg [31:0]ImmExtD;
    
    always@(*) begin
       case(ImmSrcD)
          2'b00 : ImmExtD = {{20{in[31]}}, in[31:20]};           //I-type
          2'b01 : ImmExtD = {{20{in[31]}}, in[31:25], in[11:7]}; //S-type
          2'b10 : ImmExtD = {{20{in[31]}}, in[7], in[30:25], in[11:8], 1'b0}; //B-type
          2'b11 : ImmExtD = {{12{in[31]}}, in[19:12], in[20], in[30:21], 1'b0}; //J-type
       endcase
    end
    
endmodule
