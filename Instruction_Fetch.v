module Instruction_Fetch #(
    parameter BW = 32,
    parameter DW = 8,
    parameter INIT_FILE = "instuction_file.txt"
)( 
    input   wire                clk, rst,

    input   wire                btaken,

    input   wire    [BW - 1:0]  EXE_in,

    input   wire                stall,

    output  reg     [BW - 1:0]  PC_out,  

    output  reg     [BW - 1:0]  Instruction_data
);

            wire    [BW - 1:0]      PC_sig;
            wire    [BW - 1:0]      read_data;

    PC #(.BW(BW)) PC0
    (
        .clk(clk), .rst(rst),
        .PC_in(PC_mux),
        .stall(stall),
        .PC_out(PC_sig)
    );

            wire    [BW - 1:0]      PC_4;
            wire    [BW - 1:0]      PC_mux;
            wire    [BW - 1:0]      rom_out;

    
    assign    PC_4    =   PC_sig + 1'b1;
    assign    PC_mux  =   btaken ? PC_4 : EXE_in; 
    assign    PC_out  =   PC_sig;
    

    rom #(.BW(BW), .DW(DW), .INIT_FILE(INIT_FILE)) R0
    (
        .addr(PC_sig),  
        .data_out(rom_out)  
    );

        wire    [BW - 1:0]      btaken_mux;


    assign btaken_mux =  ~btaken ? rom_out : 32'b000000000000_000_000_00000_0010011; // NOP

    always @ (posedge clk, negedge rst)
    begin
        if (!rst)
        begin
            Instruction_data <= 32'b0;
        end

        else
        begin
            if (stall)
            begin
                Instruction_data <= Instruction_data;

            end

            else
            begin
                Instruction_data <= btaken_mux;
            end
        end
    end
endmodule

/*/
ram #(.DATA_WIDTH(BW), .ADDR_WIDTH(DW), .INIT_FILE(INIT_FILE)) R0
    (
        .clk(clk),
        .addr(PC_sig),
        .data_in(BW{1'b0}),
        .we(1'b0),
        .data_out(read_data)
    );
/*/