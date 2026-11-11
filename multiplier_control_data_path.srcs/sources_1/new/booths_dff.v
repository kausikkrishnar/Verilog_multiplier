`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2026 23:20:32
// Design Name: 
// Module Name: booths_dff
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


module booths_dff(
    input d,clk,clr,en,
    output reg q
    );
    
    always@(posedge clk)
        if (clr)begin
            q <= 1'b0;
            end
        else if(en)
            q <= d;             
            
endmodule
