`timescale 1ns/1ns
module debounce
  (
        input wire       clk,       // 50MHz clock input
        input wire       rst,       // reset input (positive)
        input wire       bouncy_in, // bouncy asynchronous input
        output reg       clean_out  // clean debounced output
   );

        /* Add wire and register definitions */
	reg [31:0] counter;
	reg synchronised_in;
        /* Add synchronous debouncing logic */
	synchroniser dut(.clk(clk), .d0(bouncy_in), .q1(synchronised_in));

	always_ff @(posedge clk or posedge rst)
	  begin
	    if (rst)
	      counter <= 32'b0;
            else
	      begin
		if (synchronised_in == clean_out)
		  counter <= 0;
	  	else
		if (counter == 10000)
		  begin
		    clean_out <= synchronised_in;
		    counter <= 0;
		  end
		else
		  counter <= counter + 1;
	      end
  	  end
endmodule
