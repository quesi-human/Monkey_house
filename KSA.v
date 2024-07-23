module kogge_stone_adder #(
    parameter WIDTH = 32
) (
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    output [WIDTH-1:0] sum,
    output carry_out
);

    // Generate and Propagate signals
    wire [WIDTH-1:0] g;
    wire [WIDTH-1:0] p;
    wire [WIDTH:0] c;

    assign g = a & b;
    assign p = a ^ b;
    assign c[0] = 0; // Carry-in is zero for the least significant bit

    // Stage 1
    wire [WIDTH-1:0] g1, p1;
    assign g1[0] = g[0];
    assign p1[0] = p[0];
    genvar i;
    generate
        for (i = 1; i < WIDTH; i = i + 1) begin
            assign g1[i] = g[i] | (p[i] & g[i-1]);
            assign p1[i] = p[i] & p[i-1];
        end
    endgenerate

    // Stage 2
    wire [WIDTH-1:0] g2, p2;
    assign g2[1:0] = g1[1:0];
    assign p2[1:0] = p1[1:0];
    generate
        for (i = 2; i < WIDTH; i = i + 1) begin
            assign g2[i] = g1[i] | (p1[i] & g1[i-2]);
            assign p2[i] = p1[i] & p1[i-2];
        end
    endgenerate

    // Stage 3
    wire [WIDTH-1:0] g3, p3;
    assign g3[3:0] = g2[3:0];
    assign p3[3:0] = p2[3:0];
    generate
        for (i = 4; i < WIDTH; i = i + 1) begin
            assign g3[i] = g2[i] | (p2[i] & g2[i-4]);
            assign p3[i] = p2[i] & p2[i-4];
        end
    endgenerate

    // Stage 4
    wire [WIDTH-1:0] g4, p4;
    assign g4[7:0] = g3[7:0];
    assign p4[7:0] = p3[7:0];
    generate
        for (i = 8; i < WIDTH; i = i + 1) begin
            assign g4[i] = g3[i] | (p3[i] & g3[i-8]);
            assign p4[i] = p3[i] & p3[i-8];
        end
    endgenerate

    // Stage 5
    wire [WIDTH-1:0] g5, p5;
    assign g5[15:0] = g4[15:0];
    assign p5[15:0] = p4[15:0];
    generate
        for (i = 16; i < WIDTH; i = i + 1) begin
            assign g5[i] = g4[i] | (p4[i] & g4[i-16]);
            assign p5[i] = p4[i] & p4[i-16];
        end
    endgenerate

    // Stage 6 (final stage for 32-bit adder)
    wire [WIDTH-1:0] g6, p6;
    assign g6[31:0] = g5[31:0];
    assign p6[31:0] = p5[31:0];

    // Final carry calculation
    generate
        for (i = 1; i < WIDTH; i = i + 1) begin
            assign c[i] = g6[i-1];
        end
    endgenerate
    assign c[WIDTH] = g6[WIDTH-1];

    // Sum calculation
    assign sum = p ^ c[WIDTH-1:0];
    assign carry_out = c[WIDTH];

endmodule
