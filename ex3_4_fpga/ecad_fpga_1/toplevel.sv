//
// Copyright (c) 2015 A. Theodore Markettos
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
// OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
// OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
// SUCH DAMAGE.

// Top level file for DE1-SoC board with
// Cambridge display board

// Uncomment this if you have an HPS (ARM CPU) in your design
//`define ENABLE_HPS

module toplevel(

      // Analogue-digital converter
      inout              ADC_CS_N,
      output             ADC_DIN,
      input              ADC_DOUT,
      output             ADC_SCLK,

      // Audio DAC
      input              AUD_ADCDAT,
      inout              AUD_ADCLRCK,
      inout              AUD_BCLK,
      output             AUD_DACDAT,
      inout              AUD_DACLRCK,
      output             AUD_XCK,

      // Clocks
      input              CLOCK_50,
      input              CLOCK2_50,
      input              CLOCK3_50,
      input              CLOCK4_50,

      // FPGA-side SDRAM
      output      [12:0] DRAM_ADDR,
      output      [1:0]  DRAM_BA,
      output             DRAM_CAS_N,
      output             DRAM_CKE,
      output             DRAM_CLK,
      output             DRAM_CS_N,
      inout       [15:0] DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_RAS_N,
      output             DRAM_UDQM,
      output             DRAM_WE_N,

      // Fan control (unused on native board)
      output             FAN_CTRL,

      // FPGA I2C
      output             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,

      // General purpose I/O
      inout     [35:0]         GPIO_0,
 
      // Hex LEDs
      output      [6:0]  HEX0,
      output      [6:0]  HEX1,
      output      [6:0]  HEX2,
      output      [6:0]  HEX3,
      output      [6:0]  HEX4,
      output      [6:0]  HEX5,

`ifdef ENABLE_HPS
      // ARM Cortex A9 Hard Processor System
      inout              HPS_CONV_USB_N,
      output      [14:0] HPS_DDR3_ADDR,
      output      [2:0]  HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output      [3:0]  HPS_DDR3_DM,
      inout       [31:0] HPS_DDR3_DQ,
      inout       [3:0]  HPS_DDR3_DQS_N,
      inout       [3:0]  HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_N,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input       [3:0]  HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output      [3:0]  HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout       [3:0]  HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C1_SCLK,
      inout              HPS_I2C1_SDAT,
      inout              HPS_I2C2_SCLK,
      inout              HPS_I2C2_SDAT,
      inout              HPS_I2C_CONTROL,
      inout              HPS_KEY,
      inout              HPS_LED,
      inout              HPS_LTC_GPIO,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout       [3:0]  HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      inout              HPS_SPIM_SS,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout       [7:0]  HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/

      // Infra-red
      input              IRDA_RXD,
      output             IRDA_TXD,

      // Push buttons on DE1-SoC mainboard
      input       [3:0]  KEY,

      // Red LED row
      output      [9:0]  LEDR,

      // PS2 port
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,

      // Slide switches
      input       [9:0]  SW,

      // TMDS
      input              TD_CLK27,
      input      [7:0]  TD_DATA,
      input             TD_HS,
      output             TD_RESET_N,
      input             TD_VS,


      // VGA video
      output      [7:0]  VGA_B,
      output             VGA_BLANK_N,
      output             VGA_CLK,
      output      [7:0]  VGA_G,
      output             VGA_HS,
      output      [7:0]  VGA_R,
      output             VGA_SYNC_N,
      output             VGA_VS,

      // Cambridge display board (plugged into GPIO1 port)

      // rotary dials
      input       [1:0]  DIALL,
      input       [1:0]  DIALR,
      // LED pixel ring (inverted before reaching ring)
      output             LEDRINGn,
      
      // LCD display
      output      [7:0]  LCD_R_out,
      output      [7:0]  LCD_G_out,
      output      [7:0]  LCD_B_out,
      // -- only LCD_R[7:2], LCD_G[7:2], LCD_B[7:2] are wired
      // through to display board, low-order pins are ignored
      // outputs need to be inverted based on VERSION pin
        
      output             LCD_HSYNC,
      output             LCD_VSYNC,
      output             LCD_DEN,
      output             LCD_DCLK,
      output             LCD_ON,	    // set high to enable LCD panel
      output             LCD_BACKLIGHT, // set high to turn on backlight, PWM to dim
      
      // shift register for buttons on display board
      output             SHIFT_CLKIN,
      output             SHIFT_LOAD,
      input              SHIFT_OUT,

      // capacitive touch sensor reset (high=enabled)
      output             TOUCH_WAKE,
      // I2C for touch, temperature and EEPROM
      inout              DISPLAY_SDA,
      inout              DISPLAY_SCL,

      // externally pulled low on 2019 (green) boards
      // weak pullup inside FPGA
      input              VERSION


);
      logic      [7:0]  LCD_R;
      logic      [7:0]  LCD_G;
      logic      [7:0]  LCD_B;

      // on green front panel boards VERSION=0 and display pins need to be inverted
      always_comb begin
          if (VERSION) begin
              LCD_R_out = LCD_R;
              LCD_G_out = LCD_G;
              LCD_B_out = LCD_B;
          end
          else begin
              LCD_R_out = ~LCD_R;
              LCD_G_out = ~LCD_G;
              LCD_B_out = ~LCD_B;
          end
      end

logic rst;
logic [7:0] rotary_pos_left, rotary_pos_right;
logic rot_cw_left, rot_ccw_left, rot_cw_right, rot_ccw_right;

// rotary counter
rotary rotary_left(.clk(CLOCK_50), .rst(rst), .rotary_in(DIALL), .rotary_pos(rotary_pos_left), .rot_cw(rot_cw_left), .rot_ccw(rot_ccw_left));
rotary rotary_right(.clk(CLOCK_50), .rst(rst), .rotary_in(DIALR), .rotary_pos(rotary_pos_right), .rot_cw(rot_cw_right), .rot_ccw(rot_ccw_right));
hex_to_7seg hex5(.hexval(rotary_pos_left[7:4]), .ledcode(HEX5));
hex_to_7seg hex4(.hexval(rotary_pos_left[3:0]), .ledcode(HEX4));
hex_to_7seg hex3(.hexval(rotary_pos_right[7:4]), .ledcode(HEX3));
hex_to_7seg hex2(.hexval(rotary_pos_right[3:0]), .ledcode(HEX2));

// shift register
typedef struct packed {
	logic button_b;
	logic button_a;
	logic button_y;
	logic button_x;
	logic spare0;
	logic touch_irq;
	logic spare1;
	logic spare2;
	logic nav_u;
	logic nav_l;
	logic nav_r;
	logic nav_d;
	logic nav_click;
	logic dialr_click;
	logic diall_click;
	logic temperature_alarm;
} buttonsT;

buttonsT buttons_decoded;
shiftregctl shift_register(.clock_50m(CLOCK_50), .reset(rst), .shiftreg_clk(SHIFT_CLKIN), .shiftreg_loadn(SHIFT_LOAD), .shiftreg_out(SHIFT_OUT), .buttons(buttons_decoded));

always_comb begin
	 rst = !KEY[0];
	 LEDR[0] = buttons_decoded.button_b;
	 LEDR[1] = buttons_decoded.button_a;
	 LEDR[2] = buttons_decoded.button_y;
	 LEDR[3] = buttons_decoded.button_x;
	 LEDR[4] = buttons_decoded.nav_u;
	 LEDR[5] = buttons_decoded.nav_l;
	 LEDR[6] = buttons_decoded.nav_r;
	 LEDR[7] = buttons_decoded.nav_d;
	 LEDR[8] = buttons_decoded.dialr_click;
	 LEDR[9] = buttons_decoded.diall_click;
end

endmodule