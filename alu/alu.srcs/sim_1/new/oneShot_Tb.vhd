----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2018 02:00:00 PM
-- Design Name: 
-- Module Name: oneShot_Tb - Behavioral
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

entity oneShot_Tb is
--  Port ( );
end oneShot_Tb;

architecture Behavioral of oneShot_Tb is

    --Stimuli of the UUT
    signal inSignal, shot : STD_LOGIC;
    signal clk : STD_LOGIC := '0';


    constant clockDelay : TIME := 5 ps;
    constant offsetDelayInSignal : TIME := 5 ps;
    constant periodDelay : TIME := 2 * clockDelay;

    --Simulation run booleans
    signal isClockOn : boolean := true;
    signal isShotCorrect : boolean := true;

begin

    UUT : entity work.oneShot(Behavioral)
    port map(
        clk => clk,
        inSignal => inSignal,
        shot => shot
    );

    clock : process
    begin
        clk <= '0';
        while isClockOn loop
            clk <= not clk;
            wait for clockDelay;
        end loop;
        wait;
    end process ; -- clock

    stimuli : process
    begin
        inSignal <= '0';
        wait for offsetDelayInSignal;
        wait for periodDelay;

        inSignal <= '1';
        wait for 10 * periodDelay;

        inSignal <= '0';
        wait for 10 * periodDelay;
        wait;
    end process ; -- stimuli

end Behavioral;
