-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "12/27/2016 22:49:49"

-- 
-- Device: Altera EP3C16F484C6 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	top_de0 IS
    PORT (
	BTN : IN std_logic_vector(2 DOWNTO 0);
	SW : IN std_logic_vector(9 DOWNTO 0);
	LED : OUT std_logic_vector(9 DOWNTO 0);
	HLED0 : OUT std_logic_vector(7 DOWNTO 0);
	HLED1 : OUT std_logic_vector(7 DOWNTO 0);
	HLED2 : OUT std_logic_vector(7 DOWNTO 0);
	HLED3 : OUT std_logic_vector(7 DOWNTO 0)
	);
END top_de0;

-- Design Ports Information
-- BTN[1]	=>  Location: PIN_G3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- BTN[2]	=>  Location: PIN_F1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[4]	=>  Location: PIN_G5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[5]	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[6]	=>  Location: PIN_H7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[7]	=>  Location: PIN_E3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[8]	=>  Location: PIN_E4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[9]	=>  Location: PIN_D2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LED[0]	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LED[1]	=>  Location: PIN_J2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LED[2]	=>  Location: PIN_J3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LED[3]	=>  Location: PIN_H1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LED[4]	=>  Location: PIN_F2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LED[5]	=>  Location: PIN_E1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LED[6]	=>  Location: PIN_C1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LED[7]	=>  Location: PIN_C2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LED[8]	=>  Location: PIN_B2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LED[9]	=>  Location: PIN_B1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED0[0]	=>  Location: PIN_E11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED0[1]	=>  Location: PIN_F11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED0[2]	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED0[3]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED0[4]	=>  Location: PIN_G12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED0[5]	=>  Location: PIN_F12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED0[6]	=>  Location: PIN_F13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED0[7]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED1[0]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED1[1]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED1[2]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED1[3]	=>  Location: PIN_A14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED1[4]	=>  Location: PIN_B14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED1[5]	=>  Location: PIN_E14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED1[6]	=>  Location: PIN_A15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED1[7]	=>  Location: PIN_B15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED2[0]	=>  Location: PIN_D15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED2[1]	=>  Location: PIN_A16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED2[2]	=>  Location: PIN_B16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED2[3]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED2[4]	=>  Location: PIN_A17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED2[5]	=>  Location: PIN_B17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED2[6]	=>  Location: PIN_F14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED2[7]	=>  Location: PIN_A18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED3[0]	=>  Location: PIN_B18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED3[1]	=>  Location: PIN_F15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED3[2]	=>  Location: PIN_A19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED3[3]	=>  Location: PIN_B19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED3[4]	=>  Location: PIN_C19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED3[5]	=>  Location: PIN_D19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED3[6]	=>  Location: PIN_G15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HLED3[7]	=>  Location: PIN_G16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[0]	=>  Location: PIN_J6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[1]	=>  Location: PIN_H5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[2]	=>  Location: PIN_H6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[3]	=>  Location: PIN_G4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- BTN[0]	=>  Location: PIN_H2,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF top_de0 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_BTN : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_SW : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_LED : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_HLED0 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_HLED1 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_HLED2 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_HLED3 : std_logic_vector(7 DOWNTO 0);
SIGNAL \BTN[1]~input_o\ : std_logic;
SIGNAL \BTN[2]~input_o\ : std_logic;
SIGNAL \SW[4]~input_o\ : std_logic;
SIGNAL \SW[5]~input_o\ : std_logic;
SIGNAL \SW[6]~input_o\ : std_logic;
SIGNAL \SW[7]~input_o\ : std_logic;
SIGNAL \SW[8]~input_o\ : std_logic;
SIGNAL \SW[9]~input_o\ : std_logic;
SIGNAL \LED[0]~output_o\ : std_logic;
SIGNAL \LED[1]~output_o\ : std_logic;
SIGNAL \LED[2]~output_o\ : std_logic;
SIGNAL \LED[3]~output_o\ : std_logic;
SIGNAL \LED[4]~output_o\ : std_logic;
SIGNAL \LED[5]~output_o\ : std_logic;
SIGNAL \LED[6]~output_o\ : std_logic;
SIGNAL \LED[7]~output_o\ : std_logic;
SIGNAL \LED[8]~output_o\ : std_logic;
SIGNAL \LED[9]~output_o\ : std_logic;
SIGNAL \HLED0[0]~output_o\ : std_logic;
SIGNAL \HLED0[1]~output_o\ : std_logic;
SIGNAL \HLED0[2]~output_o\ : std_logic;
SIGNAL \HLED0[3]~output_o\ : std_logic;
SIGNAL \HLED0[4]~output_o\ : std_logic;
SIGNAL \HLED0[5]~output_o\ : std_logic;
SIGNAL \HLED0[6]~output_o\ : std_logic;
SIGNAL \HLED0[7]~output_o\ : std_logic;
SIGNAL \HLED1[0]~output_o\ : std_logic;
SIGNAL \HLED1[1]~output_o\ : std_logic;
SIGNAL \HLED1[2]~output_o\ : std_logic;
SIGNAL \HLED1[3]~output_o\ : std_logic;
SIGNAL \HLED1[4]~output_o\ : std_logic;
SIGNAL \HLED1[5]~output_o\ : std_logic;
SIGNAL \HLED1[6]~output_o\ : std_logic;
SIGNAL \HLED1[7]~output_o\ : std_logic;
SIGNAL \HLED2[0]~output_o\ : std_logic;
SIGNAL \HLED2[1]~output_o\ : std_logic;
SIGNAL \HLED2[2]~output_o\ : std_logic;
SIGNAL \HLED2[3]~output_o\ : std_logic;
SIGNAL \HLED2[4]~output_o\ : std_logic;
SIGNAL \HLED2[5]~output_o\ : std_logic;
SIGNAL \HLED2[6]~output_o\ : std_logic;
SIGNAL \HLED2[7]~output_o\ : std_logic;
SIGNAL \HLED3[0]~output_o\ : std_logic;
SIGNAL \HLED3[1]~output_o\ : std_logic;
SIGNAL \HLED3[2]~output_o\ : std_logic;
SIGNAL \HLED3[3]~output_o\ : std_logic;
SIGNAL \HLED3[4]~output_o\ : std_logic;
SIGNAL \HLED3[5]~output_o\ : std_logic;
SIGNAL \HLED3[6]~output_o\ : std_logic;
SIGNAL \HLED3[7]~output_o\ : std_logic;
SIGNAL \BTN[0]~input_o\ : std_logic;
SIGNAL \cnt[0]~3_combout\ : std_logic;
SIGNAL \cnt[1]~0_combout\ : std_logic;
SIGNAL \cnt[2]~1_combout\ : std_logic;
SIGNAL \cnt[3]~2_combout\ : std_logic;
SIGNAL \D|WideOr6~0_combout\ : std_logic;
SIGNAL \D|WideOr5~0_combout\ : std_logic;
SIGNAL \D|WideOr4~0_combout\ : std_logic;
SIGNAL \D|WideOr3~0_combout\ : std_logic;
SIGNAL \D|WideOr2~0_combout\ : std_logic;
SIGNAL \D|WideOr1~0_combout\ : std_logic;
SIGNAL \D|WideOr0~0_combout\ : std_logic;
SIGNAL \SW[0]~input_o\ : std_logic;
SIGNAL \SW[3]~input_o\ : std_logic;
SIGNAL \SW[2]~input_o\ : std_logic;
SIGNAL \SW[1]~input_o\ : std_logic;
SIGNAL \D1|WideOr6~0_combout\ : std_logic;
SIGNAL \D1|WideOr5~0_combout\ : std_logic;
SIGNAL \D1|WideOr4~0_combout\ : std_logic;
SIGNAL \D1|WideOr3~0_combout\ : std_logic;
SIGNAL \D1|WideOr2~0_combout\ : std_logic;
SIGNAL \D1|WideOr1~0_combout\ : std_logic;
SIGNAL \D1|WideOr0~0_combout\ : std_logic;
SIGNAL cnt : std_logic_vector(3 DOWNTO 0);
SIGNAL \D1|ALT_INV_WideOr0~0_combout\ : std_logic;
SIGNAL \D|ALT_INV_WideOr0~0_combout\ : std_logic;

