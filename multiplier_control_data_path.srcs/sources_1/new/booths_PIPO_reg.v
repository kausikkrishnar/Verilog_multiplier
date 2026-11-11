`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2026 23:28:29
// Design Name: 
// Module Name: booths_PIPO_reg
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


module booths_PIPO_reg(
    input ld,clk,
    input [15:0] Multiplicant,
    output reg [15:0] M_out
    );
    always@(posedge clk)
        begin
            if (ld)begin
                M_out <= Multiplicant;
                end
          
        end
endmodule
