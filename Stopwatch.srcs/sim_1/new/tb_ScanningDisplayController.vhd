----------------------------------------------------------------------------------
-- Company: Self
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/03/2018 10:27:29 PM
-- Design Name: Testbench Scanning Display Controller 
-- Module Name: tb_ScanningDisplayController - Testbench
-- Project Name: N/A
-- Target Devices: Artix-7 XC7A100T-CSG324
-- Tool Versions: Vivado 2018.2
--
-- Description: 
--  Simulate a clock 
--
-- Dependencies: 
-- 
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

entity tb_ScanningDisplayController is
end tb_ScanningDisplayController;


architecture Testbench of tb_ScanningDisplayController is
    
    -- Component of Scanning Display Controller
    component ScanningDisplayController
        port(
            anode : out std_logic_vector(7 downto 0) := "00000000"
        );
    end component;
    
    -- Ports of Scanning Display Controller
    signal ANODE : std_logic_vector(7 downto 0);
    
    -- clock signal
    CONSTANT PERIOD : TIME := 2ns;
    signal clk : std_logic := '0';
    

begin
    -- Instantiate DUT (Design Under Test)
    dut : ScanningDisplayController
    port map (
        ANODE => anode
    );
    
    -- Simulation Test Scanning Display Controller
    generate_clock: process(clk)
    begin
        clk <= NOT clk AFTER PERIOD/2;
    end process;

end Testbench;
