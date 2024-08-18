//
//  Gate DMUX combinacional para saida de 16 bits
//
module dmux16(
  input [15:0] a,
  input [15:0] b,
  input sel,
  output reg [15:0] y
);

  always @(*) begin
    if (sel)
      y = b;
    else
      y = a;
  end

endmodule