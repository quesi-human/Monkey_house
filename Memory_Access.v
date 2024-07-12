module Memory_Access #(
    parameter   BW = 32,
    parameter   OW = 10,
    parameter   INIT_FILE = "data.txt"
)(
    input   wire                clk, rst,

    input   wire    [BW - 1:0]  WriteData,

    input   wire    [OW - 1:0]  Address,

    input   wire    [2:0]       con,            //memwrite, memtoreg, regwirte

    input   wire    [4:0]       rd_in,

    output  reg     [BW - 1:0]  ReadData_out,

    output  reg     [BW - 1:0]  Origenal_out,

    output  reg                 MemtoReg,
    output  reg                 RegWrite,

    output  reg     [4:0]       rd_out
); 

    ram #(.DATA_WIDTH(BW), .ADDR_WIDTH(OW), .INIT_FILE(INIT_FILE)) R2
    (
        .clk(clk),

        .we(con[2]),                            //memwrite
        .data_in(WriteData),

        .addr(Address),

        .data_out(ReadData_out)
    );

    always @ (posedge clk)
    begin
        Origenal_out    <= WriteData;
        MemtoReg        <= con[1];
        RegWrite        <= con[0];
        rd_out          <= rd_in;
    end

endmodule