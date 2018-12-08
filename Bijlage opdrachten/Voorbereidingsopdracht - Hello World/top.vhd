----------------------------------------------------------------------------------
-- Company: Avans
-- Engineer: J. v.d. Heuvel
-- 
-- Create Date: 01/20/2017 12:12:34 PM
-- Design Name: 
-- Module Name: top - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC);
end top;

architecture Behavioral of top is
signal count: STD_LOGIC_VECTOR(24 downto 0);

begin
    process(clk)
    begin
        if rising_edge(clk) then
            count <= (count + 1);
        end if; 
    end process;

led <= count(24);
        
    

end Behavioral;
