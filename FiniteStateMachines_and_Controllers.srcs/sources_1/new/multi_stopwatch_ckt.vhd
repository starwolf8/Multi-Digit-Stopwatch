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

entity multi_stopwatch_ckt is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC; -- Button (RESET)
           START : in STD_LOGIC; -- Button (START)
           INCRE : in STD_LOGIC; -- Button (INCREMENT)
           STOP : in STD_LOGIC; -- Button (STOP)
           RUN : inout STD_LOGIC; -- Counter Enabler
           ANO : out STD_LOGIC_VECTOR( 3 downto 0); --anodes from 0 to 3
           DP : in STD_LOGIC;
           OUT_DISPLAY : out STD_LOGIC_VECTOR( 6 downto 0 ));
end multi_stopwatch_ckt;

architecture Behavioral of multi_stopwatch_ckt is

    --CLOCK DIVIDER
    component clkdiv is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               clkout : out STD_LOGIC);
    end component;
    --CLOCK DIVIDER (SIGNALS)
    signal s_clk : std_logic;

    --COUNTER
    component counter is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               cen : in STD_LOGIC;
               tc : out STD_LOGIC;
               B : inout STD_LOGIC_VECTOR( 3 downto 0 ) );
    end component;
    --COUNTER (SIGNALS)
    signal s_B0, s_B1, s_B2, s_B3 : std_logic_vector( 3 downto 0 );
    signal tc0, tc1, tc2, tc3 : std_logic;
    
    --STATE TYPES
    type t_mystates is (
        st_Start,
        st_Incre,
        st_Stop
    );
    --STATE TYPES (SIGNALS)
    signal next_state, present_state : t_mystates;
    
    --MULTI-DIGIT COMPONENT (4 digits)
    component mutli_seg_ckt is
        Port ( CLOCK : in STD_LOGIC;
               SS_INPUT0 : in STD_LOGIC_VECTOR( 6 downto 0 );
               SS_INPUT1 : in STD_LOGIC_VECTOR( 6 downto 0 );
               SS_INPUT2 : in STD_LOGIC_VECTOR( 6 downto 0 );
               SS_INPUT3 : in STD_LOGIC_VECTOR( 6 downto 0 );
               SEV_SEG : out STD_LOGIC_VECTOR( 6 downto 0 );
               ANODE : out STD_LOGIC_VECTOR( 3 downto 0 );
               SWITCHES : in STD_LOGIC_VECTOR( 3 downto 0 ); --was 6 downto 0 but changed to 3 dt 0)
               DMP : inout STD_LOGIC);
    end component;
    --MULTI-DIGIT COMPONENT (SIGNALS)
    signal anode : std_logic_vector( 3 downto 0 );
    signal sev_seg : std_logic_vector( 6 downto 0 );
    --signal dp : std_logic;
    
    
    --SEVEN SEGMENT DISPLAY
    component seven_segment_ckt is
        Port ( INPUT : in STD_LOGIC_VECTOR (3 downto 0);
               OUTPUT : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    --SEVEN SEGMENT DISPLAY (SIGNALS)
    signal out0, out1, out2, out3 : std_logic_vector ( 6 downto 0 );
    

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
        
    count_ckt0 : counter port map(
        clk => s_clk,
        rst => RESET,
        cen => RUN,
        tc => tc0,
        B => s_B0);

    seven_seg_disp0 : seven_segment_ckt port map(
        INPUT => s_B0,
        OUTPUT => out0);

    count_ckt1 : counter port map(
        clk => s_clk,
        rst => RESET,
        cen => tc0,
        tc => tc1,
        B => s_B1);

    seven_seg_disp1 : seven_segment_ckt port map(
        INPUT => s_B1,
        OUTPUT => out1);

    count_ckt2 : counter port map(
        clk => s_clk,
        rst => RESET,
        cen => tc1,
        tc => tc2,
        B => s_B2);

    seven_seg_disp2 : seven_segment_ckt port map(
        INPUT => s_B2,
        OUTPUT => out2);

    count_ckt3 : counter port map(
        clk => s_clk,
        rst => RESET,
        cen => tc2,
        tc => tc3,
        B => s_B3);

    seven_seg_disp3 : seven_segment_ckt port map(
        INPUT => s_B3,
        OUTPUT => out3);
        
    multi_digit_display : mutli_seg_ckt port map(
        CLOCK => CLK,
        SWITCHES => "1111",
        --DMP => DP,
        SS_INPUT0 => out0,
        SS_INPUT1 => out1,
        SS_INPUT2 => out2,
        SS_INPUT3 => out3,
        SEV_SEG => sev_seg,
        ANODE => anode);
        
    ANO <= anode;
    OUT_DISPLAY <= sev_seg;
    --DP <= dp;


end Behavioral;
