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
           ones : in std_logic_vector(3 downto 0);
           tens : in std_logic_vector(3 downto 0);
           hundreds : in std_logic_vector(3 downto 0);
           minus : in STD_LOGIC;
           BCD : out STD_LOGIC_VECTOR (3 downto 0);
           segmentSelect : out STD_LOGIC_VECTOR (3 downto 0));
end segmentMux;

architecture Behavioral of segmentMux is

begin
    process(clk)
        variable counter : integer range 0 to 40 := 0;
    begin
        if rising_edge(clk) then

            case( counter ) is
                when 1 =>
                    segmentSelect <= (others => '1');
                    BCD <= ones;
                when 2 =>
                    segmentSelect <= "1110";
                when 11 =>
                    segmentSelect <= (others => '1');
                    BCD <= tens;
                when 12 =>
                    segmentSelect <= "1101";
                when 21 =>
                    segmentSelect <= (others => '1');
                    BCD <= hundreds;
                when 22 =>
                    segmentSelect <= "1011";
                when 31 =>
                    segmentSelect <= (others => '1');
                    if minus = '1' then
                        BCD <= (others => '1');
                    else
                        BCD <= "1110";
                    end if;
                when 32 =>
                    segmentSelect <= "0111";
                when others => NULL;
            end case ;

            counter := counter + 1;
        end if;
    end process;
end Behavioral;
