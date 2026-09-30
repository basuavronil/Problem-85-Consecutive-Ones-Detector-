`timescale 1ns / 1ps

module tb_cod32;

    // Inputs
    reg [31:0] data_in;

    // Outputs
    wire consecutive_ones_detected;

    // Instantiate the Unit Under Test (UUT)
    cod32 uut (
        .data_in(data_in),
        .consecutive_ones_detected(consecutive_ones_detected)
    );

    initial begin
        // Setup VCD Waveform Dump
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_cod32);

        // Setup Terminal Monitor
        $monitor("Time = %0t | data_in = 32'b%b (0x%h) | detected = %b", 
                 $time, data_in, data_in, consecutive_ones_detected);

        // Test Case 1: All Zeros
        data_in = 32'h0000_0000;
        #10;

        // Test Case 2: Alternating 1s and 0s (No consecutive ones)
        data_in = 32'h5555_5555; // 0101_0101...
        #10;

        // Test Case 3: Consecutive ones at LSB (bits [1:0])
        data_in = 32'h0000_0003; // ...0011
        #10;

        // Test Case 4: Consecutive ones at MSB (bits [31:30])
        data_in = 32'hC000_0000; // 1100...
        #10;

        // Test Case 5: Consecutive ones in the middle (bits [16:15])
        data_in = 32'h0001_8000; // ...0001_1000...
        #10;

        // Test Case 6: Isolated ones separated by single zero (bits [3, 1])
        data_in = 32'h0000_000A; // ...1010
        #10;

        // Test Case 7: All Ones
        data_in = 32'hFFFF_FFFF;
        #10;

        $finish;
    end

endmodule
