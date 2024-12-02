module synchroniser (input logic clk, input logic d0, output logic q1);
  reg q0;
  always_ff @(posedge clk) begin
    q0 <= d0;
    q1 <= q0;
  end
endmodule

