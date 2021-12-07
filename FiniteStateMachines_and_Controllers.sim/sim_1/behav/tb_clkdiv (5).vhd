----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2015 04:30:12 PM
-- Design Name: 
-- Module Name: tb_clkdiv - Testbench
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_clkdiv is
end tb_clkdiv;

architecture Testbench of tb_clkdiv is

    component clkdiv is
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               CLKOUT : out STD_LOGIC);
    end component;
    
    signal clk, rst, clkout : std_logic;
    signal halfper : time := 25ns;
    signal period : time := halfper + halfper;
    
begin
    
    uut : clkdiv port map(
        CLK => clk,
        RST => rst,
        CLKOUT => clkout);

clk_driver: process
begin
    for i in 0 to 20 loop
        clk <= '0';
        wait for halfper;
        clk <= '1';
        wait for halfper;
    end loop;
    wait;
end process;

process
begin
    
    rst <= '1';
    wait for period;
    
    rst <= '0';
    wait for 10*period;
    

wait;
end process;


end Testbench;
