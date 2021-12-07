----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/04/2018 12:40:08 AM
-- Design Name: Counter Collector
-- Module Name: Counter - Behavioral
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions: Vivado 2018.2 
-- Description: 
--  Collector Module to store all stopwatch timer data 
--  Time collected: milliseconds, seconds, minutes, hours
-- 
-- Dependencies: 
--  Ripple Carry Adder - 4 Bit
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library my_custom_library;
use my_custom_library.my_types.all;

entity Counter is
  Port ( 
    CntClock_In, Reset, En : in std_logic;
    Digit_Collection : buffer time_collection := ("0000","0000","0000","0000","0000","0000","0000","0000")
  );
end Counter;

architecture Behavioral of Counter is
    
    constant counter_reset : std_logic_vector (26 downto 0) := "000000000000000000000000000";
    constant digitalCollection_reset : time_collection := ("0000","0000","0000","0000","0000","0000","0000","0000");
        
    type RCA_4b is array (7 downto 0) of std_logic_vector (3 downto 0);
    type RCA_cin is array (7 downto 0) of std_logic;
    
    signal a, b, s : RCA_4b := ("0000","0000","0000","0000","0000","0000","0000","0000");
    constant reset_collection : RCA_4b := ("0000","0000","0000","0000","0000","0000","0000","0000");
    signal cin, cout : RCA_cin := ('0','0','0','0','0','0','0','0');
    signal clkin : std_logic := '1';
    signal rst, enable : std_logic;
    signal dc : time_collection;
    
begin
    -- Port Mapping Ripple Carry Adder 
    seconds_0 : RippleCarryAdder_4Bit port map ( A => a(0) , B => b(0) , Cin => cin(0) , S => s(0), Cout => cout(0));
    seconds_1 : RippleCarryAdder_4Bit port map ( A => a(1) , B => b(1) , Cin => cin(1) , S => s(1), Cout => cout(1));
    minutes_0 : RippleCarryAdder_4Bit port map ( A => a(2) , B => b(2) , Cin => cin(2) , S => s(2), Cout => cout(2));
    minutes_1 : RippleCarryAdder_4Bit port map ( A => a(3) , B => b(3) , Cin => cin(3) , S => s(3), Cout => cout(3));
    hours_0   : RippleCarryAdder_4Bit port map ( A => a(4) , B => b(4) , Cin => cin(4) , S => s(4), Cout => cout(4));
    hours_1   : RippleCarryAdder_4Bit port map ( A => a(5) , B => b(5) , Cin => cin(5) , S => s(5), Cout => cout(5));
    days_0    : RippleCarryAdder_4Bit port map ( A => a(6) , B => b(6) , Cin => cin(6) , S => s(6), Cout => cout(6));
    days_1    : RippleCarryAdder_4Bit port map ( A => a(7) , B => b(7) , Cin => cin(7) , S => s(7), Cout => cout(7));
    
    clkin <= CntClock_In;
    rst <= Reset;
    enable <= En;
    
    --seconds
    Digit_Collection(0) <= s(0);
    Digit_Collection(1) <= s(1);
    --minutes
    Digit_Collection(2) <= s(2);
    Digit_Collection(3) <= s(3);
    --hours
    Digit_Collection(4) <= s(4);
    Digit_Collection(5) <= s(5);
    --days
    Digit_Collection(6) <= s(6);
    Digit_Collection(7) <= s(7);
    
    dc <= Digit_Collection;
    
    process(clkin, rst) is
    begin  
        if rising_edge(clkin) then 
            if rst = '1' then 
                a <= reset_collection;
                b <= reset_collection;
            elsif enable = '1' then
                -- millisecond digit index(0)
                if(s(0) = nine) then
                    a(0) <= zero;
                    b(0) <= zero;
                    a(1)(0) <= '1';
                    b(1) <= s(1);
                else
                    a(0)(0) <= '1';
                    b(0) <= s(0);
                end if;       
                -- milliseconds digit index(1) m? : 99
                if(s(1) = nine and s(0) = nine) then
                    a(1) <= zero; --<- set 5 to 0
                    b(1) <= zero;
                    a(2)(0) <= '1'; -- <-- set ? to 1
                    b(2) <= s(2);
                end if;
                                                
               -- seconds digit index(0)
                if(s(2) = nine and s(1) = nine and s(0) = nine) then
                    a(2) <= zero;
                    b(2) <= zero;
                    a(3)(0) <= '1';
                    b(3) <= s(3);
                end if;
                
                -- seconds digit index(1)
                if(s(3) = five and s(2) = nine and s(1) = nine and s(0) = nine) then
                    a(3) <= zero;
                    b(3) <= zero;
                    a(4)(0) <= '1';
                    b(4) <= s(4);
                end if;
                    
                -- minutes digit index(0)
                if(s(4) = nine and s(3) = five and s(2) = nine and s(1) = nine and s(0) = nine) then
                    a(4) <= zero;
                    b(4) <= zero;
                    a(5)(0) <= '1';
                    b(5) <= s(5);
                end if;
    
                -- minutes digit index(1)
               if(s(5) = five and s(4) = nine and s(3) = five and s(2) = nine and s(1) = nine and s(0) = nine) then
                   a(5) <= zero;
                   b(5) <= zero;
                   a(6)(0) <= '1';
                   b(6) <= s(6);
               end if;
                
                 -- hours digit index(0)
               if(s(6) = nine and s(5) = five and s(4) = nine and s(3) = five and s(2) = nine and s(1) = nine and s(0) = nine) then
                   a(6) <= zero;
                   b(6) <= zero;
                   a(7)(0) <= '1';
                   b(7) <= s(7);
               end if;
                   
                -- hours digit index(1)
                if(s(7) = nine and s(6) = nine and s(5) = five and s(4) = nine and s(3) = five and s(2) = nine and s(1) = nine and s(0) = nine) then
                    a(7) <= zero;
                    b(7) <= zero;
                end if;
            else
            end if;
        end if;
    end process;
end Behavioral;