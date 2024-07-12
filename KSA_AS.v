module KSA_AS #(parameter BW = 32)
(
    input  [BW - 1:0]   Ain, Bin,    
    input               Cin,            
    input               Sub,            
    
    output [BW - 1:0]   Sum,    
    output              Cout           
);

    wire [BW - 1:0] Bin_b;    
    wire [BW - 1:0] G, P;     
    wire [BW  -1:0] C;        

    assign Bin_b = Bin ^ {BW{Sub}};  

    assign G = Ain & Bin_b;   
    assign P = Ain ^ Bin_b;   

    assign C[0] = Sub;
    genvar i;
    generate
        for (i = 1; i < BW; i = i + 1) begin : gen_level0
            assign C[i] = G[i-1] | (P[i-1] & C[i-1]);
        end
    endgenerate

    assign Sum = P ^ C;

    assign Cout = G[BW - 1] | (P[BW - 1] & C[BW - 1]);
endmodule
