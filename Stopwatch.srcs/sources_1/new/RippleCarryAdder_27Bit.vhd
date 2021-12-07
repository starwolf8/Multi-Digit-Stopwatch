----------------------------------------------------------------------------------
-- Engineer: Jesus E. Reyes III
-- 
-- Create Date: 08/04/2018 02:08:14 PM
-- Design Name: Ripple Carry Adder
-- Module Name: Ripple Carry Adder 20 Bit - Behavioral
-- Project Name: Stopwatch
-- Target Devices: Artix-7 XC7A100T-CSG324 
-- Tool Versions: Vivado 2018.2 
-- Description: 
-- 
-- Dependencies:
--  Full Adder
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

entity RippleCarryAdder_27Bit is
  Port ( 
      A, B : in std_logic_vector (26 downto 0) := "000000000000000000000000000";
      S : out std_logic_vector (26 downto 0);
      Cin : in std_logic := '0';
      Cout : out std_logic
  );
end RippleCarryAdder_27Bit;

architecture Behavioral of RippleCarryAdder_27Bit is

    component Full_Adder
        Port (
            a, b, cin : in STD_LOGIC;
            s, cout : out STD_LOGIC
        );
    end component;
    
    signal c1, c2, c3, c4, c5, c6, c7, c8, c9, c10 : std_logic;
    signal c11, c12, c13, c14, c15, c16, c17, c18 : std_logic;
    signal c19, c20, c21, c22, c23, c24, c25, c26 : std_logic;
    
begin
    -- Port Mapping Full Adder 20 times

    FA1:  Full_Adder port map ( A=> A(0),  B => B(0),  Cin => Cin, S => S(0),  Cout => c1);
    FA2:  Full_Adder port map ( A=> A(1),  B => B(1),  Cin => c1,  S => S(1),  Cout => c2);
    FA3:  Full_Adder port map ( A=> A(2),  B => B(2),  Cin => c2,  S => S(2),  Cout => c3);
    FA4:  Full_Adder port map ( A=> A(3),  B => B(3),  Cin => c3,  S => S(3),  Cout => c4);
    FA5:  Full_Adder port map ( A=> A(4),  B => B(4),  Cin => c4,  S => S(4),  Cout => c5);
    FA6:  Full_Adder port map ( A=> A(5),  B => B(5),  Cin => c5,  S => S(5),  Cout => c6);
    FA7:  Full_Adder port map ( A=> A(6),  B => B(6),  Cin => c6,  S => S(6),  Cout => c7);
    FA8:  Full_Adder port map ( A=> A(7),  B => B(7),  Cin => c7,  S => S(7),  Cout => c8);
    FA9:  Full_Adder port map ( A=> A(8),  B => B(8),  Cin => c8,  S => S(8),  Cout => c9);
    FA10: Full_Adder port map ( A=> A(9),  B => B(9),  Cin => c9,  S => S(9),  Cout => c10);
    FA11: Full_Adder port map ( A=> A(10), B => B(10), Cin => c10, S => S(10), Cout => c11);
    FA12: Full_Adder port map ( A=> A(11), B => B(11), Cin => c11, S => S(11), Cout => c12);
    FA13: Full_Adder port map ( A=> A(12), B => B(12), Cin => c12, S => S(12), Cout => c13);
    FA14: Full_Adder port map ( A=> A(13), B => B(13), Cin => c13, S => S(13), Cout => c14);
    FA15: Full_Adder port map ( A=> A(14), B => B(14), Cin => c14, S => S(14), Cout => c15);
    FA16: Full_Adder port map ( A=> A(15), B => B(15), Cin => c15, S => S(15), Cout => c16);
    FA17: Full_Adder port map ( A=> A(16), B => B(16), Cin => c16, S => S(16), Cout => c17);
    FA18: Full_Adder port map ( A=> A(17), B => B(17), Cin => c17, S => S(17), Cout => c18);
    FA19: Full_Adder port map ( A=> A(18), B => B(18), Cin => c18, S => S(18), Cout => c19);
    FA20: Full_Adder port map ( A=> A(19), B => B(19), Cin => c19, S => S(19), Cout => c20);
    FA21: Full_Adder port map ( A=> A(20), B => B(20), Cin => c20, S => S(20), Cout => c21);
    FA22: Full_Adder port map ( A=> A(21), B => B(21), Cin => c21, S => S(21), Cout => c22);
    FA23: Full_Adder port map ( A=> A(22), B => B(22), Cin => c22, S => S(22), Cout => c23);
    FA24: Full_Adder port map ( A=> A(23), B => B(23), Cin => c23, S => S(23), Cout => c24);
    FA25: Full_Adder port map ( A=> A(24), B => B(24), Cin => c24, S => S(24), Cout => c25);
    FA26: Full_Adder port map ( A=> A(25), B => B(25), Cin => c25, S => S(25), Cout => c26);
    FA27: Full_Adder port map ( A=> A(26), B => B(26), Cin => c26, S => S(26), Cout => Cout);

end Behavioral;
