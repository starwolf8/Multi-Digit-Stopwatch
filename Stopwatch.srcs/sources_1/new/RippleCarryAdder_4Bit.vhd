----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/04/2018 12:31:01 AM
-- Design Name: Ripple Carry Adder
-- Module Name: Ripple Carry Adder 4Bit - Behavioral
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions: Vivado 2018.2 
-- Description: 
-- 
-- Dependencies: 
--  Full Adder
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--      References - https://allaboutfpga.com/4-bit-ripple-carry-adder-vhdl-code/
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCarryAdder_4Bit is
  Port ( 
    A, B : in std_logic_vector (3 downto 0) := "0000";
    S : out std_logic_vector (3 downto 0);
    Cin : in std_logic := '0';
    Cout : out std_logic
  );
end RippleCarryAdder_4Bit;

architecture Behavioral of RippleCarryAdder_4Bit is

    component Full_Adder
        Port (
            a, b, cin : in std_logic;
            s, cout : out std_logic
        );
    end component;
    
    -- Intermediate Carry Declaration
    signal c1, c2, c3 : std_logic;

begin
    -- Port Mapping Full Adder 4 times
    FA1: Full_Adder port map ( A => A(0), B => B(0), Cin => Cin, S => S(0), Cout => c1);
    FA2: Full_Adder port map ( A => A(1), B => B(1), Cin => c1, S => S(1), Cout => c2);
    FA3: Full_Adder port map ( A => A(2), B => B(2), Cin => c2, S => S(2), Cout => c3);
    FA4: Full_Adder port map ( A => A(3), B => B(3), Cin => c3, S => S(3), Cout => Cout);

end Behavioral;
