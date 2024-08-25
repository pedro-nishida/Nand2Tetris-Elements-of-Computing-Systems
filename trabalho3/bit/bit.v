module bit(input in, input load, output reg out);
    
    always @ (*) begin
        if (load) begin
            out <= in;
        end
    end

endmodule