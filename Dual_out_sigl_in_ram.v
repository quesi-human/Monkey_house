module Dual_out_sigl_in_ram #(
    parameter BW = 32,
    parameter AW = 5
)(
    input   wire                clk,         

    input   wire                write_en,    
    input   wire    [BW - 1:0]  data_in,  
    input   wire    [AW - 1:0]  addr_in,   

    input   wire                read_en1,
    input   wire    [AW - 1:0]  addr_out_1,
    output  reg     [BW - 1:0]  data_out1, 

    input   wire                read_en2,  
    input   wire    [AW - 1:0]  addr_out_2,
    output  reg     [BW - 1:0]  data_out2   
);

            reg [31:0] mem [0:31];

    always @(posedge clk) 
    begin
        if (write_en) 
        begin
            mem[addr_in] <= data_in;
        end
    end

    always @(posedge clk) 
    begin
        if (read_en1) 
        begin
            data_out1 <= mem[addr_out_1];
        end
    end

    always @(posedge clk) 
    begin
        if (read_en2) 
        begin
            data_out2 <= mem[addr_out_2];
        end
    end

endmodule