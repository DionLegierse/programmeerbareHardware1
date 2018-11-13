----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2018 03:02:08 PM
-- Design Name: 
-- Module Name: segmentMux - Behavioral
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

entity segmentMux is
    Port ( clk : in STD_LOGIC;
           BCDBus : in STD_LOGIC_VECTOR (7 downto 0);
           BCD : out STD_LOGIC_VECTOR (3 downto 0);
           segmentSelect : out STD_LOGIC_VECTOR (1 downto 0));
end segmentMux;

architecture Behavioral of segmentMux is

begin
    process(clk)
        variable counter : integer range 0 to 1000000;
    begin
        if rising_edge(clk) then

            case( counter ) is
                when 1 =>
                    segmentSelect <= "10";
                when 450000 =>
                    BCD <= BCDBus(7 downto 4);
                    segmentSelect <= "11";
                when 500000 =>
                    segmentSelect <= "01";
                when 950000 =>
                    BCD <= BCDBus(3 downto 0);
                    segmentSelect <= "11";
                when 1000000 =>
                    counter := 0;    
                when others =>
                    NULL;
            end case ;

            counter := counter + 1;
        end if;
    end process;
end Behavioral;
