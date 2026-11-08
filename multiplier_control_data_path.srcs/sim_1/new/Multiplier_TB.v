`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2026 23:29:04
// Design Name: 
// Module Name: Multiplier_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module Multiplier_TB;
    reg [15:0] data_in;
    reg clk, start;
    wire done;
    wire [15:0] product;

    data_path    DP  (LdA, LdB, LdP, clrP, decB, clk, data_in, eqz, product);
    control_path CON (clk, eqz, start, LdA, LdB, LdP, clrP, decB, done);

    initial
      begin
        clk = 1'b0;
        #3 start = 1'b1;
        #500 $finish;
      end

    always #5 clk = ~clk;

    initial
      begin
        #17 data_in = 17;
        #10 data_in = 5;
      end

    initial
      begin
        $monitor ($time, " %d %b", product, done);
        $dumpfile ("mul.vcd"); $dumpvars (0, Multiplier_TB);
      end

endmodule