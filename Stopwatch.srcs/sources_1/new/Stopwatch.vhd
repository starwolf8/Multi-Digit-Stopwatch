----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/07/2018 08:48:00 PM
-- Design Name: Stopwatch
-- Module Name: Stopwatch - Behavioral
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
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

entity Stopwatch is
  Port ( 
    Reset, Clock : in std_logic;
    Anode : out std_logic_vector (7 downto 0);
    Cathode : out std_logic_vector (6 downto 0)
    );
end Stopwatch;

architecture Behavioral of Stopwatch is
    
    component Counter is
        port(
            Clock_Tick : in std_logic;
            Digit_Collection : out time_collection
        );
    end component;
    
    component ScanningDisplayController is
        port (
            SDC_Clock : in std_logic;
            Digit_Collection : in time_collection := ("0000","0000","0000","0000","0000","0000","0000","0000");
            Anode : out std_logic_vector(7 downto 0);
            Cathode : out std_logic_vector(6 downto 0)
        );
    end component;
    
    signal clk, tick, rst : std_logic := '0';
    signal dcIn, dcOut : time_collection;
    signal signal_an : std_logic_vector(7 downto 0);
    signal signal_cath : std_logic_vector(6 downto 0);
    
begin
    CTR : Counter port map (Clock_Tick => clk, Digit_Collection => dcOut);
    SDC : ScanningDisplayController port map (SDC_Clock => clk, Digit_Collection => dcIn, Anode => signal_an, Cathode => signal_cath);
    
    clk <= Clock;
    dcIn <= dcOut;
    -- to display Anode is driven low
    -- exact order as viewed on FPGA. 
    Anode <= signal_an;
    -- to display Cathode driven low
    Cathode <= signal_cath;
    
    process(Reset, Clock) 
    begin
        if (Reset = '1') then
            clk <= '0';
            --dcIn <= ("0000","0000","0000","0000","0000","0000","0000","0000");
        else
            clk <= Clock;
        end if;
    end process;

end Behavioral;

