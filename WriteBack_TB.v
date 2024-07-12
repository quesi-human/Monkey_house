`timescale  1ns/1ps

module WriteBack_TB;   
    reg                clk, rst;
    reg                memtoreg;
    reg                readwrite;
    reg    [BW - 1:0]  in_data;
    reg    [BW - 1:0]  in_origenal;
    reg    [BW - 1:0]  rd_in;

    wire               return_readwrite;
    wire   [BW - 1:0]  return_data;
    wire   [4:0]       rd_out;

    WriteBack #(.BW(BW))    T0
    (
        .clk(clk), .rst(rst),
        .memtoreg(memtoreg),
        .readwrite(readwrite),
        .in_data(in_data),
        .in_origenal(in_origenal),
        .rd_in(rd_in),

        .return_readwrite(return_readwrite),
        .return_data(return_data),
        .rd_out(rd_out)
    );

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        #10;
        rst = 1'b0;
        #10;
        rst = 1'b1;
    end
    
    always #5 clk = ~clk;
    
    initial begin
        memtoreg    <=  1'b0;
        readwrite   <=  1'b0; 
        in_data     <=  32'h0;
        in_origenal <=  32'h0;
        rd_in       <=  32'h0;
        #10;
        memtoreg    <=  1'b1;
        readwrite   <=  1'b1; 
        in_data     <=  32'hffffdddd;
        in_origenal <=  32'hddddffff;
        rd_in       <=  32'h11111111;
        #10;
        memtoreg    <=  1'b0;
        readwrite   <=  1'b0; 
        in_data     <=  32'hffffdddd;
        in_origenal <=  32'hddddffff;
        rd_in       <=  32'h22222222;
        #10;$stop;
    end

endmodule