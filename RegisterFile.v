`timescale 1ns / 1ps

module RegisterFile(
A1,
A2,
A3,
WD3,
WE3,
RD1,
RD2,
clk,
reset
    );
    
    input [4:0]A1, A2, A3;
    input [31:0]WD3;
    input clk, reset, WE3;
    output wire [31:0]RD1, RD2;
    
    reg [31:0]Registers[0:31];
    integer i;
    
    initial begin
       Registers[0] = {32{1'b0}};
    end
    
    assign RD1 = Registers[A1];
    assign RD2 = Registers[A2];
    
    //Write operation
    always @(negedge clk) begin
       if(WE3) Registers[A3] <= WD3; 
    end
    
    initial begin
//       for(i = 1; i<32; i=i+1) Registers[i] <= {32{1'b0}};
//       Registers[4] = 32'he;
//////////////////////////////////////////////
       Registers[5] = 32'h6;
       Registers[6] = 32'hA;
       Registers[9] = 32'h4;
       
       /////////////////////////////////////////////
//       Registers[2] = 32'h2;
//       Registers[3] = 32'h3;
//       Registers[4] = 32'h4;
//       Registers[5] = 32'h5;
//       Registers[6] = 32'h6;
//       Registers[9] = 32'h4;
//       Registers[16] = 32'h10;
//       Registers[12] = 32'hC;
//       Registers[10] = 32'hA;
    end
endmodule
