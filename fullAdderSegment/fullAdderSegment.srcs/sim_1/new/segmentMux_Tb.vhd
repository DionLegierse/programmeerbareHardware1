----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2018 03:26:45 PM
-- Design Name: 
-- Module Name: segmentMux_Tb - Behavioral
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

entity segmentMux_Tb is
--  Port ( );
end segmentMux_Tb;

architecture Bench of segmentMux_Tb is
    --Inputs
    signal clk : STD_LOGIC;
    signal BCDBus : STD_LOGIC_VECTOR (7 downto 0);
    --Outputs
    signal BCD : STD_LOGIC_VECTOR (3 downto 0);
    signal segmentSelect : STD_LOGIC_VECTOR (1 downto 0);
begin

    dut : entity work.segmentMux(Behavioral) Port map(
        clk => clk,
        BCDBus => BCDBus,
        BCD => BCD,
        segmentSelect => segmentSelect
    );

    process

    begin

    end process;

end Bench;
