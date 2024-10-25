module fifo(
    input clk,
    input reset,
    input [15:0] in,
    input valid,
    output logic [15:0] out,
    input read,
    output logic empty,
    output logic full
);

    parameter SIZE = 128;
    
    localparam SIZELG2 = $clog2(SIZE);

    logic [15:0] mem [SIZE];
    logic [SIZELG2-1:0] readptr = 0;
    logic [SIZELG2-1:0] writeptr = 0;

    logic [SIZELG2-1:0] tmp;
    
    always_ff @(posedge clk) begin
        if(reset) begin
            readptr <= 0;
            writeptr <= 0;
        end else begin
        
            tmp = writeptr + 1;
            full = ( tmp[SIZELG2-1:0] == readptr[SIZELG2-1:0]);
            empty <= (readptr == writeptr);
        
            out <= mem[readptr];
            
            if (read && !empty) begin
                readptr <= readptr + 1;
            end
            
            if (valid && !full) begin
                mem[writeptr] <= in;
                writeptr <= writeptr + 1;
            end
        end
    end
    
endmodule



module audio_fifos(
    input clk,
    input reset,
    input logic [15:0] sample_left,
    input logic [15:0] sample_right,
    input sample_left_valid,
    input sample_right_valid,
    output logic left_ready,
    output logic right_ready,
    output logic left_out,
    output logic right_out
);

localparam DIV = ((50000000/48000)/2) - 1;
int count = 0;
logic alt = 0;

reg read_left = 0;
reg read_right = 0;
logic left_empty;
logic right_empty;

logic [15:0] out_left;
logic [15:0] out_right;

logic left_full;
logic right_full;

always_comb begin
    left_ready = !left_full;
    right_ready = !right_full;
end

fifo #(.SIZE(16)) left (.clk, .reset, .in(sample_left), .valid(sample_left_valid), .out(out_left), .read(read_left), .empty(left_empty), .full(left_full));
fifo #(.SIZE(16)) right (.clk, .reset, .in(sample_right), .valid(sample_right_valid), .out(out_right), .read(read_right), .empty(right_empty), .full(right_full));


always_ff @(posedge clk) begin
    if (reset) begin
        count <= 0;
        read_left <= 0;
        read_right <= 0;
        left_out <= 0;
        right_out <= 0;
    end else begin
        if (count == DIV) begin
            count <= 0;
            alt <= !alt;
            if (alt) begin
                if (!left_empty) begin
                    read_left <= 1;
                end
            end else begin
                if (!right_empty) begin
                    read_right <= 1;
                end
            end
        end else begin
            count <= count + 1;
            if (read_left) begin
                left_out <= out_left[15];
            end
            if (read_right) begin
                right_out <= out_right[15];
            end
            read_left <= 0;
            read_right <= 0;
        end
    end
end

endmodule
