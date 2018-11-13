----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2018 01:39:23 PM
-- Design Name: 
-- Module Name: bcdToSeg_Tb - Behavioral
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

entity bcdToSeg_Tb is
--  Port ( );
end bcdToSeg_Tb;

architecture Bench of bcdToSeg_Tb is
    signal BCD : STD_LOGIC_VECTOR(3 downto 0);
    signal segment : STD_LOGIC_VECTOR(6 downto 0);
begin
    dut : entity work.bcdToSeg port map(
        BCD => BCD,
        segment => segment
    );
    
    process
        variable i : integer := 0;
    begin
        
        for i in 0 to 8 loop
            BCD <= conv_std_logic_vector(i,BCD'length);
            wait for 10 ns;
        end loop;
    end process;

end Bench;
