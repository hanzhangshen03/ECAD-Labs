`timescale 1ns / 1ps

module tb_dice(output logic [2:0] throw);

  logic clk, button, rst;

                  // instantiate design under test (dut)
  dice dut(.clk(clk), .rst(rst), .button(button), .throw(throw));

  initial
    begin
      clk = 0;
      button = 0;
      rst = 1;
      // after 20 simulation units (2 clock cycles given the clk configuration)
      #20 rst = 0; 
      #40 button = 1;
      // after 100 simulation units
      #120 button = 0;
    end

  always #5       // every five simulation units...
    clk <= !clk;  // ...invert the clock

                  // produce debug output on the negative edge of the clock
  always @(negedge clk)
    $display("time=%05d: throw = (%1d,%1d,%1d)",
      $time,      // simulator time
      throw[2], throw[1], throw[0]);   // outputs to display: red, amber, green

endmodule // tb_tlight

