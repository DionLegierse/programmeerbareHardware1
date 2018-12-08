----------------------------------------------------------------------------------
-- Company:        Avans
-- Engineer:       J.vd.Heuvel
--
-- Create Date:    14:13:20 04/11/2009
-- Module Name:    VGA - Behavioral
-- Target Devices: Xilinx Artix 7
-- Description:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VGA is
    Port (
      clk25 : in STD_LOGIC;
			redIn, greenIn, blueIn : in  std_logic_vector(3 downto 0);
			redOut, greenOut, blueOut : out  std_logic_vector(3 downto 0);
      x,y : out std_logic_vector(9 downto 0);
			hsync, vsync : out  STD_LOGIC
    );
end VGA;

architecture Behavioral of VGA is
  signal hcount: STD_LOGIC_VECTOR(9 downto 0);
  signal vcount: STD_LOGIC_VECTOR(9 downto 0);
begin

  process (clk25)
  begin
    if rising_edge(clk25) then
      if (hcount >= 144) and (hcount < 784) and (vcount >= 31) and (vcount < 511) then
        --visble area
        x <= hcount - 145;
        y <= vcount - 32;

        redOut <= redIn;
        greenOut <= greenIn;
        blueOut <= blueOut;
      else
        --invisible area
        redOut <= (others => '0');
        greenOut <= (others => '0');
        blueOut <= (others => '0');
      end if;

      --h-sync pulse
      if hcount < 97 then
        hsync <= '0';
      else
        hsync <= '1';
      end if;

      --v-sync pulse
      if vcount < 3 then
        vsync <= '0';
      else
        vsync <= '1';
      end if;

      hcount <= hcount + 1;

      if hcount = 800 then
        vcount <= vcount + 1;
        hcount <= (others => '0');
      end if;

      if vcount = 521 then
        vcount <= (others => '0');
      end if;
    end if;
  end process;

end Behavioral;
