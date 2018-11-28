----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/07/2018 05:29:09 PM
-- Design Name:
-- Module Name: blinky - Behavioral
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity blinky is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC);
end blinky;

architecture Behavioral of blinky is
    signal count : STD_LOGIC_VECTOR(24 downto 0);

begin
    process(clk)
    begin
    if rising_edge(clk) then
        count <= (count + '1');
    end if;
 end process;

 led <= count(24);
end Behavioral;
