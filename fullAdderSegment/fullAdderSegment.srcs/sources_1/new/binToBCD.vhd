----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2018 10:38:51
-- Design Name: 
-- Module Name: binToBCD - Behavioral
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

entity binToBCD is
    Port ( bin : in STD_LOGIC_VECTOR (3 downto 0);
           BCD : out STD_LOGIC_VECTOR (4 downto 0));
end binToBCD;

architecture Behavioral of binToBCD is

signal counter : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');

begin

    process( bin )
        variable test : STD_LOGIC_VECTOR(5 downto 0) := '0';
    begin
        test := (others => '0');
        while () loop

        end loop;
    end process ;

end architecture;
