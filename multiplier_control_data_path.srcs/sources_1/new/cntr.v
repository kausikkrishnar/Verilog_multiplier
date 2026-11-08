`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2026 21:50:53
// Design Name: 
// Module Name: cntr
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


module cntr(
    output reg [15:0] data_out,
    input [15:0] data_in,
    input ld,dec,clk
    );
    always@(posedge clk)
     begin
        if(ld)
            data_out <= data_in;
        else if(dec)
            data_out <= data_out - 1'b1;
     
     end
endmodule