BEGIN

ww_BTN <= BTN;
ww_SW <= SW;
LED <= ww_LED;
HLED0 <= ww_HLED0;
HLED1 <= ww_HLED1;
HLED2 <= ww_HLED2;
HLED3 <= ww_HLED3;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\D1|ALT_INV_WideOr0~0_combout\ <= NOT \D1|WideOr0~0_combout\;
\D|ALT_INV_WideOr0~0_combout\ <= NOT \D|WideOr0~0_combout\;

-- Location: IOOBUF_X0_Y20_N9
\LED[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LED[0]~output_o\);

-- Location: IOOBUF_X0_Y20_N2
\LED[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LED[1]~output_o\);

-- Location: IOOBUF_X0_Y21_N23
\LED[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LED[2]~output_o\);

-- Location: IOOBUF_X0_Y21_N16
\LED[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LED[3]~output_o\);

-- Location: IOOBUF_X0_Y24_N23
\LED[4]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LED[4]~output_o\);

-- Location: IOOBUF_X0_Y24_N16
\LED[5]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LED[5]~output_o\);

-- Location: IOOBUF_X0_Y26_N23
\LED[6]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LED[6]~output_o\);

-- Location: IOOBUF_X0_Y26_N16
\LED[7]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LED[7]~output_o\);

