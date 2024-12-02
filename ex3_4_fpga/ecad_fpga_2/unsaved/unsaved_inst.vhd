	component unsaved is
		port (
			clk_clk                             : in  std_logic                    := 'X'; -- clk
			reset_reset_n                       : in  std_logic                    := 'X'; -- reset_n
			eightbitstosevenseg_0_led_pins_led0 : out std_logic_vector(6 downto 0);        -- led0
			eightbitstosevenseg_0_led_pins_led1 : out std_logic_vector(6 downto 0)         -- led1
		);
	end component unsaved;

	u0 : component unsaved
		port map (
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                            clk.clk
			reset_reset_n                       => CONNECTED_TO_reset_reset_n,                       --                          reset.reset_n
			eightbitstosevenseg_0_led_pins_led0 => CONNECTED_TO_eightbitstosevenseg_0_led_pins_led0, -- eightbitstosevenseg_0_led_pins.led0
			eightbitstosevenseg_0_led_pins_led1 => CONNECTED_TO_eightbitstosevenseg_0_led_pins_led1  --                               .led1
		);

