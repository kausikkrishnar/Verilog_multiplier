`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2026 22:29:04
// Design Name: 
// Module Name: booths_datapath
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


module booths_datapath(
    input ldA,clrA,sftA,
    input ldQ,clrQ,sftQ,
    input ldM,clrFF,addsub,clk,ldCount,decr,
    input [15:0] data_in,
    output q_m1,eqz,q_0
    );
    wire [15:0] A,M,Z,Q;
    wire [4:0] count;
    
    assign q_0 = Q[0];
    assign eqz =  ~|count;//(reduction operation)
    booths_counter ctr(.ld(ldCount),.clk(clk),.decrement(decr),.cnt(count));
    
    booths_shiftreg A_reg(.s_in(A[15]),.clk(clk),.sft(sftA),.ld(ldA),.clr(clrA),.data(Z),.data_out(A));
    booths_shiftreg Q_reg(.s_in(A[0]),.clk(clk),.sft(sftQ),.ld(ldQ),.clr(clrQ),.data(data_in),.data_out(Q));
    booths_dff QM1(.d(Q[0]),.clk(clk),.clr(clrFF),.q(q_m1));
    booths_PIPO_reg M_reg(.ld(ldM),.clk(clk), .Multiplicant(data_in),.M_out(M));
    booths_ALU_addsub ALU(.add_sub(addsub),.A_in(A), .M_in(M),.result(Z));
    
   
endmodule
