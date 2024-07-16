`timescale 1ns/1ps

module Instruction_Fetch_TB;

    parameter BW = 32,
    parameter DW = 8,
    parameter INIT_FILE = "instuction_file.txt"

    reg               clk, rst,
    reg               btaken,
    reg   [BW - 1:0]  EXE_in,
    reg               stall,

    wire  [BW - 1:0]  PC_out,  
    wire  [BW - 1:0]  Instruction_data

    Instruction_Fetch #(
    .BW(32),
    .DW(8),
    .INIT_FILE(INIT_FILE)
)( 
    clk, rst,

    btaken,
    EXE_in,
    stall,

    PC_out,  
    Instruction_data
);

initial begin
    rst = 1'b1;
    clk = 1'b0;
end

always #5 clk = ~clk;

initial begin
    #10;
    rst = 1'b0;
    #10;
    rst = 1'b1;
end

initial begin
    btaken = 1'b0;
    EXE_in = 1'b0;
    stall = 1'b0;
    #30;
    btaken = 1'b1;
    EXE_in = 1'b0;
    stall = 1'b0;
    #30;
    btaken = 1'b0;
    EXE_in = 1'b1;
    stall = 1'b0;
    #30;
    btaken = 1'b0;
    EXE_in = 1'b0;
    stall = 1'b1;
    #30;
    $stop;
end

endmodule