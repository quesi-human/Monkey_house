`include "ram.v"

`timescale 1ns/1ps

module tb_ram;

    // Parameters
    localparam DATA_WIDTH = 32;
    localparam ADDR_WIDTH = 8;
    localparam INIT_FILE = "instruction_file.txt";

    // Testbench signals
    reg clk;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] data_in;
    reg we;
    wire [DATA_WIDTH-1:0] data_out;

    // Instantiate the RAM
    ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .INIT_FILE(INIT_FILE)
    ) uut (
        .clk(clk),
        .addr(addr),
        .data_in(data_in),
        .we(we),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        addr = 0;
        data_in = 0;
        we = 0;

        // Wait for the initial block to finish
        #100;

        // Read the first instruction from the RAM
        addr = 0;
        #100;

        // Read the second instruction from the RAM
        addr = 1;
        #100;

        // Read the third instruction from the RAM
        addr = 2;
        #100;

        // Read the fourth instruction from the RAM
        addr = 3;
        #100;

        we <= 1'b1;
        addr <= 3;
        data_in <= 32'h12345678;

        #100;
        we <= 1'b0;
        addr <= 3;
        // Finish the simulation
        $stop;
    end

    initial begin
        $dumpfile("tb_ram.vcd");
        $dumpvars(0, tb_ram);
    end

endmodule