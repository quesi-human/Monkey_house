`include "KSA_AS.v"

`timescale 1ns/1ps

module TB_KSA_AS;

    reg [31:0] Ain, Bin;
    reg Cin, Sub;
    wire [31:0] Sum;
    wire Cout;

    KSA_AS U0 (
        .Ain(Ain),
        .Bin(Bin),
        .Cin(Cin),
        .Sub(Sub),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $dumpfile("TB_KSA_AS_out.vcd");
        $dumpvars(0, TB_KSA_AS);

        Ain = 32'd10; Bin = 32'd15; Cin = 1'b0; Sub = 1'b0;
        #10;
        Ain = 32'd20; Bin = 32'd5; Cin = 1'b0; Sub = 1'b1;
        #10;
        Ain = 32'd100; Bin = 32'd200; Cin = 1'b1; Sub = 1'b0;
        #10;
        Ain = 32'd50; Bin = 32'd75; Cin = 1'b0; Sub = 1'b1;
        #10;
        Ain = 32'hFFFFFFFF; Bin = 32'h00000001; Cin = 1'b0; Sub = 1'b0;
        #10;
        Ain = 32'h80000000; Bin = 32'h00000001; Cin = 1'b0; Sub = 1'b1;
        #10;
        $finish;
    end
endmodule