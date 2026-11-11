`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2026 00:01:49
// Design Name: 
// Module Name: booths_control_path
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


// Control path for the sequential Booth multiplier
// Based on the NPTEL lecture structure (S0..S6), with fixes:
//   - no #2 delays (not synthesizable) -> extra CHECK state S7 instead
//   - eqz declared as an input
//   - 1'b10 typo fixed to 2'b10
//   - outputs default to 0 in every state (no latches)
//   - port names match booths_datapath
module booths_control_path(
    input  clk, start,
    input  q_0, q_m1, eqz,
    output reg ldA, clrA, sftA,
    output reg ldQ, clrQ, sftQ,
    output reg ldM, clrFF, addsub,
    output reg ldCount, decr,
    output reg done
);
    reg [2:0] state;

    parameter S0 = 3'b000,   // idle, wait for start
              S1 = 3'b001,   // load M, clear A and Q-1, load counter
              S2 = 3'b010,   // load Q
              S3 = 3'b011,   // A <= A + M
              S4 = 3'b100,   // A <= A - M
              S5 = 3'b101,   // arithmetic shift right, count <= count - 1
              S6 = 3'b110,   // done
              S7 = 3'b111;   // check {q_0, q_m1} and eqz

    // State transitions
    // (state starts as x in simulation; x falls into default -> S0 on the first clock)
    always @(posedge clk)
    begin
        case (state)
            S0: if (start) state <= S1;
            S1: state <= S2;
            S2: state <= S7;
            S3: state <= S5;
            S4: state <= S5;
            S5: state <= S7;
            S7: if (eqz)  state <= S6;
                else if ({q_0, q_m1} == 2'b01) state <= S3;
                else if ({q_0, q_m1} == 2'b10) state <= S4;
                else                        state <= S5;
            S6: if (!start) state <= S0;
            default: state <= S0;
        endcase
    end

    // Control signals for each state
    always @(*)
    begin
        // defaults: everything off
        ldA = 0; clrA = 0; sftA = 0;
        ldQ = 0; clrQ = 0; sftQ = 0;
        ldM = 0; clrFF = 0; addsub = 0;
        ldCount = 0; decr = 0; done = 0;

        case (state)
            S1: begin ldM = 1; clrA = 1; clrFF = 1; ldCount = 1; end
            S2: begin ldQ = 1; end
            S3: begin ldA = 1; addsub = 1; end   // add
            S4: begin ldA = 1; addsub = 0; end   // subtract
            S5: begin sftA = 1; sftQ = 1; decr = 1; end
            S6: begin done = 1; end
            default: ;
        endcase
    end
endmodule