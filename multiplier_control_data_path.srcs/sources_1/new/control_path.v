`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2026 22:52:15
// Design Name: 
// Module Name: control_path
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


module control_path(
    input clk,eq_z,start,
    output reg ld_A,ld_B,ld_P,clr_P,dec_B,finished

    );
    
    // we have 4 states
    reg [2:0] state;
    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;
    parameter s4 = 3'b100;
    
    always@(posedge clk)
        begin
            case (state)
            s0 : if(start) state <= s1;
            s1 : state <= s2;
            s2 : state <= s3;
            s3 : if(eq_z) state <= s4;
            s4 : state <= s4;
            default : state <= s0;    
           endcase
        end
        
     always @(*)
        begin
            ld_A = 1'b0; ld_B = 1'b0; ld_P = 1'b0;
            clr_P = 1'b0; dec_B = 1'b0; finished = 1'b0;
            case (state)
                s1 : ld_A = 1'b1;
                s2 : begin ld_B = 1'b1; clr_P = 1'b1; end
                s3 : if (!eq_z) begin ld_P = 1'b1; dec_B = 1'b1; end
                s4 : finished = 1'b1;
            endcase
        end
    
endmodule
