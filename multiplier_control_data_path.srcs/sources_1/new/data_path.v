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
    output eqz
    );
    wire [15:0] x,y,z, bus,bus_out;
    
    pipo_A A(x,bus,ld_a,clk);
    pipo_P P(y,z,ld_p,clr_p,clk);
    cntr   B(b_out,bus,ld_b,dec_b,clk);
    add AD(z,x,y);
    eqz_0 e(eqz,bus_out);    
endmodule
