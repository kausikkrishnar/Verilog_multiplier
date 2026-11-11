`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2026 22:52:35
// Design Name: 
// Module Name: booths_shiftreg
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


module booths_shiftreg(
    input s_in,clk,sft,ld,clr,
    input [15:0] data,
    output reg [15:0] data_out
    );
    always@(posedge clk)
        begin
            if(clr)begin
                data_out <= 16'b0;
                end
            else if (ld)begin
                data_out <= data; 
                end
            else if (sft)begin
                data_out <= {s_in,data_out[15:1]}; 
                end
            //else begin
              //  data_out <= data_out;
               // end
        end
        
endmodule
