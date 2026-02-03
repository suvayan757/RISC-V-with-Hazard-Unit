`timescale 1ns / 1ps

module tb_top;
    
    reg clk;
    reg reset;

    top uut (
        .clk(clk),
        .reset(reset)
    );
    

    always #5 clk = ~clk;

    initial begin
        clk = 1;
        reset = 1;
        
        #10;
        reset = 0;
       
        #500;
        
        $display("Simulation complete");
        $finish;
    end
    
endmodule
