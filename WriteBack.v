module WriteBack #(
    parameter BW = 32
)(
    input   wire                clk, rst,
    input   wire                memtoreg,
    input   wire                readwrite,
    input   wire    [BW - 1:0]  in_data,
    input   wire    [BW - 1:0]  in_origenal,
    input   wire    [BW - 1:0]  rd_in,

    output  reg                 return_readwrite,
    output  reg     [BW - 1:0]  return_data,
    output  reg     [4:0]       rd_out
);

    always @ (posedge clk)
    begin
        return_readwrite <= readwirte;
        rd_out           <= rd_in;
    end

    always @ (posedge clk)
    begin
        if (memtoreg)
        begin
            return_data <= in_data;
        end

        else
        begin
            return_data <= in_origenal;
        end
    end

endmodule