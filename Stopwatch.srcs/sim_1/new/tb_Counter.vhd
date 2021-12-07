----------------------------------------------------------------------------------
-- Company: Self
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/04/2018 01:07:10 AM
-- Design Name: Counter
-- Module Name: tb_Counter - Testbench
-- Project Name: Stopwatch
-- Target Devices:  Artix-7 XC7A100T-CSG324
-- Tool Versions: Vivado 2018.2
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

library my_custom_library;
use my_custom_library.my_types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_Counter is
end tb_Counter;

architecture Testbench of tb_Counter is

    component Counter
        port (
            Clock_Tick : in std_logic;
            Digit_Collection : out time_collection := ("0000","0000","0000","0000","0000","0000","0000","0000")
        );
    end component;
    
    constant Mhz100_period : Time := 10ns;
    signal digitcollection : time_collection;
    signal clock : std_logic := '1';
        
begin
    -- Instantiate DUT (Design Under Test)
    dut : Counter port map ( Clock_Tick => clock, Digit_Collection => digitcollection );
        
    generate_clock : process(clock) is
    begin
        clock <= not clock after Mhz100_period/2; -- simulate 100Mhz Clock
    end process;
end Testbench;
