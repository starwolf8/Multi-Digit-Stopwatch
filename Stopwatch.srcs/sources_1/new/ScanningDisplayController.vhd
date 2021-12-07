----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/03/2018 09:47:25 PM
-- Design Name: Controller
-- Module Name: Scanning Display Controller
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions: Vivado 2018.2 
--
-- Description: 
--  A scanning display controller circuit can be used to show an eight-digit number on this display. This circuit drives
--  the anode signals and corresponding cathode patterns of each digit in a repeating, continuous succession at an
--  update rate that is faster than the human eye can detect. Each digit is illuminated just one-eighth of the time, but
--  because the eye cannot perceive the darkening of a digit before it is illuminated again, the digit appears
--  continuously illuminated. If the update, or "refresh", rate is slowed to around 45Hz, a flicker can be noticed in the
--  display.
--
-- Dependencies: 
--  Ripple Carry Adder 4 Bit
--  Ripple Carry Adder 27 Bit
--  Seven Segment Driver
--  Anode Selector
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
--  Please also reference - https://www.xilinx.com/support/documentation/university/XUP%20Boards/XUPNexys4DDR/documentation/Nexys4-DDR_rm.pdf
--                        - https://stackoverflow.com/questions/9701456/multidimensional-array-of-signals-in-vhdl
--
--  For each of the four digits to appear bright and continuously illuminated, all eight digits should be driven once
--  every 1 to 16ms, for a refresh frequency of about 1 KHz to 60Hz. For example, in a 62.5Hz refresh scheme, the
--  entire display would be refreshed once every 16ms, and each digit would be illuminated for 1/8 of the refresh
--  cycle, or 2ms. The controller must drive low the cathodes with the correct pattern when the corresponding anode
--  signal is driven high. 
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

library my_custom_library;
use my_custom_library.my_types.all;
    
entity ScanningDisplayController is
  Port ( 
    SDC_Clock : in std_logic;
    Digit_Collection : in time_collection;
    Anode : out std_logic_vector(7 downto 0) := "00000001";
    Cathode : out std_logic_vector(6 downto 0)
  );
end ScanningDisplayController;

architecture Behavioral of ScanningDisplayController is
    component SevenSegmentDriver is
        port (
            Digit : in std_logic_vector (3 downto 0);
            Cathode : out std_logic_vector (6 downto 0)
        );
    end component;
    
    component RippleCarryAdder_27Bit
        port (
            A, B : in std_logic_vector (26 downto 0) := "000000000000000000000000000";
            S : out std_logic_vector (26 downto 0);
            Cin : in std_logic := '0';
            Cout : out std_logic
        );
    end component;
    
    component AnodeSelector  
        Port ( 
          AnodeIndex : in std_logic_vector(3 downto 0);
          AnodeChosen : out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal clock_counter : std_logic_vector (26 downto 0);
    signal anode_counter : std_logic_vector (3 downto 0);
    
    -- Refresh period is 16 ms
    --signal counter : std_logic_vector (3 downto 0) := "0000";    
    constant counter_reset : std_logic_vector (26 downto 0) := "000000000000000000000000000";
    signal anodechosen : std_logic_vector (7 downto 0);
    --signal refresh_period : std_logic_vector (26 downto 0);
    signal a, b, s , digit, anodeindex: std_logic_vector (3 downto 0) := "0000";
    signal a2, b2, s2 : std_logic_vector (26 downto 0) := "000000000000000000000000000";
    signal cat : std_logic_vector (6 downto 0);
    signal cin, cout, cin2, cout2 : std_logic := '0';
    
    -- Digit refresh period is 2 ms;
    signal digit_period : std_logic_vector (26 downto 0);     
    constant Hz_500     : std_logic_vector (26 downto 0) := "000000000000000000111110100";
    constant Hz_1000    : std_logic_vector (26 downto 0) := "000000000000000001111101000";
begin
    RCA_4B : RippleCarryAdder_4Bit port map ( A => a, B => b, S => s, Cin => cin, Cout => cout );
    RCA_27B : RippleCarryAdder_27Bit port map ( A => a2, B => b2 , Cin => cin2, S => s2, Cout => cout2);
    SSD : SevenSegmentDriver port map (Digit => digit, Cathode => cat);
    AS : AnodeSelector port map (AnodeIndex => anodeindex, AnodeChosen => anodechosen);

    -- set the value for the specific sevSeg display.
    Cathode <= cat;
    -- anode is which seven segment LED will be updated/refreshed            
    Anode <= anodechosen;

process(SDC_Clock)
begin
    if(SDC_Clock'Event and rising_edge(SDC_Clock)) then
        a2(0) <= '1';
        b2 <= s2;
        
        if(s2 = Hz_1000) then
            a(0) <= '1';
            b <= s;
            anodeindex <= s;
            
            -- What digit to convert to cathode(s)
            digit <= Digit_Collection(to_integer(unsigned(s)));
            if(s = seven) then
                a <= zero;
                b <= zero;
            end if;
            
            a2 <= counter_reset;
            b2 <= counter_reset;
        end if;
    end if;
end process;
end Behavioral;
