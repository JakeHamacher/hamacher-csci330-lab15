module sign_extender(
    input [15:0] in_16bit,
    output reg signed [31:0] out_32bit
);

always @(*) begin
    if (in_16bit[15] == 1) begin
        out_32bit = {{16{in_16bit[15]}}, in_16bit};
    end
    else begin
        out_32bit = {16'b0, in_16bit};
    end
end

endmodule

module sign_extender_tb;

reg [15:0] in_16bit;
wire [31:0] out_32bit;

sign_extender DUT(
    .in_16bit(in_16bit),
    .out_32bit(out_32bit)
);

initial begin
    $display("Testing sign extender...");

    // Test positive number
    in_16bit = 16'b0000_0000_0000_1111;
    #10 $display("Input: %b, Output: %b", in_16bit, out_32bit);

    // Test negative number
    in_16bit = 16'b1111_1111_1111_0000;
    #10 $display("Input: %b, Output: %b", in_16bit, out_32bit);

    // Test zero
    in_16bit = 16'b0000_0000_0000_0000;
    #10 $display("Input: %b, Output: %b", in_16bit, out_32bit);

    // Test maximum positive value
    in_16bit = 16'b0111_1111_1111_1111;
    #10 $display("Input: %b, Output: %b", in_16bit, out_32bit);

    // Test maximum negative value
    in_16bit = 16'b1000_0000_0000_0000;
    #10 $display("Input: %b, Output: %b", in_16bit, out_32bit);

    $finish;
end

endmodule
