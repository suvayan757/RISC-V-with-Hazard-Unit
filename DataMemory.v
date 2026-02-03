`timescale 1ns / 1ps

module DataMemory(
A,
WD,
RD,
WE,
clk,
reset
    );
    
    input [31:0]A, WD;
    input WE, clk, reset;
    output wire [31:0]RD;
    
    reg [31:0]MEM[0:1023];
    integer i,k=0;
    
//    initial begin
//        for (i = 0; i < 1024; i = i + 1) begin
//            MEM[i] = i;
//        end
//    end
    
    initial begin
       MEM[10'h2000] = 32'hA;
       $monitor("Time = %t | MEM[%d] = %h", $time, k, MEM[k]);
       k=k+1;
    end
    
    //Read
//    always @(*) begin
//       if(WE == 0) RD = MEM[A[11:2]];
//       else        RD = 32'b0;
//    end
    assign RD = (WE) ? 32'b0 : MEM[A[11:2]];
    
    //Write
    always @(posedge clk) begin
       if(WE == 1) MEM[A[11:2]] <= WD;
    end
endmodule
