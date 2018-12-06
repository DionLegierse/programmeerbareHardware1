----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 12/01/2018 06:53:03 PM
-- Design Name:
-- Module Name: binToTimeBcd - Behavioral
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

entity binToTimeBcd is
  Port (
    clk : in std_logic;
    seconds : in std_logic_vector(5 downto 0);
    minutes : in std_logic_vector(5 downto 0);
    segmentBCD : out std_logic_vector(3 downto 0);
    segmentSelect : out std_logic_vector(3 downto 0)
  );
end binToTimeBcd;

architecture Behavioral of binToTimeBcd is
    subtype segmentElement is unsigned(3 downto 0);
    type segmentName is (secondSingles, secondTens, minuteSingles, minutesTens);
    type segmentArray is array (minutesTens downto secondSingles) of segmentElement;
    signal segments : segmentArray;

    --constant prescalar : unsigned(17 downto 0) := "000000000000000001";
    constant prescalar : unsigned(17 downto 0) := "110010110111001101";

    signal counter : unsigned(17 downto 0) := (others => '0');

    signal uMinutes, uSeconds : unsigned(5 downto 0);

    signal currentSegment : segmentName := secondSingles;
    signal segmentSelectRegister : unsigned(3 downto 0) := "1110";

begin

    uMinutes <= unsigned(minutes);
    uSeconds <= unsigned(seconds);
    segmentSelect <= std_logic_vector(segmentSelectRegister);
    segmentBCD <= std_logic_vector(segments(currentSegment));

    bcd_conversion : process(clk)
        variable iSeconds, iMinutes : integer range 0 to 60;
    begin
        if rising_edge(clk) then
            iSeconds := to_integer(uSeconds);
            iMinutes := to_integer(uMinutes);

            segments(secondSingles) <= to_unsigned(iSeconds mod 10, segmentElement'length);
            segments(secondTens) <= to_unsigned(iSeconds / 10, segmentElement'length);
            segments(minuteSingles) <= to_unsigned(iMinutes mod 10, segmentElement'length);
            segments(minutesTens) <= to_unsigned(iMinutes / 10, segmentElement'length);
        end if;
    end process;

    mux_counter : process(clk)
    begin
        if rising_edge(clk) then
            if counter = prescalar then
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    mux : process(clk)
    begin
        if rising_edge(clk) then
            if counter = prescalar then
                segmentSelectRegister <= segmentSelectRegister rol 1;

                if currentSegment = segmentName'high then
                    currentSegment <= segmentName'low;
                else
                    currentSegment <= segmentName'succ(currentSegment);
                end if;
            end if;
        end if;
    end process;

end Behavioral;















--
