module register(input [15:0] in, input load, output reg [15:0] out);
    
    always @ (*) begin
        if (load) begin
            out <= in;
        end
    end

endmodule