-- Location: IOOBUF_X0_Y27_N9
\LED[8]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LED[8]~output_o\);

-- Location: IOOBUF_X0_Y27_N16
\LED[9]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LED[9]~output_o\);

-- Location: IOOBUF_X21_Y29_N23
\HLED0[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D|WideOr6~0_combout\,
	devoe => ww_devoe,
	o => \HLED0[0]~output_o\);

-- Location: IOOBUF_X21_Y29_N30
\HLED0[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D|WideOr5~0_combout\,
	devoe => ww_devoe,
	o => \HLED0[1]~output_o\);

-- Location: IOOBUF_X26_Y29_N2
\HLED0[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D|WideOr4~0_combout\,
	devoe => ww_devoe,
	o => \HLED0[2]~output_o\);

-- Location: IOOBUF_X28_Y29_N30
\HLED0[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D|WideOr3~0_combout\,
	devoe => ww_devoe,
	o => \HLED0[3]~output_o\);

-- Location: IOOBUF_X26_Y29_N9
\HLED0[4]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D|WideOr2~0_combout\,
	devoe => ww_devoe,
	o => \HLED0[4]~output_o\);

-- Location: IOOBUF_X28_Y29_N23
\HLED0[5]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D|WideOr1~0_combout\,
	devoe => ww_devoe,
	o => \HLED0[5]~output_o\);

-- Location: IOOBUF_X26_Y29_N16
\HLED0[6]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D|ALT_INV_WideOr0~0_combout\,
	devoe => ww_devoe,
	o => \HLED0[6]~output_o\);

-- Location: IOOBUF_X23_Y29_N9
\HLED0[7]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED0[7]~output_o\);

-- Location: IOOBUF_X21_Y29_N2
\HLED1[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D1|WideOr6~0_combout\,
	devoe => ww_devoe,
	o => \HLED1[0]~output_o\);

-- Location: IOOBUF_X21_Y29_N9
\HLED1[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D1|WideOr5~0_combout\,
	devoe => ww_devoe,
	o => \HLED1[1]~output_o\);

-- Location: IOOBUF_X23_Y29_N2
\HLED1[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D1|WideOr4~0_combout\,
	devoe => ww_devoe,
	o => \HLED1[2]~output_o\);

