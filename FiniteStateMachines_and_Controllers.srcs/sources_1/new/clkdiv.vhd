library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clkdiv is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clkout : out STD_LOGIC );
end clkdiv;

architecture Behavioral of clkdiv is
constant cntendval : STD_LOGIC_VECTOR( 26 downto 0 ) := "101111101011110000100000000";
signal cntval : STD_LOGIC_VECTOR( 26 downto 0 );

begin

process (clk, rst)
    begin
    if( rst ='1' ) then cntval <= "000000000000000000000000000";
        elsif(clk'event and clk = '1') then
            if (cntval = cntendval) then cntval <= "000000000000000000000000000";
            else cntval <= cntval + 1250;-- place plus (1 for single digit) for slow or 1000 for fast
            end if;
        end if;
    end process;
    
    clkout <= cntval(26);--;


end Behavioral;
