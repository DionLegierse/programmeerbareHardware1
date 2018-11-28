----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/10/2018 06:39:02 PM
-- Design Name:
-- Module Name: bcdToSeg - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcdToSeg is
  Port (
    BCD : in STD_LOGIC_VECTOR(3 downto 0);
    segment : out STD_LOGIC_VECTOR(6 downto 0)
  );
end bcdToSeg;

architecture Behavioral of bcdToSeg is

begin
  --GFEDCBA
  with BCD select segment <=
  "1000000" when "0000",
  "1111001" when "0001",
  "0100100" when "0010",
  "0110000" when "0011",
  "0011001" when "0100",
  "0010010" when "0101",
  "0000010" when "0110",
  "1111000" when "0111",
  "0000000" when "1000",
  "0010000" when "1001",
  "0111111" when "1111",
  "1111111" when "1110", 
  (others => '1') when others;
end Behavioral;