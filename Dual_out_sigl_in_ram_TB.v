`include "Dual_out_sigl_in_ram.v"

`timescale 10ps/1ps

module TB_Dual_out_sigl_in_ram();

    parameter          BW = 32;
    parameter          AW = 5;

    reg                clk;     

    reg                write_en;   
    reg    [BW - 1:0]  data_in; 
    reg    [AW - 1:0]  addr_in;   

    reg                read_en1;
    reg    [AW - 1:0]  addr_out_1;
    wire   [BW - 1:0]  data_out1; 

    reg    [AW - 1:0]  addr_out_2;
    reg                read_en2;   
    wire   [BW - 1:0]  data_out2;

Dual_out_sigl_in_ram #(.BW(32), .AW(5)) R0
(
    clk,         

    write_en,    
    data_in,  
    addr_in,   

    read_en1,
    addr_out_1,
    data_out1, 

    read_en2, 
    addr_out_2,
    data_out2   
);

    initial begin
        clk = 1'b0;
    end
    
    always #5 clk = ~clk;
    
    initial begin
        write_en <= 1'b0;
        read_en1 <= 1'b0;
        read_en2 <= 1'b0;
        #50;
        write_en <= 1'b1;
        read_en1 <= 1'b0;
        read_en2 <= 1'b0;
        data_in  <= 32'hffffffff;
        addr_in  <= 5'b00001;
        #20;
        write_en <= 1'b0;
        read_en1 <= 1'b1;
        read_en2 <= 1'b0;
        data_in  <= 32'hffffffff;
        addr_in  <= 5'b00001;
        addr_out_1 <= 5'b00001;
        #20;
        write_en <= 1'b1;
        read_en1 <= 1'b0;
        read_en2 <= 1'b1;
        data_in  <= 32'hdddddddd;
        addr_in  <= 5'b00010;
        addr_out_1 <= 5'b00001;
        #20;
        write_en <= 1'b0;
        read_en1 <= 1'b0;
        read_en2 <= 1'b1;
        data_in  <= 32'hffffffff;
        addr_in  <= 5'b00001;
        addr_out_2 <= 5'b00010;
        #20;
        $finish;
    end
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, TB_Dual_out_sigl_in_ram);
    end
endmodule