----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/28/2018 06:03:31 PM
-- Design Name:
-- Module Name: binToBVD_Tb - Behavioral
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

entity binToBVD_Tb is
--  Port ( );
end binToBVD_Tb;

architecture Behavioral of binToBVD_Tb is

    constant CLK_DELAY : time := 5 ns;
    constant STD_DELAY : time := 10 ns;
    constant EXP_OFFSET : time := 5 ns;

    signal bin : std_logic_vector(7 downto 0) := (others => '0');
    signal Cout : std_logic := '0';

    signal ones, tens, hundreds : std_logic_vector(3 downto 0);

    signal ones_exp, tens_exp, hundreds_exp : std_logic_vector(3 downto 0) := (others => '0');

    signal is_ones_correct, is_tens_correct, is_hundreds_correct : BOOLEAN := TRUE;
begin

    uut : entity work.binToBCD(Behavioral)
        port map(
            bin => bin,
            ones => ones,
            tens => tens,
            hundreds => hundreds,
            Cout => Cout
        );

    stimuli_simulator : process
    begin
        for i in 0 to 255 loop
            wait for STD_DELAY;
            bin <= std_logic_vector(signed(bin) + 1);
        end loop;

        bin <= (others => '0');
        wait for STD_DELAY * 2;

        Cout <= '1';
        bin <= "00000001";

        for i in 0 to 255 loop
            wait for STD_DELAY;
            bin <= std_logic_vector(signed(bin) + 1);
        end loop;

    wait;
    end process;

    expectations : process
    begin
        wait for EXP_OFFSET;
        for i in 0 to 255 loop
            if ones /= ones_exp then
                is_ones_correct <= false;
            end if;

            if tens /= tens_exp then
                is_tens_correct <= false;
            end if;

            if hundreds /= hundreds_exp then
                is_tens_correct <= false;
            end if;

            if ones_exp /= "1001" then
                ones_exp <= std_logic_vector(signed(ones_exp) + 1);
            else
                ones_exp <= (others => '0');

                if tens_exp /= "1001" then
                    tens_exp <= std_logic_vector(signed(tens_exp) + 1);
                else
                    tens_exp <= (others => '0');
                    hundreds_exp <= std_logic_vector(signed(hundreds_exp) + 1);
                end if;
            end if;
            wait for STD_DELAY;
        end loop;

        ones_exp <= (others => '0');
        tens_exp <= (others => '0');
        hundreds_exp <= (others => '0');

        wait for STD_DELAY;

        if (ones /= ones_exp) then
            is_ones_correct <= false;
        end if;

        if (tens /= tens_exp) then
            is_tens_correct <= false;
        end if;

        if (hundreds /= hundreds_exp) then
            is_hundreds_correct <= false;
        end if;

        ones_exp <= "0101";
        tens_exp <= "0101";
        hundreds_exp <= "0010";

        wait for STD_DELAY;

        for i in 0 to 255 loop
            if ones /= ones_exp then
                is_ones_correct <= false;
            end if;

            if tens /= tens_exp then
                is_tens_correct <= false;
            end if;

            if hundreds /= hundreds_exp then
                is_hundreds_correct <= false;
            end if;

            if ones_exp /= "0000" then
                ones_exp <= std_logic_vector(signed(ones_exp) - 1);
            else
                ones_exp <= "1001";

                if tens_exp /= "0000" then
                    tens_exp <= std_logic_vector(signed(tens_exp) - 1);
                else
                    tens_exp <= "1001";
                    hundreds_exp <= std_logic_vector(signed(hundreds_exp) - 1);
                end if;
            end if;
            wait for STD_DELAY;
        end loop;

        wait;
    end process;

end Behavioral;














--
