`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2026 23:36:47
// Design Name: 
// Module Name: booths_ALU_addsub
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


module booths_ALU_addsub(
    input  add_sub,
    input [15:0] A_in, M_in,
    output reg [15:0] result
    );
    always@(A_in,M_in)
        begin
            assign result = add_sub ? (A_in + M_in) : (A_in - M_in);
        end
endmodule
