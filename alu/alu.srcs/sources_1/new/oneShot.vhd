----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/24/2018 01:41:03 PM
-- Design Name:
-- Module Name: oneShot - Behavioral
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

entity oneShot is
    Port ( clk : in STD_LOGIC;
           inSignal : in STD_LOGIC;
           shot : out STD_LOGIC);
end oneShot;

architecture Behavioral of oneShot is

    type state_type is (S0, S1, S2);
    signal NS, PS : state_type := S0;

begin

    Next_state_encoder : process( PS, inSignal )
    begin
        case( PS ) is

            when S0 =>
                if inSignal = '0' then
                    NS <= S0;
                elsif inSignal = '1' then
                    NS <= S1;
                end if;
            when S1 =>
                    NS <= S2;
            when S2 =>
                if inSignal = '0' then
                    NS <= S0;
                elsif inSignal = '1' then
                    NS <= S2;
                end if;
            when others => NS <= S0;

        end case ;
    end process ; -- Next_state_encoder

    memory : process( clk )
    begin
        if rising_edge(clk) then
            PS <= NS;
        end if;
    end process ; -- memory

    Previous_state_decoder : process( PS )
    begin
        case( PS ) is
            when S0 => shot <= '0';
            when S1 => shot <= '1';
            when S2 => shot <= '0';
            when others => shot <= '0';
        end case ;
    end process ; -- Previous_state_decoder


end Behavioral;
