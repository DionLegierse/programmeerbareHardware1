----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 12/01/2018 03:25:27 PM
-- Design Name:
-- Module Name: FSM_controller - Behavioral
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

entity FSM_controller is
  port(
    clk : in std_logic;
    sysReset : in std_logic;
    buttons : in std_logic_vector(1 downto 0);
    watchRunning : out std_logic;
    watchReset : out std_logic
  );
end FSM_controller;

architecture Behavioral of FSM_controller is
    type states is (pause, reset, run);
    signal next_state, previous_state : states := pause;
begin

    next_state_encoder : process(previous_state, buttons)
    begin
        case( previous_state ) is
            when pause =>
                if buttons(0) = '1' then
                    next_state <= reset;
                elsif buttons(1) = '1' then
                    next_state <= run;
                else
                    next_state <= pause;
                end if;
            when reset =>
                next_state <= pause;
            when run =>
                if buttons(1) = '1' then
                    next_state <= pause;
                else
                    next_state <= run;
                end if;
            when others =>
                next_state <= reset;
        end case;
    end process;

    memory : process(clk, sysReset)
    begin
        if sysReset = '1' then
            previous_state <= pause;
        elsif rising_edge(clk) then
            previous_state <= next_state;
        end if;
    end process;

    previous_state_decoder : process(previous_state)
    begin
        watchRunning <= '0';
        watchReset <= '0';

        case( previous_state ) is
            when run =>
                watchRunning <= '1';
            when reset=>
                watchReset <= '1';
            when others =>
                NULL;
        end case;
    end process;

end Behavioral;
















--
