module rom #(
    parameter BW = 32,
    parameter DW = 8,
    parameter INIT_FILE = ""
)(
    input   wire    [DW - 1:0]  addr,      
    output  reg     [BW - 1:0]  data_out  
);

    reg [BW - 1:0] memory [0:2**DW - 1];   

    initial begin
        if (INIT_FILE != "")
        begin
            $readmemh(INIT_FILE, memory); 
        end
    end

    always @(*) 
    begin
        data_out <= memory[addr];
    end

endmodule