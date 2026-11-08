`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2026 21:48:11
// Design Name: 
// Module Name: pipo_P
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


module pipo_P(
    output reg [15:0]  data_out,
    input [15:0] data_in,
    input ld,clr,clk
    );
    always@(posedge clk)
     begin
        if(clr)
            data_out <= 16'b0;
       else if(ld)
            data_out <= data_in;
     end
     
     
endmodule
