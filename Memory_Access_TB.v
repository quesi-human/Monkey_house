module Memory_Access_TB;
    parameter   BW = 32,
    parameter   OW = 10,
    parameter   INIT_FILE = "data.txt"

    reg                clk, rst,

    reg    [BW - 1:0]  WriteData,
    reg    [OW - 1:0]  Address,

    reg    [2:0]       con,            //readwrite, memtoreg, regwirte

    reg    [4:0]  rd_in,
    
    wire   [BW - 1:0]  ReadData_out,

    wire   [BW - 1:0]  Origenal_out,

    wire               MemtoReg,

    wire               RegWrite,

    wire   [4:0]  rd_out


    Memory_Access #(.BW(BW), .OW(OW), .INIT_FILE(INIT_FILE)) T0
    (
        .clk(clk), .rst(rst),

        .WriteData(WriteData),
        .Address(Address),

        .con(con),            //readwrite, memtoreg, regwirte

        .rd_in(rd_in),
        //////////
        .ReadData_out(ReadData_out),

        .Origenal_out(Origenal_out),

        .MemtoReg(MemtoReg),        //1clk push signal
        .RegWrite(RegWrite),        //same

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
        WriteData   <= 32'h88888888;
        Address     <= 10'b0000000000;
        con         <= 3'b011;
        rd_in       <= 5'b11011;
        #30;
        WriteData   <= 32'h77777777;
        Address     <= 10'b0000000001;
        con         <= 3'b100;
        rd_in       <= 5'b10101;
        #30;
        WriteData   <= 32'h66666666;
        Address     <= 10'b0000000010;
        con         <= 3'b001;
        rd_in       <= 5'b11011;
        #30;
        WriteData   <= 32'h55555555;
        Address     <= 10'b0000000001;
        con         <= 3'b111;
        rd_in       <= 5'b11011;
        #30;
        WriteData   <= 32'h44444444;
        Address     <= 10'b0000000010;
        con         <= 3'b111;
        rd_in       <= 5'b11011;
        #30;
        WriteData   <= 32'h33333333;
        Address     <= 10'b0000000000;
        con         <= 3'b111;
        rd_in       <= 5'b11011;
        #50; $stop;
    end

endmodule