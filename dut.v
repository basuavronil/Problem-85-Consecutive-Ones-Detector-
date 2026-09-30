module cod32 (
    input  wire [31:0] data_in,
    output wire        consecutive_ones_detected
);

    // Bitwise AND between data_in and data_in right-shifted by 1 bit
    // consecutive_ones_detected asserts high if any adjacent bit pair is 2'b11
    assign consecutive_ones_detected = |(data_in & (data_in >> 1));

endmodule
