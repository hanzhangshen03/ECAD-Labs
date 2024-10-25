module dice(input logic clk, 
            input logic button, 
	    input logic rst,
            output logic [2:0] throw);

always_ff @(posedge clk or posedge rst)
  if (rst)
    throw <= 3'd0;
  else begin
  if (throw == 3'd0 || throw == 3'd7 || (throw == 3'd6 && button))
    throw <= 3'd1;
  else   
    if (button)
      throw <= throw + 1;
  end

endmodule // dice

