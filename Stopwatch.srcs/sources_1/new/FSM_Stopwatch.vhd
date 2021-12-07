----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/14/2018 09:33:44 PM
-- Design Name: Stopwatch
-- Module Name: FSM_Stopwatch (Main)
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions: Vivado - 2018.2
-- Description: Mealy Machine
-- 
-- Dependencies: None
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

entity FSM_Stopwatch is
  Port ( 
    BTN_START, BTN_STOP, BTN_RESET, BTN_INCR, clk100mhz : in std_logic;
    AN : out std_logic_vector (7 downto 0);
    CA : out std_logic_vector (6 downto 0)
  );
end FSM_Stopwatch;

architecture Behavioral of FSM_Stopwatch is
---------------------------------------------------------------------
--     Signals & Types
---------------------------------------------------------------------
    type state_type is (st_RESET, st_START, st_STOP, st_INCR);
    signal current_state : state_type := st_STOP; -- set initial state. 
    signal next_state : state_type;
    signal clk, divClkIn, divClkOut, cntClockIn: std_logic;
    signal rst, en : std_logic := '0';
    signal a, signal_an : std_logic_vector (7 downto 0);
    signal c, signal_cath : std_logic_vector (6 downto 0);
    signal dcIn, dcOut : time_collection;
    signal STOP_DB, START_DB : std_logic;
    
---------------------------------------------------------------------
--      Components
---------------------------------------------------------------------
    -- Counter
    component Counter is
        port(
            CntClock_In, Reset, En : in std_logic;
            Digit_Collection : buffer time_collection
        );
    end component;
    
    -- Clock Divider
    component ClockDivider
        port (
            DivClock_In : in std_logic;
            DivClock_Out : out std_logic
        );    
    end component;
    
    -- Scanning Display Controller
    component ScanningDisplayController is
        port (
            SDC_Clock : in std_logic;
            Digit_Collection : in time_collection := ("0000","0000","0000","0000","0000","0000","0000","0000");
            Anode : out std_logic_vector(7 downto 0);
            Cathode : out std_logic_vector(6 downto 0)
        );
    end component;
            
    -- Debouncer
    component SwitchDebouncer is
        Port ( clk : in STD_LOGIC;
               reset : in std_logic;
               input : in std_logic; 
               debounce : out STD_LOGIC
        );
    end component;
    
    
begin    
---------------------------------------------------------------------
--     Processes: state register, next-state logic
---------------------------------------------------------------------
    -- Next State Process
    next_state_process : process (START_DB, BTN_START, STOP_DB, BTN_STOP, current_state) begin
        case current_state is
            -- Start: 
            when st_START => 
                if (START_DB = '0' and STOP_DB = '1' and BTN_RESET = '0') then
                    next_state <= st_STOP;
                end if;
                --if (START_DB = '0' and STOP_DB = '0' and BTN_RESET = '1') then
                --    next_state <= st_RESET;
                --end if;
            -- Stop: 
            when st_STOP => 
                if (START_DB = '1' and STOP_DB = '0' and BTN_RESET = '0') then
                    next_state <= st_START;
                end if;
                --if (START_DB = '0' and STOP_DB = '0' and BTN_RESET = '1') then
                --    next_state <= st_RESET;
                --end if;
            -- Reset: 
            when st_RESET => 
                if (START_DB = '0' and STOP_DB = '1' and BTN_RESET = '0') then
                    next_state <= st_STOP;
                end if;
                if (START_DB = '1' and STOP_DB = '0' and BTN_RESET = '0') then
                    next_state <= st_START;
                end if;
            -- Default: 
            when others =>
                next_state <= st_STOP; 
        end case;
    end process;
    
    -- State Register Process
    state_register : process (clk100mhz, BTN_RESET) begin
        if BTN_RESET = '1' then
            current_state <= st_RESET;
        elsif rising_edge(clk100mhz) then
            current_state <= next_state;
        end if;
    end process;
    
    -- State Output Process
    state_output : process(clk100mhz, current_state) is
    begin
        if rising_edge(clk100mhz) then
            case current_state is
                when st_START =>
                    en <= '1';
                    rst <= '0';
                    cntClockIn <= divClkOut;
                when st_STOP => 
                    en <= '0';
                    rst <= '0';
                    cntClockIn <= '0';
                when st_RESET =>
                    en <= '0';
                    rst <= '1';
                    cntClockIn <= '0';                    
                when others => 
            end case;            
        end if;
        
        
        dcIn <= dcOut;
    end process state_output;
        
        
    CDIV : ClockDivider port map (DivClock_In => clk100mhz, DivClock_Out => divClkOut);
    CTR : Counter port map (CntClock_In => cntClockIn, Reset => rst, En => en, Digit_Collection => dcOut);
    SDC : ScanningDisplayController port map (SDC_Clock => clk100mhz, Digit_Collection => dcIn, Anode => AN, Cathode => CA);
    START_DEBOUNCER : SwitchDebouncer port map (clk => clk100mhz, reset => BTN_RESET, input => BTN_START, debounce => START_DB);
    STOP_DEBOUNCER : SwitchDebouncer port map (clk => clk100mhz, reset => BTN_RESET, input => BTN_STOP, debounce => STOP_DB);
    --RESET_DEBOUNCER : SwitchDebouncer port map (clk => clk100mhz, reset => BTN_RESET, input => BTN_STOP, debounce => RESET_DB);


        
    
end Behavioral;