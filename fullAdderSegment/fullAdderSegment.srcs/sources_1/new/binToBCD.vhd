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
    Port ( 
        bin : in STD_LOGIC_VECTOR (7 downto 0);
        ones : out STD_LOGIC_VECTOR(3 downto 0);
        tens : out STD_LOGIC_VECTOR(3 downto 0);
        hundreds : out STD_LOGIC_VECTOR(3 downto 0)
    );
end binToBCD;

architecture Behavioral of binToBCD is
begin
    process( bin )
        variable i : integer;
        variable binary_shift : STD_LOGIC_VECTOR(19 downto 0);
    begin
        --initialization
        binary_shift(19 downto 8) := (others => '0');
        binary_shift(7 downto 0) := bin;

        for i in 0 to 7 loop
            --addition if over column over or equal to 5
            if(binary_shift(11 downto 8) >= "0101") then
                binary_shift(11 downto 8) := binary_shift(11 downto 8) + "0011";
            end if;

            if(binary_shift(15 downto 12) >= "0101") then
                binary_shift(15 downto 12) := binary_shift(15 downto 12) + "0011";
            end if;
            
            if(binary_shift(19 downto 16) >= "0101") then
                binary_shift(19 downto 16) := binary_shift(19 downto 16) + "0011";
            end if;

            --shifting everyting
            binary_shift := binary_shift(18 downto 0) & '0';
        end loop;
        
        ones <= binary_shift(11 downto 8);
        tens <= binary_shift(15 downto 12);
        hundreds <= binary_shift(19 downto 16);
    end process ;

end architecture;