-- Location: IOOBUF_X23_Y29_N23
\HLED1[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D1|WideOr3~0_combout\,
	devoe => ww_devoe,
	o => \HLED1[3]~output_o\);

-- Location: IOOBUF_X23_Y29_N30
\HLED1[4]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D1|WideOr2~0_combout\,
	devoe => ww_devoe,
	o => \HLED1[4]~output_o\);

-- Location: IOOBUF_X28_Y29_N16
\HLED1[5]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D1|WideOr1~0_combout\,
	devoe => ww_devoe,
	o => \HLED1[5]~output_o\);

-- Location: IOOBUF_X26_Y29_N23
\HLED1[6]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D1|ALT_INV_WideOr0~0_combout\,
	devoe => ww_devoe,
	o => \HLED1[6]~output_o\);

-- Location: IOOBUF_X26_Y29_N30
\HLED1[7]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \HLED1[7]~output_o\);

-- Location: IOOBUF_X32_Y29_N30
\HLED2[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED2[0]~output_o\);

-- Location: IOOBUF_X30_Y29_N30
\HLED2[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED2[1]~output_o\);

-- Location: IOOBUF_X28_Y29_N2
\HLED2[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED2[2]~output_o\);

-- Location: IOOBUF_X30_Y29_N2
\HLED2[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED2[3]~output_o\);

-- Location: IOOBUF_X30_Y29_N16
\HLED2[4]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED2[4]~output_o\);

-- Location: IOOBUF_X30_Y29_N23
\HLED2[5]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED2[5]~output_o\);

-- Location: IOOBUF_X37_Y29_N2
\HLED2[6]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED2[6]~output_o\);

-- Location: IOOBUF_X32_Y29_N16
\HLED2[7]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED2[7]~output_o\);

-- Location: IOOBUF_X32_Y29_N23
\HLED3[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED3[0]~output_o\);

-- Location: IOOBUF_X39_Y29_N16
\HLED3[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED3[1]~output_o\);

-- Location: IOOBUF_X32_Y29_N9
\HLED3[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED3[2]~output_o\);

-- Location: IOOBUF_X32_Y29_N2
\HLED3[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED3[3]~output_o\);

-- Location: IOOBUF_X37_Y29_N23
\HLED3[4]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED3[4]~output_o\);

-- Location: IOOBUF_X37_Y29_N30
\HLED3[5]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED3[5]~output_o\);

-- Location: IOOBUF_X39_Y29_N30
\HLED3[6]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED3[6]~output_o\);

-- Location: IOOBUF_X39_Y29_N23
\HLED3[7]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \HLED3[7]~output_o\);

-- Location: IOIBUF_X0_Y21_N8
\BTN[0]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_BTN(0),
	o => \BTN[0]~input_o\);

-- Location: LCCOMB_X24_Y25_N0
\cnt[0]~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \cnt[0]~3_combout\ = !cnt(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => cnt(0),
	combout => \cnt[0]~3_combout\);

-- Location: FF_X24_Y25_N1
\cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \BTN[0]~input_o\,
	d => \cnt[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cnt(0));

