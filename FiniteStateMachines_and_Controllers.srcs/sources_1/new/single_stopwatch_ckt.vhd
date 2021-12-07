----------------------------------------------------------------------------------
-- Company: Pacific Lutheran University
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 05/10/2015 11:05:55 AM
-- Design Name: Single Stop Watch Circuit
-- Module Name: single_stopwatch_ckt - Behavioral
-- Project Name: Finite State Machines and Controllers
-- Target Devices: Artix XC7A100T-CSG324
-- Tool Versions: Xilinx 2014.2
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

entity single_stopwatch_ckt is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           START : in STD_LOGIC;
           INCRE : in STD_LOGIC;
           STOP : in STD_LOGIC;
           RUN : inout STD_LOGIC;
           OUT_DISPLAY : out STD_LOGIC_VECTOR( 6 downto 0 ) );
end single_stopwatch_ckt;

architecture Behavioral of single_stopwatch_ckt is
    
    --COUNTER
    component counter is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               cen : in STD_LOGIC;
               B : inout STD_LOGIC_VECTOR( 3 downto 0 ) );
    end component;
    
    --signal for counter
    signal s_cntr_clk, s_cntr_rst, s_cntr_cen : std_logic;
    signal s_B : std_logic_vector( 3 downto 0 );
    
    --CLOCK DIVIDER
    component clkdiv is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               clkout : out STD_LOGIC);
    end component;
    
    --signal for clock divider
    signal s_clk, s_rst, s_clkout : std_logic;
    
    --SEVEN SEGMENT DISPLAY
    component seven_segment_ckt is
        Port ( INPUT : in STD_LOGIC_VECTOR (3 downto 0);
               OUTPUT : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    --signal for seven segment display 
    
    type t_mystates is (
        st_Start,
        st_Incre,
        st_Stop
    );
    
    signal next_state, present_state : t_mystates;

begin      


    

    --Next State Logic
    ns_logic: process( START, INCRE, STOP, present_state )
    begin
        case present_state is
        --begin
            when st_Start => --START
                if( START = '1' and STOP = '0' and INCRE = '0' ) then
                    next_state <= st_Start;
                elsif( START = '0' and STOP = '1' and INCRE = '0' ) then
                    next_state <= st_Stop;
                else next_state <= st_Start;
                end if;
            
            when st_Incre => --INCRE
                --COMPLETE THIS PORTION FOR INCREMENT
                if( START = '0' and STOP = '0' and INCRE = '1' ) then
                    next_state <= st_Incre;
                elsif( START = '1' and STOP = '0' and INCRE = '0' ) then
                    next_state <= st_Start;
                elsif( START = '0' and STOP = '1' and INCRE = '0' ) then
                    next_state <= st_Stop;
                else next_state <= st_Stop;
                end if;

            when st_Stop => -- STOP
                --COMPLETE THIS PORTION FOR STOP
                if( START = '1' and STOP = '0' and INCRE = '0' ) then
                    next_state <= st_Start;
                elsif( START = '0' and STOP = '0' and INCRE = '1' ) then
                    next_state <= st_Incre;
                elsif( START = '0' and STOP = '1' and INCRE = '0' ) then
                    next_state <= st_Stop;
                else next_state <= st_Stop;
                end if;
                
            when others => -- ALL ELSE, JUST STOP
                --COMPLETE THIS FOR OTHERS
                next_state <= st_Stop;
                
        end case;
    end process;
    
    state_reg: process( CLK, RESET )
    begin
        if( RESET = '1') then
            present_state <= st_Stop;
        elsif( CLK'event and CLK = '1' ) then
            present_state <= next_state;
        end if;
    end process;
    
    -- Output Logic
    RUN <= '1' when ( (present_state = st_Start) or (present_state = st_Incre) ) else '0';

    
    clock_divider : clkdiv port map(
        clk => CLK,
        rst => RESET,
        clkout => s_clk);
        
    count_ckt : counter port map(
        clk => s_clk,
        rst => RESET,
        cen => RUN,
        B => s_B);
        
    seven_seg_disp : seven_segment_ckt port map(
        INPUT => s_B,
        OUTPUT => OUT_DISPLAY);

end Behavioral;
