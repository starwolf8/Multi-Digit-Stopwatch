----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/20/2018 08:41:24 PM
-- Design Name: 
-- Module Name: tb_FMS_Stopwatch - Testbench
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

entity tb_FMS_Stopwatch is
end tb_FMS_Stopwatch;

architecture Testbench of tb_FMS_Stopwatch is
    
    component FSM_Stopwatch
        port (
            BTN_START, BTN_STOP, BTN_RESET, BTN_INCR, clk100mhz : in std_logic;
            AN : out std_logic_vector (7 downto 0);
            CA : out std_logic_vector (6 downto 0)
        );
    end component;
    
    constant Mhz100_period : Time := 10ns;
    constant ms10 : Time := 10ms;
    signal start, stop, reset, incr, clk : std_logic := '0';
    signal a : std_logic_vector (7 downto 0);
    signal c : std_logic_vector (6 downto 0);

begin

    dut : FSM_Stopwatch port map ( BTN_START => start, BTN_STOP => stop, BTN_RESET => reset, BTN_INCR => incr, clk100mhz => clk, AN => a, CA => c);
    
    generate_clock : process (clk) is
    begin
        clk <= not clk after Mhz100_period / 2;
    end process;
    
    test_dut : process is
    begin
        -- test start timer
        start <= '0';
        wait for ms10 * 5;
        
        start <= '1';
        wait for ms10 * 5;
        
        start <= '0';
        wait for ms10 * 100;
        
        stop <= '1';
        wait for ms10 * 5;
        
        stop <= '0';
        wait for ms10 * 5;
        
        reset <= '1';
        wait for ms10 * 5;
        
        reset <= '0';
        wait for ms10 * 5;
        
        wait;
        
    end process;

end Testbench;
