--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
--Date        : Thu Dec 15 20:00:39 2022
--Host        : DESKTOP-JTR0CVI running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    DDR_0_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_0_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_0_cas_n : inout STD_LOGIC;
    DDR_0_ck_n : inout STD_LOGIC;
    DDR_0_ck_p : inout STD_LOGIC;
    DDR_0_cke : inout STD_LOGIC;
    DDR_0_cs_n : inout STD_LOGIC;
    DDR_0_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_0_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_0_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_0_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_0_odt : inout STD_LOGIC;
    DDR_0_ras_n : inout STD_LOGIC;
    DDR_0_reset_n : inout STD_LOGIC;
    DDR_0_we_n : inout STD_LOGIC;
    FIXED_IO_0_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_0_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_0_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_0_ps_clk : inout STD_LOGIC;
    FIXED_IO_0_ps_porb : inout STD_LOGIC;
    FIXED_IO_0_ps_srstb : inout STD_LOGIC;
    btn_tri_i : in STD_LOGIC_VECTOR ( 4 downto 0 );
    led_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    clk : in STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    DDR_0_cas_n : inout STD_LOGIC;
    DDR_0_cke : inout STD_LOGIC;
    DDR_0_ck_n : inout STD_LOGIC;
    DDR_0_ck_p : inout STD_LOGIC;
    DDR_0_cs_n : inout STD_LOGIC;
    DDR_0_reset_n : inout STD_LOGIC;
    DDR_0_odt : inout STD_LOGIC;
    DDR_0_ras_n : inout STD_LOGIC;
    DDR_0_we_n : inout STD_LOGIC;
    DDR_0_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_0_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_0_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_0_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_0_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_0_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_0_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_0_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_0_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_0_ps_srstb : inout STD_LOGIC;
    FIXED_IO_0_ps_clk : inout STD_LOGIC;
    FIXED_IO_0_ps_porb : inout STD_LOGIC;
    btn_tri_i : in STD_LOGIC_VECTOR ( 4 downto 0 );
    led_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    FPGA_SIDE_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    FPGA_SIDE_clk : in STD_LOGIC;
    FPGA_SIDE_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    FPGA_SIDE_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    FPGA_SIDE_en : in STD_LOGIC;
    FPGA_SIDE_rst : in STD_LOGIC;
    FPGA_SIDE_we : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component design_1;
  
  component filter is
  port(
    FPGA_SIDE_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    FPGA_SIDE_clk : out STD_LOGIC;
    FPGA_SIDE_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    FPGA_SIDE_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    FPGA_SIDE_en : out STD_LOGIC;
    FPGA_SIDE_rst : out STD_LOGIC;
    FPGA_SIDE_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    clk : in STD_LOGIC
  );
  end component filter;
  
  
    signal FPGA_SIDE_addr :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal FPGA_SIDE_clk :  STD_LOGIC;
    signal FPGA_SIDE_din :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal FPGA_SIDE_dout :  STD_LOGIC_VECTOR ( 31 downto 0);
    signal FPGA_SIDE_en :  STD_LOGIC;
    signal FPGA_SIDE_rst : STD_LOGIC;
    signal FPGA_SIDE_we :  STD_LOGIC_VECTOR ( 3 downto 0 );
 --   signal clk : STD_LOGIC := '1';
    
    
begin
design_1_i: component design_1
     port map (
      DDR_0_addr(14 downto 0) => DDR_0_addr(14 downto 0),
      DDR_0_ba(2 downto 0) => DDR_0_ba(2 downto 0),
      DDR_0_cas_n => DDR_0_cas_n,
      DDR_0_ck_n => DDR_0_ck_n,
      DDR_0_ck_p => DDR_0_ck_p,
      DDR_0_cke => DDR_0_cke,
      DDR_0_cs_n => DDR_0_cs_n,
      DDR_0_dm(3 downto 0) => DDR_0_dm(3 downto 0),
      DDR_0_dq(31 downto 0) => DDR_0_dq(31 downto 0),
      DDR_0_dqs_n(3 downto 0) => DDR_0_dqs_n(3 downto 0),
      DDR_0_dqs_p(3 downto 0) => DDR_0_dqs_p(3 downto 0),
      DDR_0_odt => DDR_0_odt,
      DDR_0_ras_n => DDR_0_ras_n,
      DDR_0_reset_n => DDR_0_reset_n,
      DDR_0_we_n => DDR_0_we_n,
      FIXED_IO_0_ddr_vrn => FIXED_IO_0_ddr_vrn,
      FIXED_IO_0_ddr_vrp => FIXED_IO_0_ddr_vrp,
      FIXED_IO_0_mio(53 downto 0) => FIXED_IO_0_mio(53 downto 0),
      FIXED_IO_0_ps_clk => FIXED_IO_0_ps_clk,
      FIXED_IO_0_ps_porb => FIXED_IO_0_ps_porb,
      FIXED_IO_0_ps_srstb => FIXED_IO_0_ps_srstb,
      FPGA_SIDE_addr(31 downto 0) => FPGA_SIDE_addr(31 downto 0),
      FPGA_SIDE_clk => FPGA_SIDE_clk,
      FPGA_SIDE_din(31 downto 0) => FPGA_SIDE_din(31 downto 0),
      FPGA_SIDE_dout(31 downto 0) => FPGA_SIDE_dout(31 downto 0),
      FPGA_SIDE_en => FPGA_SIDE_en,
      FPGA_SIDE_rst => FPGA_SIDE_rst,
      FPGA_SIDE_we(3 downto 0) => FPGA_SIDE_we(3 downto 0),
      btn_tri_i(4 downto 0) => btn_tri_i(4 downto 0),
      led_tri_o(7 downto 0) => led_tri_o(7 downto 0)
    );
    

    
    --led_tri_o(1) <= btn_tri_i(1);
    
filter_new: filter
  port map(
      FPGA_SIDE_addr(31 downto 0) => FPGA_SIDE_addr(31 downto 0),
      FPGA_SIDE_clk => FPGA_SIDE_clk,
      FPGA_SIDE_din(31 downto 0) => FPGA_SIDE_din(31 downto 0),
      FPGA_SIDE_dout(31 downto 0) => FPGA_SIDE_dout(31 downto 0),
      FPGA_SIDE_en => FPGA_SIDE_en,
      FPGA_SIDE_rst => FPGA_SIDE_rst,
      FPGA_SIDE_we(3 downto 0) => FPGA_SIDE_we(3 downto 0),
      clk => clk
  );

    
end STRUCTURE;
