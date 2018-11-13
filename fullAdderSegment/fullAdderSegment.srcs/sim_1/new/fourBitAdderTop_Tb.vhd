----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2018 06:40:30 PM
-- Design Name: 
-- Module Name: fourBitAdderTop_Tb - Behavioral
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

entity fourBitAdderTop_Tb is
--  Port ( );
end fourBitAdderTop_Tb;

architecture Bench of fourBitAdderTop_Tb is
    signal A,B : STD_LOGIC_VECTOR(3 downto 0);
    signal segment : STD_LOGIC_VECTOR(6 downto 0);
    signal segmentSelect : STD_LOGIC_VECTOR(1 downto 0);
    signal clk : STD_LOGIC;
begin
    dut : entity work.fourBitAdderTop(Behavioral) port map(
        A => A,
        B => B,
        clk => clk,
        segment => segment,
        segmentSelect => segmentSelect
    );

end Bench;
