----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/04/2018 08:54:48 AM
-- Design Name: Driver
-- Module Name: Seven Segment Driver - Behavioral
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions: Vivado 2018.2 
-- Description: 
--      Converts binary value to Cathodes to active low in order to 
--      power LEDs on. 
-- 
-- Dependencies: None.
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SevenSegmentDriver is
  Port ( 
    Digit : in std_logic_vector (3 downto 0);
    Cathode : out std_logic_vector(6 downto 0)
  );
end SevenSegmentDriver;

architecture Behavioral of SevenSegmentDriver is
    signal a,b,c,d : std_logic;
    
begin
    a <= Digit(0);
    b <= Digit(1);
    c <= Digit(2);
    d <= Digit(3);
    
    -- A
    Cathode(0) <= not((a xnor c) or b or d);
    -- B
    Cathode(1) <= not((a xnor b) or (not c)); 
    -- C
    Cathode(2) <= not(((not a) and (not b)) or c or (a and (not c))); 
    -- D
    Cathode(3) <= not((d or ((not a) and (b or (not c))) or (a and (not b) and c) or (b and (not c))));
    -- E
    Cathode(4) <= not(((not a) and (b or (not c))));
    -- F
    Cathode(5) <= not(d or ((not a) and ((not b) or c)) or (a and (not b) and c));
    -- G
    Cathode(6) <= not(((not a) and c) or d or (c xor b));
    

end Behavioral;
