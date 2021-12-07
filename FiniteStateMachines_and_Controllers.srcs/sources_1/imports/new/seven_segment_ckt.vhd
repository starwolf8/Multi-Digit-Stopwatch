----------------------------------------------------------------------------------
-- Company: Pacific Lutheran University
-- Engineer: Jesus Reyes
-- 
-- Create Date: 03/12/2015 03:17:39 PM
-- Design Name: Seven Segment Display
-- Module Name: seven_segment_ckt - Behavioral
-- Project Name: Lab 04 - Task 1
-- Target Devices: Nexys 4 DDR
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

entity seven_segment_ckt is
    Port ( INPUT : in STD_LOGIC_VECTOR (3 downto 0);
           OUTPUT : out STD_LOGIC_VECTOR (6 downto 0));
           
end seven_segment_ckt;

architecture Behavioral of seven_segment_ckt is

begin
    with INPUT select
        OUTPUT <= 
                          
                  "1001111" when "0001",
                  "0010010" when "0010",
                  "0000110" when "0011",
                  "1001100" when "0100",
                  "0100100" when "0101",
                  "0100000" when "0110",
                  "0001111" when "0111",
                  "0000000" when "1000",
                  "0000100" when "1001",
                  "0000001" when others;--others for deci
                  --"0001000" when "1010",
                  --"1100000" when "1011",
                  --"0110001" when "1100",
                  --"1000010" when "1101",
                  --"0110000" when "1110",
                  --"0111000" when others;
                  
end Behavioral;
