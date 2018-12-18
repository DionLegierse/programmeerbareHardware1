----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 12/18/2018 03:46:05 PM
-- Design Name:
-- Module Name: circle - Behavioral
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

entity circle is
    Port (
        clk25 : in STD_LOGIC;
        x,y : in std_logic_vector(9 downto 0);
        red, blue, green : out std_logic_vector(3 downto 0)
    );
end circle;

architecture Behavioral of circle is
type xmovement is (left, right);
type ymovement is (up, down);

type pixel is array (0 to 2) of std_logic_vector(3 downto 0);
type pixelline is array (0 to 9) of pixel;
type sprite is array (0 to 9) of pixelline;

constant bgBlue : std_logic_vector(3 downto 0) := "1111";
constant bgGreen : std_logic_vector(3 downto 0) := "0000";
constant bgRed : std_logic_vector(3 downto 0) := "0000";

constant circleBlue : std_logic_vector(3 downto 0) := "0000";
constant circleGreen : std_logic_vector(3 downto 0) := "1111";
constant circleRed : std_logic_vector(3 downto 0) := "0000";

constant prescaler : integer := 250000;
constant speed : integer := 1;

constant circle_sprite : sprite :=
(
((bgRed,bgGreen,bgBlue)            ,(bgRed,bgGreen,bgBlue)            ,(bgRed,bgGreen,bgBlue)            ,(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(bgRed,bgGreen,bgBlue)            ,(bgRed,bgGreen,bgBlue)            ,(bgRed,bgGreen,bgBlue)            ),
((bgRed,bgGreen,bgBlue)            ,(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(bgRed,bgGreen,bgBlue)            ),
((bgRed,bgGreen,bgBlue)            ,(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(bgRed,bgGreen,bgBlue)            ),
((circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue)),
((circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue)),
((circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue)),
((circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue)),
((bgRed,bgGreen,bgBlue)            ,(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(bgRed,bgGreen,bgBlue)            ),
((bgRed,bgGreen,bgBlue)            ,(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(bgRed,bgGreen,bgBlue)            ),
((bgRed,bgGreen,bgBlue)            ,(bgRed,bgGreen,bgBlue)            ,(bgRed,bgGreen,bgBlue)            ,(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(circleRed,circleGreen,circleBlue),(bgRed,bgGreen,bgBlue)            ,(bgRed,bgGreen,bgBlue)            ,(bgRed,bgGreen,bgBlue)            )
);

signal circleX, circleY : unsigned(9 downto 0) := to_unsigned(200, 10);

signal counter : natural range 0 to prescaler + 1 := 0;

signal xstate : xmovement := right;
signal ystate : ymovement := down;

begin
move_sprite : process(clk25)
begin
    if rising_edge(clk25) then
        if unsigned(y) = 480 and unsigned(x) = 640 then
            if xstate = left then
                if circleX = 0 then
                    xstate <= right;
                    circleX <= circleX + speed;
                else
                    circleX <= circleX - speed;
                end if;
            elsif xstate = right then
                if circleX = 630 then
                    xstate <= left;
                    circleX <= circleX - speed;
                else
                    circleX <= circleX + speed;
                end if;
            end if;

            if ystate = up then
                if circleY = 0 then
                    ystate <= down;
                    circleY <= circleY + speed;
                else
                    circleY <= circleY - speed;
                end if;
            elsif ystate = down then
                if circleY = 470 then
                    ystate <= up;
                    circleY <= circleY - speed;
                else
                    circleY <= circleY + speed;
                end if;
            end if;
        end if;
    end if;
end process;

render_sprite : process(clk25)
begin
    if rising_edge(clk25) then
        if unsigned(x) >= circleX and unsigned(x) <= circleX + 9 and unsigned(y) >= circleY and unsigned(y) <= circleY + 9 then
            red <= circle_sprite(to_integer(unsigned(x) - circleX))(to_integer(unsigned(y)-circleY))(0);
            green <= circle_sprite(to_integer(unsigned(x) - circleX))(to_integer(unsigned(y)-circleY))(1);
            blue <= circle_sprite(to_integer(unsigned(x) - circleX))(to_integer(unsigned(y)-circleY))(2);
        else
            red <= bgRed;
            green <=bgGreen;
            blue <= bgBlue;
        end if;
    end if;
end process;

end Behavioral;
















--
