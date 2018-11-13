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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity binToBCD is
    Port ( bin : in STD_LOGIC_VECTOR (4 downto 0);
           BCD : out STD_LOGIC_VECTOR(7 downto 0)
           );
end binToBCD;

architecture Behavioral of binToBCD is
begin
    process( bin )
        variable i : integer;
        variable binary_shift : STD_LOGIC_VECTOR(12 downto 0);
    begin
        --initialization
        binary_shift := (4 => bin(4), 3 => bin(3), 2 => bin(2), 1 => bin(1), 0 => bin(0), others=> '0');

        for i in 0 to 4 loop
            --addition if over column over or equal to 5
            if(binary_shift(8 downto 5) >= "0101") then
                binary_shift(8 downto 5) := binary_shift(8 downto 5) + "0011";
            end if;

            if(binary_shift(12 downto 9) >= "0101") then
                binary_shift(12 downto 9) := binary_shift(12 downto 9) + "0011";
            end if;

            --shifting everyting

            binary_shift := binary_shift(11 downto 0) & '0';
        end loop;
        
        BCD <= binary_shift(12 downto 5);
    end process ;

end architecture;
