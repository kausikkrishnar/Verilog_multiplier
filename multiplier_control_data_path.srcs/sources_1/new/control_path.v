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
    parameter s0 = 2'b000;
    parameter s1 = 2'b001;
    parameter s2 = 2'b010;
    parameter s3 = 2'b011;
    parameter s4 = 2'b100;
    
    always@(posedge clk)
        begin
            case (state)
            s0 : begin
                    if(start)
                        state <= s1;
                end
            s1 : begin
                    state <= s2;
                end
            s2 : begin
                    state <= s3;
                end
            s3 : begin
                    if(eq_z)
                        state <= s4;
                 end
             s4 : begin
                      state <= s4;
                  end
              default : state <= s0;    
                  
            endcase
        end
        
    always@(state)
       begin
            case (state)
                s0 : begin ld_A = 1'b0; ld_B = 1'b0; ld_P = 1'b0; dec_B = 1'b0; end
                s1 : begin ld_A = 1'b1;  end
                s2 : begin ld_A= 1'b0; ld_B = 1'b1; clr_P = 1'b1; end
                s3 : begin ld_B = 1'b0; clr_P = 1'b0;ld_P=1'b1;dec_B=1'b1; end
                s4 : begin ld_B = 1'b0;ld_P=1'b0;dec_B=1'b0; finished=1'b1; end
                default: begin ld_A = 1'b0; ld_B = 1'b0; ld_P = 1'b0; dec_B = 1'b0; end
            endcase
      
    end
    
endmodule
