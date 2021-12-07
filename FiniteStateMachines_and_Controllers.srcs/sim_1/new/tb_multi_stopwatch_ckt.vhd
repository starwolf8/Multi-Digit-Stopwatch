----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2015 05:02:38 PM
-- Design Name: 
-- Module Name: tb_multi_stopwatch_ckt - Testbench
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

entity tb_multi_stopwatch_ckt is
end tb_multi_stopwatch_ckt;

architecture Testbench of tb_multi_stopwatch_ckt is

    component multi_stopwatch_ckt is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               START : in STD_LOGIC;
               INCRE : in STD_LOGIC;
               STOP : in STD_LOGIC;
               RUN : inout STD_LOGIC;
               ANO : out STD_LOGIC_VECTOR (3 downto 0);
               DP : in STD_LOGIC;
               OUT_DISPLAY : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    signal clk, reset, start, incre, stop, dp, run : std_logic;
    signal ano : std_logic_vector ( 3 downto 0 );
    signal out_display : std_logic_vector ( 6 downto 0 );
    
    signal halfper : time := 1ns;
    signal period : time := halfper + halfper;

begin

    uut : multi_stopwatch_ckt port map(
        CLK => clk,
        RESET => reset,
        START => start,
        INCRE => incre,
        STOP => stop,
        RUN => run,
        ANO => ano,
        DP => dp,
        OUT_DISPLAY => out_display);
        
    clk_driver: process
        begin
            for i in 0 to 1000000 loop
                clk <= '0';
                wait for halfper;
                clk <= '1';
                wait for halfper;
            end loop;
            wait;
        end process;
        
    process
    begin
    
        reset <= '1';
        start <= '0';
        stop <= '0';
        incre <= '0';
        dp <= '0';
        wait for period;
        
        reset <= '0';
        wait for period;
        
        start <= '1';
        dp <= '1';
        wait for 10*period;
        
        stop <= '1';
        start <= '0';
        wait for period;
        
        start <= '1';
        stop <= '0';
        wait for 10000*period;
        
        
    
    wait;
    
end process;

end Testbench;
