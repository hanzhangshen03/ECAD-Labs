`timescale 10ns / 1ns;

module tb_audio_fifos(
    output logic left_out,
    output logic right_out
);

logic clk;
logic reset;

logic [3:0] note = 0;
logic [2:0] octave = 0;
logic [7:0] volume = 255;

logic rdy_l;
logic rdy_r;
logic [15:0] sample;
logic sample_valid;

tonegen tg (.clk, .reset, .volume, .note, .octave, .left_chan_ready(rdy_l), .right_chan_ready(rdy_r), .sample_data(sample), .sample_valid(sample_valid));

audio_fifos dut (.clk, .reset, .sample_left(sample), .sample_right(sample), .sample_left_valid(sample_valid), .sample_right_valid(sample_valid), .left_ready(rdy_l), .right_ready(rdy_r), .left_out, .right_out);

initial begin
    reset = 1;
    clk = 0;
    #10 reset = 0;
end

always begin
    #1 clk = !clk;
end

endmodule