-- Location: LCCOMB_X24_Y25_N18
\cnt[1]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \cnt[1]~0_combout\ = cnt(1) $ (cnt(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => cnt(1),
	datad => cnt(0),
	combout => \cnt[1]~0_combout\);

-- Location: FF_X24_Y25_N19
\cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \BTN[0]~input_o\,
	d => \cnt[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cnt(1));

-- Location: LCCOMB_X24_Y25_N12
\cnt[2]~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \cnt[2]~1_combout\ = cnt(2) $ (((cnt(1) & cnt(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => cnt(1),
	datac => cnt(2),
	datad => cnt(0),
	combout => \cnt[2]~1_combout\);

-- Location: FF_X24_Y25_N13
\cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \BTN[0]~input_o\,
	d => \cnt[2]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cnt(2));

-- Location: LCCOMB_X24_Y25_N26
\cnt[3]~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \cnt[3]~2_combout\ = cnt(3) $ (((cnt(2) & (cnt(0) & cnt(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cnt(2),
	datab => cnt(0),
	datac => cnt(3),
	datad => cnt(1),
	combout => \cnt[3]~2_combout\);

-- Location: FF_X24_Y25_N27
\cnt[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \BTN[0]~input_o\,
	d => \cnt[3]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cnt(3));

-- Location: LCCOMB_X24_Y25_N28
\D|WideOr6~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D|WideOr6~0_combout\ = (cnt(1) & (!cnt(2) & (cnt(3) & cnt(0)))) # (!cnt(1) & (cnt(2) $ (((!cnt(3) & cnt(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110000101000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cnt(1),
	datab => cnt(2),
	datac => cnt(3),
	datad => cnt(0),
	combout => \D|WideOr6~0_combout\);

-- Location: LCCOMB_X24_Y25_N14
\D|WideOr5~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D|WideOr5~0_combout\ = (cnt(2) & (cnt(1) $ (cnt(3) $ (cnt(0))))) # (!cnt(2) & (cnt(1) & (cnt(3) & cnt(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cnt(1),
	datab => cnt(2),
	datac => cnt(3),
	datad => cnt(0),
	combout => \D|WideOr5~0_combout\);

-- Location: LCCOMB_X24_Y25_N16
\D|WideOr4~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D|WideOr4~0_combout\ = (cnt(2) & (cnt(3) & ((cnt(1)) # (!cnt(0))))) # (!cnt(2) & (cnt(1) & (!cnt(3) & !cnt(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cnt(1),
	datab => cnt(2),
	datac => cnt(3),
	datad => cnt(0),
	combout => \D|WideOr4~0_combout\);

-- Location: LCCOMB_X24_Y25_N10
\D|WideOr3~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D|WideOr3~0_combout\ = (cnt(1) & (cnt(2) & ((cnt(0))))) # (!cnt(1) & (!cnt(3) & (cnt(2) $ (cnt(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100100000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cnt(1),
	datab => cnt(2),
	datac => cnt(3),
	datad => cnt(0),
	combout => \D|WideOr3~0_combout\);

-- Location: LCCOMB_X24_Y25_N20
\D|WideOr2~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D|WideOr2~0_combout\ = (cnt(1) & (((!cnt(3) & cnt(0))))) # (!cnt(1) & ((cnt(2) & (!cnt(3))) # (!cnt(2) & ((cnt(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111100000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cnt(1),
	datab => cnt(2),
	datac => cnt(3),
	datad => cnt(0),
	combout => \D|WideOr2~0_combout\);

-- Location: LCCOMB_X24_Y25_N22
\D|WideOr1~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D|WideOr1~0_combout\ = (cnt(2) & (!cnt(1) & (cnt(3)))) # (!cnt(2) & ((cnt(0) & ((!cnt(3)))) # (!cnt(0) & (cnt(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100001101100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cnt(1),
	datab => cnt(2),
	datac => cnt(3),
	datad => cnt(0),
	combout => \D|WideOr1~0_combout\);

-- Location: LCCOMB_X24_Y25_N24
\D|WideOr0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D|WideOr0~0_combout\ = (cnt(3)) # ((cnt(1) & ((!cnt(0)) # (!cnt(2)))) # (!cnt(1) & (cnt(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cnt(1),
	datab => cnt(2),
	datac => cnt(3),
	datad => cnt(0),
	combout => \D|WideOr0~0_combout\);

-- Location: IOIBUF_X0_Y24_N1
\SW[0]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(0),
	o => \SW[0]~input_o\);

-- Location: IOIBUF_X0_Y23_N8
\SW[3]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(3),
	o => \SW[3]~input_o\);

-- Location: IOIBUF_X0_Y25_N22
\SW[2]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(2),
	o => \SW[2]~input_o\);

-- Location: IOIBUF_X0_Y27_N1
\SW[1]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(1),
	o => \SW[1]~input_o\);

