----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2018 12:01:11 PM
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
use IEEE.STD_LOGIC_ARITH.ALL;

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

architecture Bench of binToBVD_Tb is

    signal bin : STD_LOGIC_VECTOR(7 downto 0);
    signal ones, tens, hundreds : STD_LOGIC_VECTOR(3 downto 0);

begin
    dut : entity work.binToBCD(Behavioral)
    port map(
        bin => bin,
        ones => ones,
        tens => tens,
        hundreds => hundreds
    );
    
    process
    variable i : integer := 0;
    begin
        for i in 0 to 255 loop
            bin <= conv_std_logic_vector(i, bin'length);
            wait for 10 ns;
        end loop;
        
    wait;
    end process;

end Bench;
