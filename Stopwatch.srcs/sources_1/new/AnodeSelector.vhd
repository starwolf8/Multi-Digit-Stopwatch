----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/08/2018 09:37:06 PM
-- Design Name: Selector
-- Module Name: Anode Selector - Behavioral
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions: Vivado 2018.2 
-- Description: 
--      Selects the Anode based on index.
--      i.e. converts binary value to active low position output.
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

entity AnodeSelector is
  Port ( 
    AnodeIndex : in std_logic_vector(3 downto 0);
    AnodeChosen : out std_logic_vector(7 downto 0)
  );
end AnodeSelector;

architecture Behavioral of AnodeSelector is
begin
    process (AnodeIndex)
    begin
    case AnodeIndex is
        when "0000" => -- index = 0
            AnodeChosen <= "11111110";
        when "0001" => -- index = 1
            AnodeChosen <= "11111101";
        when "0010" => -- index = 2
            AnodeChosen <= "11111011";
        when "0011" => -- index = 3
            AnodeChosen <= "11110111";
        when "0100" => -- index = 4
            AnodeChosen <= "11101111";
        when "0101" => -- index = 5
            AnodeChosen <= "11011111";
        when "0110" => -- index = 6
            AnodeChosen <= "10111111";
        when "0111" => -- index = 7
            AnodeChosen <= "01111111";
        when others =>
            AnodeChosen <= "11111111";
    end case;
    end process;
end Behavioral;