-- Location: LCCOMB_X23_Y28_N0
\D1|WideOr6~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D1|WideOr6~0_combout\ = (\SW[2]~input_o\ & (!\SW[1]~input_o\ & ((\SW[3]~input_o\) # (!\SW[0]~input_o\)))) # (!\SW[2]~input_o\ & (\SW[0]~input_o\ & (\SW[3]~input_o\ $ (!\SW[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100011010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[0]~input_o\,
	datab => \SW[3]~input_o\,
	datac => \SW[2]~input_o\,
	datad => \SW[1]~input_o\,
	combout => \D1|WideOr6~0_combout\);

-- Location: LCCOMB_X23_Y28_N10
\D1|WideOr5~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D1|WideOr5~0_combout\ = (\SW[2]~input_o\ & (\SW[0]~input_o\ $ (\SW[3]~input_o\ $ (\SW[1]~input_o\)))) # (!\SW[2]~input_o\ & (\SW[0]~input_o\ & (\SW[3]~input_o\ & \SW[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[0]~input_o\,
	datab => \SW[3]~input_o\,
	datac => \SW[2]~input_o\,
	datad => \SW[1]~input_o\,
	combout => \D1|WideOr5~0_combout\);

-- Location: LCCOMB_X23_Y28_N12
\D1|WideOr4~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D1|WideOr4~0_combout\ = (\SW[3]~input_o\ & (\SW[2]~input_o\ & ((\SW[1]~input_o\) # (!\SW[0]~input_o\)))) # (!\SW[3]~input_o\ & (!\SW[0]~input_o\ & (!\SW[2]~input_o\ & \SW[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[0]~input_o\,
	datab => \SW[3]~input_o\,
	datac => \SW[2]~input_o\,
	datad => \SW[1]~input_o\,
	combout => \D1|WideOr4~0_combout\);

-- Location: LCCOMB_X23_Y28_N2
\D1|WideOr3~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D1|WideOr3~0_combout\ = (\SW[1]~input_o\ & (\SW[0]~input_o\ & ((\SW[2]~input_o\)))) # (!\SW[1]~input_o\ & (!\SW[3]~input_o\ & (\SW[0]~input_o\ $ (\SW[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[0]~input_o\,
	datab => \SW[3]~input_o\,
	datac => \SW[2]~input_o\,
	datad => \SW[1]~input_o\,
	combout => \D1|WideOr3~0_combout\);

-- Location: LCCOMB_X23_Y28_N8
\D1|WideOr2~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D1|WideOr2~0_combout\ = (\SW[1]~input_o\ & (\SW[0]~input_o\ & (!\SW[3]~input_o\))) # (!\SW[1]~input_o\ & ((\SW[2]~input_o\ & ((!\SW[3]~input_o\))) # (!\SW[2]~input_o\ & (\SW[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[0]~input_o\,
	datab => \SW[3]~input_o\,
	datac => \SW[2]~input_o\,
	datad => \SW[1]~input_o\,
	combout => \D1|WideOr2~0_combout\);

-- Location: LCCOMB_X23_Y28_N14
\D1|WideOr1~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D1|WideOr1~0_combout\ = (\SW[2]~input_o\ & (((\SW[3]~input_o\ & !\SW[1]~input_o\)))) # (!\SW[2]~input_o\ & ((\SW[0]~input_o\ & (!\SW[3]~input_o\)) # (!\SW[0]~input_o\ & ((\SW[1]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011111000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[0]~input_o\,
	datab => \SW[3]~input_o\,
	datac => \SW[2]~input_o\,
	datad => \SW[1]~input_o\,
	combout => \D1|WideOr1~0_combout\);

-- Location: LCCOMB_X23_Y28_N24
\D1|WideOr0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \D1|WideOr0~0_combout\ = (\SW[3]~input_o\) # ((\SW[2]~input_o\ & ((!\SW[1]~input_o\) # (!\SW[0]~input_o\))) # (!\SW[2]~input_o\ & ((\SW[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[0]~input_o\,
	datab => \SW[3]~input_o\,
	datac => \SW[2]~input_o\,
	datad => \SW[1]~input_o\,
	combout => \D1|WideOr0~0_combout\);

