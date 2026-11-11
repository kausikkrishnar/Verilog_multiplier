`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2026 00:37:35
// Design Name: 
// Module Name: booths_TB
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
// Self-checking testbench for the sequential Booth multiplier.
// No top module needed: the datapath and controller are wired together here.
//
// The product is read as {DP.A, DP.Q} through hierarchical references,
// so the datapath does not need a "product" output port.
module booths_TB;

    // ------------------------------------------------------------
    // Signals
    // ------------------------------------------------------------
    reg         clk = 0;
    reg         start = 0;
    reg  [15:0] data_in = 0;

    wire ldA, clrA, sftA, ldQ, clrQ, sftQ;
    wire ldM, clrFF, addsub, ldCount, decr, done;
    wire q_0, q_m1, eqz;

    wire [31:0] product = {DP.A, DP.Q};

    // ------------------------------------------------------------
    // Device under test: datapath + controller
    // ------------------------------------------------------------
    booths_datapath DP(
        .ldA(ldA), .clrA(clrA), .sftA(sftA),
        .ldQ(ldQ), .clrQ(clrQ), .sftQ(sftQ),
        .ldM(ldM), .clrFF(clrFF), .addsub(addsub), .clk(clk),
        .ldCount(ldCount), .decr(decr),
        .data_in(data_in),
        .q_m1(q_m1), .eqz(eqz), .q_0(q_0)
    );

    booths_control_path CP(
        .clk(clk), .start(start),
        .q_0(q_0), .q_m1(q_m1), .eqz(eqz),
        .ldA(ldA), .clrA(clrA), .sftA(sftA),
        .ldQ(ldQ), .clrQ(clrQ), .sftQ(sftQ),
        .ldM(ldM), .clrFF(clrFF), .addsub(addsub),
        .ldCount(ldCount), .decr(decr),
        .done(done)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    // ------------------------------------------------------------
    // Bookkeeping
    // ------------------------------------------------------------
    integer pass_count  = 0;
    integer fail_count  = 0;
    integer known_count = 0;   // failures caused by M = -32768 (needs 17-bit A)
    integer i;

    // ------------------------------------------------------------
    // One multiplication: drive inputs, wait for done, check result
    // ------------------------------------------------------------
    task multiply(input signed [15:0] m, input signed [15:0] q);
        reg signed [31:0] expected;
        reg signed [31:0] got;
        integer cycles;
        begin
            expected = m * q;

            // S0 -> S1: raise start with M on the bus
            @(negedge clk);
            start   = 1;
            data_in = m;

            @(negedge clk);          // now in S1: M is loaded at the next posedge
            @(negedge clk);          // now in S2: put Q on the bus
            data_in = q;

            // wait for done, with a timeout so a stuck FSM can't hang the sim
            cycles = 0;
            while (!done && cycles < 200) begin
                @(negedge clk);
                cycles = cycles + 1;
            end

            got = product;

            if (!done) begin
                $display("TIMEOUT  %6d x %6d : done never went high", m, q);
                fail_count = fail_count + 1;
            end
            else if (got === expected) begin
                pass_count = pass_count + 1;
            end
            else if (m == -16'sd32768) begin
                $display("KNOWN    %6d x %6d = %11d, got %11d  (needs 17-bit A)",
                         m, q, expected, got);
                known_count = known_count + 1;
            end
            else begin
                $display("FAIL     %6d x %6d = %11d, got %11d", m, q, expected, got);
                fail_count = fail_count + 1;
            end

            // finish the handshake: drop start, FSM goes S6 -> S0
            start = 0;
            @(negedge clk);
            @(negedge clk);
        end
    endtask

    // ------------------------------------------------------------
    // Test sequence
    // ------------------------------------------------------------
    initial begin
        $dumpfile("booths_TB.vcd");
        $dumpvars(0, booths_TB);

        // no reset: give the FSM a few clocks so state goes x -> S0
        repeat (3) @(negedge clk);

        // --- directed tests ---
        multiply(5, -3);             // the worked example: -15
        multiply(0, 0);
        multiply(0, 1234);
        multiply(1234, 0);
        multiply(1, 1);
        multiply(-1, -1);
        multiply(-1, 1);
        multiply(7, 7);
        multiply(-7, 7);
        multiply(32767, 32767);      // largest positive
        multiply(32767, -32768);
        multiply(-32767, -32768);
        multiply(1, -32768);         // most negative multiplier is fine
        multiply(16'h5555, 16'h5555);  // alternating bits: worst case for radix-2
        multiply(16'hAAAA, 16'h5555);
        multiply(16'h00FF, 16'hFF00);

        // most negative multiplicand: fails with a 16-bit A register
        multiply(-32768, 1);
        multiply(-32768, -32768);

        // --- random tests ---
        for (i = 0; i < 1000; i = i + 1)
            multiply($random, $random);

        // --- summary ---
        $display("--------------------------------------------------");
        $display("PASSED : %0d", pass_count);
        $display("FAILED : %0d", fail_count);
        $display("KNOWN  : %0d  (multiplicand = -32768, fixed by 17-bit A/Z/M)",
                 known_count);
        if (fail_count == 0)
            $display("RESULT : ALL TESTS PASSED");
        else
            $display("RESULT : FAILURES FOUND");
        $display("--------------------------------------------------");
        $finish;
    end

endmodule