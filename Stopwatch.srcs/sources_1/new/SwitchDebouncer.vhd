----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 12/17/2018 10:03:26 PM
-- Design Name: Switch Debouncer
-- Module Name: SwitchDebouncer - Behavioral
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions: Vivado - 2018.2
-- Description: Entity designed to handle switch bouncing, which causes unwanted behavior responses from button pressing
-- 
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--  Reference : (VHDL Button Debounce) - https://www.youtube.com/watch?v=eRawZX_R7Bg
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SwitchDebouncer is
    generic (
        pulse : boolean := true;
        active_low: boolean := false;
        delay : integer := 50000
    );
    Port ( clk : in STD_LOGIC;
           reset : in std_logic;
           input : in std_logic; 
           debounce : out STD_LOGIC);
end SwitchDebouncer;

architecture Behavioral of SwitchDebouncer is
    signal sample : std_logic_vector ( 9 downto 0 ) := "0001111000";
    signal sample_pulse: std_logic := '0';
    
begin
    
    -- Clock Divider Process
    clock_divider : process(clk) 
    variable count: integer := 0;
    begin
        if rising_edge(clk) then
            if reset = '1' then
                count := 0;
                sample_pulse <= '0';
            elsif count < delay then
                count := count + 1;
                sample_pulse <= '0';
            else 
                count := 0;
                sample_pulse <=  '1';
            end if;
        end if;
    end process clock_divider;
    
    -- Sampling Process
    sampling_process : process(clk)
    begin
        if rising_edge(clk) then 
            if reset = '1' then
                sample <= (others => input);
            else
                if sample_pulse = '1' then
                    sample(9 downto 1) <= sample(8 downto 0); -- left shift
                    sample(0) <= input;
                end if;
            end if;
        end if;
    end process sampling_process;
    
    -- Button Debouncing Process
    debouncing_process : process (clk)
    variable flag : std_logic := '0';
    begin
        if rising_edge(clk) then
            if reset = '1' then 
                debounce <= '0';
            else
                if active_low then
                    if pulse then
                        if sample = "0000000000" then
                            if flag = '0' then
                                debounce <= '1'; 
                                flag := '1';
                            else
                                debounce <= '0';
                                flag := '0';
                            end if;
                        else
                            debounce <= '0';
                            flag := '0';
                        end if;
                    else
                        if sample = "0000000000" then -- Active Low Constant out
                            debounce <= '1';
                        elsif sample = "1111111111" then
                            debounce <= '0';
                        end if;
                    end if;
                else -- active high system
                    if pulse then
                        if sample = "1111111111" then -- Active High Pulse Out
                            if (flag = '0') then
                                debounce <= '1';
                                flag := '1';
                            else
                                debounce <= '0';
                            end if;
                        else
                            debounce <= '0';
                            flag := '0';
                        end if;
                    else
                        if (sample = "1111111111") then -- active high const out
                            debounce <= '1';
                        elsif (sample = "0000000000") then
                            debounce <= '0';
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process debouncing_process;

end Behavioral;
