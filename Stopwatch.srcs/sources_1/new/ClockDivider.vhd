----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/06/2018 07:11:24 PM
-- Design Name: Clock Timer
-- Module Name: Clock Timer - Behavioral
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions: Vivado - 2018.2
-- Description: 
-- 
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

 use ieee.std_logic_unsigned.all; 
 USE ieee.std_logic_arith.all;

library my_custom_library;
use my_custom_library.my_types.all;

entity ClockDivider is
  Port ( 
    DivClock_In : in std_logic;
    DivClock_Out : out std_logic
  );
end ClockDivider;

architecture Behavioral of ClockDivider is

    component RippleCarryAdder_27Bit
        port (
            A, B : in std_logic_vector (26 downto 0) := "000000000000000000000000000";
            S : out std_logic_vector (26 downto 0);
            Cin : in std_logic := '0';
            Cout : out std_logic
        );
    end component;
        
    --constant 
    constant MHz_100    : std_logic_vector (26 downto 0) := "101111101011110000100000000";--"101111101011110000100000000";--"000111001001110000111000000";
    constant ms10 : std_logic_vector (26 downto 0) := "000000011110100001001000000";
    constant counter_reset : std_logic_vector (26 downto 0) := "000000000000000000000000000";
        
    signal a, b, counter : std_logic_vector (26 downto 0) := counter_reset;
    signal cin, s_tick  : std_logic := '0';
    signal s    : std_logic_vector(26 downto 0);
    signal cout : std_logic;
    signal digitcollection : time_collection;
    
    
begin
    DivClock_Out <= s_tick;
    
    process(DivClock_In) is
    begin
        if(rising_edge(DivClock_In)) then
            -- reset the counter
            if(counter = ms10) then
                -- update the numeric counter.
                s_tick <= '1';
                counter <= counter_reset;
            else
                s_tick <= '0';
                counter <= counter + 1;
            end if;
        end if;
    end process;
end Behavioral;
