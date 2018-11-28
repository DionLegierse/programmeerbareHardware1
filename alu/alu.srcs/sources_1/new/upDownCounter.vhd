----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/25/2018 05:07:42 PM
-- Design Name:
-- Module Name: upDownCounter - Behavioral
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

entity upDownCounter is
    Port ( clk : in STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC;
           countOut : out STD_LOGIC_VECTOR (3 downto 0));
end upDownCounter;

architecture Behavioral of upDownCounter is

begin

counter : process(clk)
    variable counter : unsigned(3 downto 0) := (others => '0');
begin
    if rising_edge(clk) then
        if up = '1' and  down = '0' and counter /= 15 then
            counter := counter + 1;
        elsif up = '0' and down = '1' and counter /= 0 then
            counter := counter - 1;
        else
            NULL;
        end if;

        countOut <= STD_LOGIC_VECTOR(counter);
    end if;
end process;

end Behavioral;
