`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2026 23:50:43
// Design Name: 
// Module Name: booths_counter
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


module booths_counter(
    input ld,clk,decrement,
    output reg [4:0]cnt
    );
    always@(posedge clk)
        begin
            if(ld)
                cnt <= 5'd16;
            else if(decrement)
                cnt <= cnt - 1'b1;
        end
endmodule
