module PC #(parameter BW = 32)
(
    input                   clk, rst,

    input    [BW - 1:0]     PC_in,

    input                   stall,

    output   [BW - 1:0]     PC_out
);

    reg      [BW - 1:0]     PC_reg;

    always @ (posedge clk or negedge rst)
    begin
        if (!rst)
        begin
            PC_reg <= {BW{1'b0}};
        end

        else
        begin  
            if (stall)
            begin
                PC_reg <=   PC_reg;
                PC_out  <=   PC_reg;
            end

            else
            begin
                PC_reg <=   PC_in;
                PC_out  <=   PC_reg;
            end
        end
    end

endmodule