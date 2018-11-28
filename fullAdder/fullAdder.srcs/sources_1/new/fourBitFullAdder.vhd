----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/07/2018 11:42:00 PM
-- Design Name:
-- Module Name: fourBitFullAdder - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fourBitFullAdder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Z : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end fourBitFullAdder;

architecture Behavioral of fourBitFullAdder is

    component fullAdder is
        Port(
            A : in std_logic;
            B : in std_logic;
            Cin : in std_logic;
            Z : out std_logic;
            Cout : out std_logic
        );
    end component;

    signal C0, C1, C2 : std_logic;
    
begin
    adder0 : fullAdder Port map(
        A => A(0),
        B => B(0),
        Cin => '0',
        Z => Z(0),
        Cout =>  C0
    );

    adder1 : fullAdder Port map(
        A => A(1),
        B => B(1),
        Cin => C0,
        Z => Z(1),
        Cout =>  C1
    );

    adder2 : fullAdder Port map(
        A => A(2),
        B => B(2),
        Cin => C1,
        Z => Z(2),
        Cout =>  C2
    );

    adder3 : fullAdder Port map(
        A => A(3),
        B => B(3),
        Cin => C2,
        Z => Z(3),
        Cout => Cout
    );

end Behavioral;
