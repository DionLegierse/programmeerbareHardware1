----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 12/08/2018 11:35:45 AM
-- Design Name:
-- Module Name: square - Behavioral
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

entity square is
    Port (
        clk25 : in STD_LOGIC;
        x,y : in std_logic_vector(9 downto 0);
        red, blue, green : out std_logic_vector(3 downto 0)
    );
end square;

architecture Behavioral of square is
    type xMovement is (left, right);
    type yMovement is (up, down);

    constant startingX : natural := 5;
    constant startingY : natural := 5;

    constant xCounterMin : natural := 5;
    constant xCounterMax : natural := 635;
    constant yCounterMin : natural := 5;
    constant yCounterMax : natural := 475;

    --constant xPrescaler : natural := 250000;
    --constant yPrescaler : natural := 250000;

    constant xPrescaler : natural := 100000;
    constant yPrescaler : natural := 100000;


    signal xMoveCounter : natural range 0 to 1000000;
    signal yMoveCounter : natural range 0 to 1000000;

    signal xState : xMovement := left;
    signal yState : yMovement := up;

    signal xCounter : natural range 0 to 640 := startingX;
    signal yCounter : natural range 0 to 480 := startingY;

    signal xi, yi : natural range 0 to 640;

begin

    xi <= to_integer(unsigned(x));
    yi <= to_integer(unsigned(y));

    square_sprite : process(clk25)
    begin
        if rising_edge(clk25) then
            if xi >= xCounter - 5 and xi <= xCounter + 5 and yi >= yCounter - 5 and yi <= yCounter + 5 then
                red <= (others => '0');
                blue <= (others => '0');
                green <= (others => '1');
            else
                red <= (others => '0');
                blue <= (others => '1');
                green <= (others => '0');
            end if;
        end if;
    end process;

    prescaler_counter : process(clk25)
    begin
        if rising_edge(clk25) then
            if xMoveCounter >= xPrescaler then
                xMoveCounter <= 0;
            else
                xMoveCounter <= xMoveCounter + 1;
            end if;

            if yMoveCounter >= yPrescaler then
                yMoveCounter <= 0;
            else
                yMoveCounter <= yMoveCounter + 1;
            end if;
        end if;
    end process;

    x_movement : process(clk25)
    begin
        if rising_edge(clk25) then
            if xMoveCounter >= xPrescaler and xState = right then
                if xCounter /= xCounterMax then
                    xCounter <= xCounter + 1;
                else
                    xState <= left;
                end if;
            elsif xMoveCounter >= xPrescaler and xState = left then
                if xCounter /= xCounterMin then
                    xCounter <= xCounter - 1;
                else
                    xState <= right;
                end if;
            end if;
        end if;
    end process;

    y_movement : process(clk25)
    begin
        if rising_edge(clk25) then
            if yMoveCounter >= yPrescaler and yState = down then
                if yCounter /= yCounterMax then
                    yCounter <= yCounter + 1;
                else
                    yState <= up;
                end if;
            elsif yMoveCounter >= yPrescaler and yState = up then
                if yCounter /= yCounterMin then
                    yCounter <= yCounter - 1;
                else
                    yState <= down;
                end if;
            end if;
        end if;
    end process;
end Behavioral;











--
