// rotary decoder template

module rotary
  (
	input  wire clk,
	input  wire rst,
	input  wire [1:0] rotary_in,
	output logic [7:0] rotary_pos,
        output logic rot_cw,
        output logic rot_ccw
   );
   
   reg [1:0] rotary_out, previous, next;
   reg [2:0] counter;
   reg cw, ccw;
   debounce debounce1(.clk(clk), .rst(rst), .bouncy_in(rotary_in[0]), .clean_out(rotary_out[0]));
   debounce debounce2(.clk(clk), .rst(rst), .bouncy_in(rotary_in[1]), .clean_out(rotary_out[1]));

   always_ff @(posedge clk or posedge rst)
     begin
       if (rst) begin
         rotary_pos <= 0;
 	 previous <= 2'b11;
	 counter <= 0;
	 cw <= 0;
	 ccw <= 0;
       end
       else if (previous != rotary_out) begin
	 previous <= rotary_out;
	 if (counter == 0)
           begin
             cw <= 0;
             ccw <= 0;
	     if (rotary_out == 2'b00)
	       counter <= 1;
           end
	 else
	   case (counter)
	     1: if (rotary_out == 2'b01)
		  begin
		    cw <= 1;
		    counter <= 2;
		  end
		else if (rotary_out == 2'b10)
	          begin
		    ccw <= 1;
		    counter <= 2;
		  end
		else
	          counter <= 0;
	     2: if (rotary_out == 2'b11)
		  counter <= 3;
	        else
		  counter <= 0;
	     3: if (rotary_out == 2'b10 && cw || rotary_out == 2'b01 && ccw)
		  counter <= 4;
	  	else
		  counter <= 0;
	     4: if (rotary_out == 2'b00)
		  begin
		    counter <= 1;
		    rot_cw <= cw;
		    rot_ccw <= ccw;
		    if (cw) begin
		      if (rotary_pos == 255)
			rotary_pos <= 0;
		      else
			rotary_pos <= rotary_pos + 1;
		    end
	     	    else if (ccw) begin
		      if (rotary_pos == 0)
			rotary_pos <= 255;
		      else
		      	rotary_pos <= rotary_pos - 1;
		    end
		    cw <= 0;
		    ccw <= 0;
		  end
		else
		  counter <= 0;
	   endcase
       end
       else begin
	 rot_cw <= 0;
	 rot_ccw <= 0;
       end
    end
endmodule // rotarydecoder
