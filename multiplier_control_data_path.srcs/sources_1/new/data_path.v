`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2026 17:24:29
// Design Name: 
// Module Name: data_path
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


module data_path(
    input ld_a, ld_b, ld_p, clr_p,dec_b, clk,
    input [15:0] data_in ,
    output eqz,
    output [15:0] product
    );
    wire [15:0] x,y,z,b_out;
    
    pipo_A A(x,data_in,ld_a,clk);
    pipo_P P(y,z,ld_p,clr_p,clk);
    cntr   B(b_out,data_in,ld_b,dec_b,clk);
    add AD(x,y,z);
    eqz_0 e(eqz,b_out);
    assign product = y;    
endmodule
