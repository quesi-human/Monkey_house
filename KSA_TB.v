module testbench;

    reg [31:0] a, b;
    wire [31:0] sum;
    wire carry_out;

    kogge_stone_adder #(.WIDTH(32)) uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry_out(carry_out)
    );

    initial begin
        // Test case 1
        a = 32'b00000000000000000000000000000011;
        b = 32'b00000000000000000000000000000101;
        #10;
        $display("A = %b, B = %b, Sum = %b, Carry Out = %b", a, b, sum, carry_out);

        // Test case 2
        a = 32'b11111111111111111111111111111111;
        b = 32'b00000000000000000000000000000001;
        #10;
        $display("A = %b, B = %b, Sum = %b, Carry Out = %b", a, b, sum, carry_out);

        // Add more test cases as needed
        $finish;
    end

endmodule
