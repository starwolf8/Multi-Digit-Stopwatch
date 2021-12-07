----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/04/2018 12:19:15 AM
-- Design Name: Full Adder
-- Module Name: Full Adder
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions: Vivado 2018.2 
-- Description:
-- 
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--      References - https://allaboutfpga.com/vhdl-code-for-full-adder/
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

entity Full_Adder is
  Port ( 
    A, B, Cin : in STD_LOGIC;
    S, Cout : out STD_LOGIC
  );
end Full_Adder;

architecture Behavioral of Full_Adder is

begin
    S <= A XOR B XOR Cin;
    Cout <= (A AND B) OR (Cin AND A) OR (Cin AND B);
end Behavioral;
