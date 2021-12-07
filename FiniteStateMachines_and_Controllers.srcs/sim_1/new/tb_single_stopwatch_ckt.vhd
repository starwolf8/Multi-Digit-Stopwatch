----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2015 11:43:20 AM
-- Design Name: 
-- Module Name: tb_single_stopwatch_ckt - Testbench
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

entity tb_single_stopwatch_ckt is
end tb_single_stopwatch_ckt;

architecture Testbench of tb_single_stopwatch_ckt is
    component single_stopwatch_ckt is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               START : in STD_LOGIC;
               STOP : in STD_LOGIC;
               INCRE : in STD_LOGIC;
               RUN : inout STD_LOGIC;
               OUT_DISPLAY : out STD_LOGIC_VECTOR( 6 downto 0) );
    end component;
    
    signal out_display : std_logic_vector( 6 downto 0 );
    signal clk, reset, start, stop, incre : std_logic;
    signal run : std_logic;
    
    signal halfper : time := 1000ns;
    signal period : time := halfper + halfper;
    
    
begin
    
    uut : single_stopwatch_ckt port map(
        CLK => clk,
        RESET => reset,
        START => start,
        STOP => stop,
        INCRE => incre,
        RUN => run,
        OUT_DISPLAY => out_display);
        
    clk_driver: process
    begin
        for i in 0 to 200000 loop
            clk <= '0';
            wait for halfper;
            clk <= '1';
            wait for halfper;
        end loop;
        wait;
    end process;
        
process
begin

--create simulation here
    reset <= '1';
    start <= '0';
    stop <= '0';
    incre <= '0';
    wait for period;
    
    reset <= '0';
    start <= '1';
    wait for 10*period;
    
    start <= '0';
    stop <= '1';
    wait for 5*period;
    
    start <= '1';
    stop <= '1';
    wait for 5*period;
    
    start <= '0';
    stop <= '1';
    wait for 5*period;
    
    incre <= '1';
    wait for period;
    
    incre <= '1';
    wait for period;
    
    incre <= '1';
    wait for period;
    
    incre <= '1';
    wait for period;

wait;
end process;


end Testbench;
