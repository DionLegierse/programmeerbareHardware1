----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2018 06:33:20 PM
-- Design Name: 
-- Module Name: fourBitAdderTop - Behavioral
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

entity fourBitAdderTop is
  Port ( 
    A : in STD_LOGIC_VECTOR(3 downto 0);
    B : in STD_LOGIC_VECTOR(3 downto 0);
    clk : in STD_LOGIC;
    segment : out STD_LOGIC_VECTOR(6 downto 0);
    segmentSelect : out STD_LOGIC_VECTOR(3 downto 0)
  );
end fourBitAdderTop;

architecture Behavioral of fourBitAdderTop is

signal sum : std_logic_vector(4 downto 0);
signal ones, tens, hundreds, BCD : std_logic_vector(3 downto 0);
signal bin : std_logic_vector(7 downto 0);
signal clk_divided : std_logic;

begin

   bin <= "000" & sum;
   segmentSelect(3) <= '1';
   
   clock_divider1 : entity work.clock_divider(Behavioral)
   port map(
     clk => clk,
     clk_divided => clk_divided
   );


  adder : entity work.fourBitFullAdder(Behavioral) 
  port map(
    A => A,
    B => B,
    Cin => '0',
    Z => sum(3 downto 0),
    Cout => sum(4)
  );

  binToBCDConverter : entity work.binToBCD(Behavioral)
  port map(
    bin => bin,
    ones => ones,
    tens => tens,
    hundreds => hundreds
  );
  
 segmentMux1 : entity work.segmentMux(Behavioral)
 port map(
    clk => clk_divided,
    ones => ones,
    tens => tens,
    hundreds => "0000",
    BCD => BCD,
    segmentSelect => segmentSelect(2 downto 0)
 );
  
  bcdToSeg1 : entity work.bcdToSeg(Behavioral)
  port map(
    segment => segment,
    BCD => BCD
  );
  
end Behavioral;
