----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/09/2018 09:42:41 PM
-- Design Name: 
-- Module Name: tb_ClockTimer - Testbench
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

entity tb_ClockTimer is
end tb_ClockTimer;

architecture Testbench of tb_ClockTimer is
    component ClockTimer
        port (
            Clock : in std_logic;
            Tick : out std_logic
        );
    end component;
    
    constant MHz100 : Time := 10ns;
    signal clock, tick : std_logic := '0';
    
begin

    dut : ClockTimer port map (Clock => clock, Tick => tick);
    
    generate_clock : process(clock) is
    begin
        clock <= not clock after MHz100/2;
    end process;


end Testbench;
