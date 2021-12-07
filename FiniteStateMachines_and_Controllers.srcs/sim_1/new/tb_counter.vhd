----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2015 12:41:02 PM
-- Design Name: 
-- Module Name: tb_counter - Testbench
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

entity tb_counter is
end tb_counter;

architecture Testbench of tb_counter is

    component counter is
        Port ( CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            CEN : in STD_LOGIC;
            B : inout STD_LOGIC_VECTOR( 3 downto 0) );
    end component;
    
    signal clk, rst, cen: std_logic;
    signal b : std_logic_vector( 3 downto 0);
    signal halfper : time := 25 ns;
    signal period : time := halfper + halfper;

begin

    uut : counter port map(
        CLK => clk,
        RST => rst,
        CEN => cen,
        B => b);
        
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
    cen <= '1';
    wait for 10*period;
    
    cen <= '0';
    wait for period;
    
    cen <= '1';
    wait for period;
    
    cen <= '0';
    wait for period;
        
    cen <= '1';
    wait for period;
    
    
wait;
end process;

end Testbench;
