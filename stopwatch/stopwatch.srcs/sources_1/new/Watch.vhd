----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 12/01/2018 04:09:31 PM
-- Design Name:
-- Module Name: Watch - Behavioral
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

entity Watch is
 Port (
    clk : in STD_LOGIC;
    sysReset : in STD_LOGIC;
    watchRunning : in STD_LOGIC;
    watchReset : in STD_LOGIC;
    mins : out STD_LOGIC_VECTOR (5 downto 0);
    secs : out STD_LOGIC_VECTOR (5 downto 0));
end Watch;

architecture Behavioral of Watch is
    constant prescaler : unsigned(26 downto 0) := "101111101011110000100000000";
    --constant prescaler : unsigned(26 downto 0) := "000000011001011011100110101";
    --constant prescaler : unsigned(26 downto 0) := "000000000000000000000010000";
    constant limit : unsigned(5 downto 0) := "111011";

    signal divisionCounter : unsigned(26 downto 0) := (others => '0');
    signal minuteCounter, secondCounter : unsigned(5 downto 0) := (others => '0');
begin

    mins <= std_logic_vector(minuteCounter);
    secs <= std_logic_vector(secondCounter);

    divisionCounter_process : process(clk, sysReset)
    begin
        if sysReset = '1' then
            divisionCounter <= (others => '0');
        elsif rising_edge(clk) then
            if watchReset = '1' then
                divisionCounter <= (others => '0');
            elsif watchRunning = '1' then
                if divisionCounter /= prescaler then
                    divisionCounter <= divisionCounter + 1;
                else
                    divisionCounter <= (others => '0');
                end if;
            end if;
        end if;
    end process;

    second_counter : process(clk, sysReset)
    begin
        if sysReset = '1' then
            secondCounter <= (others => '0');
        elsif rising_edge(clk) then
            if watchReset = '1' then
                secondCounter <= (others => '0');
            elsif watchRunning = '1' then
                if prescaler = divisionCounter then
                    if secondCounter /= limit then
                        secondCounter <= secondCounter + 1;
                    else
                        secondCounter <= (others => '0');
                    end if;
                end if;
            end if;
        end if;
    end process;

    minute_counter : process(clk, sysReset)
    begin
        if sysReset = '1' then
            minuteCounter <= (others => '0');
        elsif rising_edge(clk) then
            if watchReset = '1' then
                minuteCounter <= (others => '0');
            elsif watchRunning = '1' then
                if prescaler = divisionCounter then
                    if secondCounter = limit  and minuteCounter /= limit then
                        minuteCounter <= minuteCounter + 1;
                    elsif minuteCounter = limit then
                        minuteCounter <= (others => '0');
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;












--
