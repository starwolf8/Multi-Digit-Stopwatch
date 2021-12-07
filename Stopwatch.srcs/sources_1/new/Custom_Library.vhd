----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/05/2018 10:22:34 PM
-- Design Name: Stopwatch
-- Module Name: Custom_Library - Behavioral
-- Project Name Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions:  Vivado - 2018.2
-- Description: Custom Library used by Stopwatch Project. 
-- 
-- Dependencies: 
--  https://forums.xilinx.com/t5/Design-Entry/Vivado-Creating-new-user-library/td-p/523623
--  https://www.nandland.com/vhdl/examples/example-package.html
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Package Declaration Section
package my_types is
            
    component RippleCarryAdder_4Bit
        port (
            A, B : in std_logic_vector (3 downto 0) := "0000";
            S : out std_logic_vector (3 downto 0);
            Cin : in std_logic := '0';
            Cout : out std_logic
        );
    end component;
    
    type time_block is array (1 downto 0) of std_logic_vector(3 downto 0);
    type time_collection is array (7 downto 0) of std_logic_vector(3 downto 0);
    
    constant zero : std_logic_vector (3 downto 0) := "0000";
    constant five : std_logic_vector (3 downto 0) := "0101";
    constant six  : std_logic_vector (3 downto 0) := "0110";
    constant seven: std_logic_vector (3 downto 0) := "0111";
    constant eight: std_logic_vector (3 downto 0) := "1000";
    constant nine : std_logic_vector (3 downto 0) := "1001";
    constant led_3 : std_logic_vector (6 downto 0) := "0110000"; -- "1001111"; -- "0110000";
    
end package my_types;

-- Package Body Section
package body my_types is
    
end package body my_types;