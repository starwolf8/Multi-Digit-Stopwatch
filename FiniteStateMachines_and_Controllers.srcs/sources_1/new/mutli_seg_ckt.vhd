----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2015 11:30:49 AM
-- Design Name: 
-- Module Name: mutli_seg_ckt - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
----------------------------------------------------------------------------------

-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

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

entity mutli_seg_ckt is
    Port ( CLOCK : in STD_LOGIC;
           SS_INPUT0 : in STD_LOGIC_VECTOR( 6 downto 0 );
           SS_INPUT1 : in STD_LOGIC_VECTOR( 6 downto 0 );
           SS_INPUT2 : in STD_LOGIC_VECTOR( 6 downto 0 );
           SS_INPUT3 : in STD_LOGIC_VECTOR( 6 downto 0 );
           SEV_SEG : out STD_LOGIC_VECTOR( 6 downto 0 );
           ANODE : out STD_LOGIC_VECTOR( 3 downto 0 );
           SWITCHES : in STD_LOGIC_VECTOR( 3 downto 0 ); --was 6 downto 0 but changed to 3 dt 0)
           DMP : inout STD_LOGIC);
end mutli_seg_ckt;

architecture Behavioral of mutli_seg_ckt is

    signal prescaler: STD_LOGIC_VECTOR(16 downto 0) := "11000011010100000";
    signal prescaler_counter: STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
    signal counter: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal r_anodes: STD_LOGIC_VECTOR(3 downto 0);


begin

    ANODE <= r_anodes;
    --SWITCHES <= "1111";

    -- Given Binary Value print it
    multiplex: process(counter, switches)
    begin
        -- Set anode correctly
        case counter(1 downto 0) is
            when "00" => r_anodes <= "1110"; -- AN 0
            when "01" => r_anodes <= "1101"; -- AN 1
            when "10" => r_anodes <= "1011"; -- AN 2
            when "11" => r_anodes <= "0111"; -- AN 3

            when others => r_anodes <= "1111"; -- nothing
        end case;

        -- Set segments correctly
        case r_anodes is
            when "1110" => 
                if SWITCHES(0) = ('1' or '0') then
                    SEV_SEG <= SS_INPUT0; -- 1 update here
                else
                    SEV_SEG <= "1000000"; -- 0
                end if;
            when "1101" => 
                if SWITCHES(1) = ('1' or '0') then
                    SEV_SEG <= SS_INPUT1; -- 1 UPDATE HERE
                else
                    SEV_SEG <= "1000000"; -- 0
                end if;
            when "1011" => 
                if SWITCHES(2) = ('1' or '0') then
                    SEV_SEG <= SS_INPUT2; -- 1
                else
                    SEV_SEG <= "1000000"; -- 0
                end if;
            when "0111" => 
                if SWITCHES(3) = ('1'or '0')  then
                    SEV_SEG <= SS_INPUT3; -- 1
                else
                    SEV_SEG <= "1000000"; -- 0
                end if;
                
            when others => SEV_SEG <= "1111111"; -- nothing
            end case;
    
        end process;
    
        countClock: process(CLOCK, counter)
        begin
            if rising_edge(CLOCK) then
                prescaler_counter <= prescaler_counter + 1;
                if(prescaler_counter = prescaler) then
                    -- Iterate
                    counter <= counter +1;
    
                    prescaler_counter <= (others => '0');
                end if;
            end if;
        end process;

end Behavioral;
