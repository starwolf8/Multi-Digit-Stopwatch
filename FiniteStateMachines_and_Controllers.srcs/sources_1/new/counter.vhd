----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2015 12:27:38 PM
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cen : in STD_LOGIC;
           tc : out STD_LOGIC;
           B : inout STD_LOGIC_VECTOR( 3 downto 0 ));
end counter;

architecture Behavioral of counter is

begin

    process(clk, rst)
        begin
            if rst = '1' then B <= "0000";
                elsif ( clk'event and clk = '1' and cen = '1' ) then
                    B <= B + 1; 
            end if;   
            
            if( B = "1001" and cen = '1') then --deci "1001"
                tc <= '1';
                
            else tc <= '0';
            end if;
            
            if( B = "1010" ) then --deci "1010"
                B <= "0000";
            end if;
        end process;
        

end Behavioral;