-- Location: IOIBUF_X0_Y23_N15
\BTN[1]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_BTN(1),
	o => \BTN[1]~input_o\);

-- Location: IOIBUF_X0_Y23_N1
\BTN[2]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_BTN(2),
	o => \BTN[2]~input_o\);

-- Location: IOIBUF_X0_Y27_N22
\SW[4]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(4),
	o => \SW[4]~input_o\);

-- Location: IOIBUF_X0_Y22_N15
\SW[5]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(5),
	o => \SW[5]~input_o\);

-- Location: IOIBUF_X0_Y25_N15
\SW[6]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(6),
	o => \SW[6]~input_o\);

-- Location: IOIBUF_X0_Y26_N8
\SW[7]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(7),
	o => \SW[7]~input_o\);

-- Location: IOIBUF_X0_Y26_N1
\SW[8]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(8),
	o => \SW[8]~input_o\);

-- Location: IOIBUF_X0_Y25_N1
\SW[9]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(9),
	o => \SW[9]~input_o\);

ww_LED(0) <= \LED[0]~output_o\;

ww_LED(1) <= \LED[1]~output_o\;

ww_LED(2) <= \LED[2]~output_o\;

ww_LED(3) <= \LED[3]~output_o\;

ww_LED(4) <= \LED[4]~output_o\;

ww_LED(5) <= \LED[5]~output_o\;

ww_LED(6) <= \LED[6]~output_o\;

ww_LED(7) <= \LED[7]~output_o\;

ww_LED(8) <= \LED[8]~output_o\;

ww_LED(9) <= \LED[9]~output_o\;

ww_HLED0(0) <= \HLED0[0]~output_o\;

ww_HLED0(1) <= \HLED0[1]~output_o\;

ww_HLED0(2) <= \HLED0[2]~output_o\;

ww_HLED0(3) <= \HLED0[3]~output_o\;

ww_HLED0(4) <= \HLED0[4]~output_o\;

ww_HLED0(5) <= \HLED0[5]~output_o\;

ww_HLED0(6) <= \HLED0[6]~output_o\;

ww_HLED0(7) <= \HLED0[7]~output_o\;

ww_HLED1(0) <= \HLED1[0]~output_o\;

ww_HLED1(1) <= \HLED1[1]~output_o\;

ww_HLED1(2) <= \HLED1[2]~output_o\;

ww_HLED1(3) <= \HLED1[3]~output_o\;

ww_HLED1(4) <= \HLED1[4]~output_o\;

ww_HLED1(5) <= \HLED1[5]~output_o\;

ww_HLED1(6) <= \HLED1[6]~output_o\;

ww_HLED1(7) <= \HLED1[7]~output_o\;

ww_HLED2(0) <= \HLED2[0]~output_o\;

ww_HLED2(1) <= \HLED2[1]~output_o\;

ww_HLED2(2) <= \HLED2[2]~output_o\;

ww_HLED2(3) <= \HLED2[3]~output_o\;

ww_HLED2(4) <= \HLED2[4]~output_o\;

ww_HLED2(5) <= \HLED2[5]~output_o\;

ww_HLED2(6) <= \HLED2[6]~output_o\;

ww_HLED2(7) <= \HLED2[7]~output_o\;

ww_HLED3(0) <= \HLED3[0]~output_o\;

ww_HLED3(1) <= \HLED3[1]~output_o\;

ww_HLED3(2) <= \HLED3[2]~output_o\;

ww_HLED3(3) <= \HLED3[3]~output_o\;

ww_HLED3(4) <= \HLED3[4]~output_o\;

ww_HLED3(5) <= \HLED3[5]~output_o\;

ww_HLED3(6) <= \HLED3[6]~output_o\;

ww_HLED3(7) <= \HLED3[7]~output_o\;
END structure;


