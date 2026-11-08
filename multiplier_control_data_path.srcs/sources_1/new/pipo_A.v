`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2026 17:37:29
// Design Name: 
// Module Name: pipo_A
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


module pipo_A(
    output reg [15:0]  data_out,
    input [15:0] data_in,
    input ld,clk
    );
    always@(posedge clk)
     begin
        if(ld)
            data_out <= data_in;
     end
     
     
endmodule
