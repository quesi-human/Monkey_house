`include "instuction_file.txt"
`include "control_order.txt"
`include "data.txt"

module RISC_V_CPU
(
    input clk, rst,
);

    parameter BW = 32;          //data and instruction bit width(=32bit)
    parameter DW = 8;           //data depth(=256*32bit)
    parameter ADDR_WIDTH = 5;   //ram depth (=32*32bit)
    parameter OW = 10;          //data_memory depth(1024*32bit)

    Instruction_Fetch #(.BW(BW), .DW(DW), .INIT_FILE("instuction_file.txt")) SEQ0
    ( 
        .clk(clk), .rst(rst), 

        .btaken(),                              //input   wire 

        .EXE_in(),                              //input   wire    [BW - 1:0]

        .stall(stall_wire),                     //input   wire

        .PC_out(PC_out_wire),                   // output  reg     [BW - 1:0]

        .Instruction_data(Instruction_data_wire)//output  reg     [BW - 1:0]
    );

            wire    [BW - 1:0]  Instruction_data_wire;
            wire    [BW - 1:0]  PC_out_wire;



    Instruction_Decoding #(.BW(BW), .ADDR_WIDTH(ADDR_WIDTH), .DW(DW), .INIT_FILE("control_order.txt")) SEQ1
    (
        .clk(clk), .rst(rst), 

        .Instruction(Instruction_data_wire),    //input   wire    [BW - 1:0]
        .rd_data(rd_data_wire),                  //input   wire    [BW - 1:0]

        .RegWrite(readwrite_wire),                            //input   wire 

        .rd_in(rd_out_wire),                    //input   wire    [4:0]  

        .rs1_id(rs1_id_wire), rs2_id(rs2_id_wire),//output  reg     [4:0]

        .stall(stall_wire),                     //output  reg     [BW - 1:0]

        .rs1_data(rs1_data_wire), .rs2_data(rs2_data_wire),//output  reg     [BW - 1:0]

        .rd(rdtoexe),                                  //output  reg     [4:0]

        .sign_extension_out(extenstiontoexe),                  //output  reg     [BW - 1:0]

        .rs1(rs1_exe), .rs2(rs2_exe)                          //output  reg     [4:0]
    );   

            wire    [4:0]       rs1_id_wire, rs2_id_wire;
            wire    [BW - 1:0]  rs1_data_wire, rs2_data_wire;
            wire    [4:0]       rdtoexe;
            wire    [BW - 1:0]  extenstiontoexe;

    
    
    Execution #(.BW(BW))    SEQ2
    (
        .clk(clk), .rst(rst),   //input   wire    [BW - 1:0]

        .rs1_data(rs1_data_wire), .rs2_data(rs2_data_wire),   //input   wire    [BW - 1:0]

        .adder(),                       //input   wire    [BW - 1:0]

        .rd_in(rdtoexe),                       //input   wire    [BW - 1:0]

        .PC_in(),                       //input   wire    [BW - 1:0]

        .sign_extension_in(extenstiontoexe),           //input   wire    [BW - 1:0]

        .afwd(afwd_wire),               //input   wire 
        .bfwd(bfwd_wire),               //input   wire 

        .beq(),                         //input   wire 
        .ALUscr(),                      //input   wire 
        .ALUcontrol(),                  //input   wire    [6:0]

        .ALUout(),                      //output  reg     [BW - 1:0]

        .PCout(),                       //output  reg     [BW - 1:0]

        .btaken_exe(),                  //output reg

        .rd_out(rd_out_MA)
    );

            wire    [4:0]  rd_out_MA;

    Memory_Access #(.BW(BW), .OW(OW), .INIT_FILE("data.txt"))   SEQ3
    (
        .clk(clk), .rst(rst), 

        .WriteData(), //input   wire    [BW - 1:0]

        .Address(), //input   wire    [BW - 1:0]

        .con(),            //readwrite, memtoreg, regwirte 

        .rd_in(rd_out_MA),           //output reg    [BW - 1:0]

        .ReadData_out(), //output  reg     [BW - 1:0]

        .Origenal_out(), //output  reg     [BW - 1:0]

        .MemtoReg(memtoreg), //output  reg

        .RegWrite(readwrite_wire), //output  reg

        .rd_out(rd_out_WB)   //output reg    [BW - 1:0]
    ); 
    
            wire        memtoreg;
            wire        readwrite_wire;
            wire    [4:0]   rd_out_WB;

    WriteBack #(.BW(BW))    SEQ4
    (
        .clk(clk), .rst(rst), 
        .memtoreg(memtoreg),
        .readwrite(readwrite_wire),
        .in_data(), //input   wire    [BW - 1:0]
        .in_origenal(), //input   wire    [BW - 1:0]
        .rd_in(rd_out_WB), //input   wire    [BW - 1:0]

        .return_readwrite(readwrite_wire), //output  reg  
        .return_data(), //output  reg     [BW - 1:0]
        .rd_out(rd_out_wire) //output  reg     [4:0]
    );
            wire    [4:0]       rd_out_wire;
            wire                readwrite_wire;
            wire    [BW -1:0]   rd_data_wire;
            
    Interlock_Unit  SUB0
    (
        .rs1_id(rs1_id_wire), //input   wire    [4:0]

        .rs2_id(rs2_id_wire), //input   wire    [4:0]

        .MemRead_exe(), //input   wire

        .rd_exe(),    //input   wire    [4:0]

        .stall(stall_wire) //output  reg
    );

            wire    stall_wire;

    data_forwarding SUB1
    (
        .rs1_exe(rs1_id_wire), //input   wire    [4:0] 
        .rs2_exe(rs2_id_wire), //input   wire    [4:0]

        .rd_mem(), //input   wire    [4:0]
        .rd_wb(), //input   wire    [4:0]

        .afwd(afwd_wire), //output  wire 
        .bfwd(bfwd_wire) //output  wire
    );

            wire    afwd_wire, bfwd_wire;

endmodule