module Ram #(parameter BW = 32, parameter AW = 1024, parameter INIT_FILE = "ram.data")
(
    input               clk,

    input               we,
    input   [BW - 1:0]  data_in,

    input   [AW - 1:0]  addr,

    output  [BW - 1:0]  data_out
);

    // RAM storage
            reg     [DATA_WIDTH-1:0]    ram [2**ADDR_WIDTH-1:0];

    // Load initial contents from file if specified
    initial begin
        if (INIT_FILE != "") 
        begin
            $readmemh(INIT_FILE, ram);
        end
    end

    // RAM read/write logic
    always @(posedge clk) begin
        if (we) 
        begin
            ram[addr] <= data_in;
        end

        else
        begin
            data_out <= ram[addr];
        end
    end
endmodule