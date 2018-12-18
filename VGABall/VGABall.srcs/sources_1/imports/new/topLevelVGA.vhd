----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 12/08/2018 12:42:29 PM
-- Design Name:
-- Module Name: topLevelVGA - Behavioral
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

entity topLevelVGA is
  Port (
    clk100 : in STD_LOGIC;
    redOut, blueOut, greenOut : out std_logic_vector(3 downto 0);
    vsync, hsync : out STD_LOGIC
  );
end topLevelVGA;

architecture Behavioral of topLevelVGA is
    component clk_wiz_0 is
        port(
            clk100 : in STD_LOGIC;
            clk25 : out STD_LOGIC
        );
    end component;

    signal clk25 : STD_LOGIC;
    signal red, blue, green : std_logic_vector(3 downto 0);
    signal nextX, nextY : std_logic_vector(9 downto 0);

begin

    clk_divider : clk_wiz_0 port map(
        clk100 => clk100,
        clk25 => clk25
    );

    vga_controller : entity work.VGA(Behavioral)
    port map(
        clk25 => clk25,
        redIn => red,
        blueIn => blue,
        greenIn => green,
        redOut => redOut,
        greenOut => greenOut,
        blueOut => blueOut,
        nextX => nextX,
        nextY => nextY,
        hsync => hsync,
        vsync => vsync
    );

    circle_sprite : entity work.circle(Behavioral)
    port map(
        clk25 => clk25,
        x => nextX,
        y => nextY,
        red => red,
        green => green,
        blue => blue
    );

end Behavioral;








--
