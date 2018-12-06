----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 12/01/2018 08:43:26 PM
-- Design Name:
-- Module Name: stopWatchTop - Behavioral
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

entity stopWatchTop is
  Port (
    buttons : in std_logic_vector(1 downto 0);
    clk : in std_logic;
    sysReset : in std_logic;
    segment : out std_logic_vector(6 downto 0);
    segmentSelect : out std_logic_vector(3 downto 0)
  );
end stopWatchTop;

architecture Behavioral of stopWatchTop is
    signal watchRunning, watchReset : std_logic;
    signal minutes, seconds : std_logic_vector(5 downto 0);
    signal buttonsBuffer : std_logic_vector(1 downto 0);
    signal segmentBCD : std_logic_vector(3 downto 0);

begin
    oneshotPause : entity work.oneShot(Behavioral)
    port map(
        clk => clk,
        inSignal => buttons(1),
        shot => buttonsBuffer(1)
    );

    oneshotReset : entity work.oneShot(Behavioral)
    port map(
        clk => clk,
        inSignal => buttons(0),
        shot => buttonsBuffer(0)
    );

    controller : entity work.FSM_controller(Behavioral)
    port map(
        clk => clk,
        sysReset => sysReset,
        buttons => buttonsBuffer,
        watchRunning => watchRunning,
        watchReset => watchReset
    );

    watch1 : entity work.watch(Behavioral)
    port map(
        clk => clk,
        sysReset => sysReset,
        watchRunning => watchRunning,
        watchReset => watchReset,
        mins => minutes,
        secs => seconds
    );

    binToTimeBcd1 : entity work.binToTimeBcd(Behavioral)
    port map(
        clk => clk,
        seconds => seconds,
        minutes => minutes,
        segmentBCD => segmentBCD,
        segmentSelect => segmentSelect
    );

    bcdToSeg1 : entity work.bcdToSeg(Behavioral)
    port map(
        BCD => segmentBCD,
        segment => segment
    );

end Behavioral;









--
