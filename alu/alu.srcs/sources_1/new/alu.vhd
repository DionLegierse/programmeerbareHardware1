----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/19/2018 08:12:25 PM
-- Design Name:
-- Module Name: alu - Behavioral
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

entity alu is
 Port (
     A,B : in STD_LOGIC_VECTOR(7 downto 0);
     Op : in STD_LOGIC_VECTOR(3 downto 0);
     Res : out STD_LOGIC_VECTOR(7 downto 0);
     Cout : out STD_LOGIC;
     Equal : out STD_LOGIC
 );
end alu;

architecture Behavioral of alu is

begin

    aluProcess : process(A,B,Op)
        variable result,At,Bt : SIGNED(8 downto 0);
    begin
        At := resize(SIGNED(A), 9);
        Bt := resize(SIGNED(B), 9);
        
        case Op is
            --addition
            when "0000" =>
                result := At + Bt;
            --ABsubtraction
            when "0001" =>
                result := At - Bt;
            --BAsubtraction
            when "0010" =>
                result := Bt - At;
            --onlyA
            when "0100" =>
                result := At;
            --onlyB
            when "0101" =>
                result := Bt;
            --minA
            when "0110" =>
                result := 0 - At;
            --minB
            when "0111" =>
                result := 0 - Bt;
            --shiftLeftA
            when "1000" =>
                result := At(7 downto 0) & '0';
            --shiftRightA
            when "1001" =>
                result := "00" & At(7 downto 1);
            --RotateLeftA
            when "1010" =>
                result := At(7) & At(6 downto 0) & A(7);
            --RotateRightA
            when "1011" =>
                result := '0' & At(0) & At(7 downto 1);
            --all 0
            when "1110" =>
                result := (others => '0');
            --all 1
            when "1111" =>
                result := (others => '1');
            --others
            when others =>
                result := (others => '0');
            end case;

            Res <= STD_LOGIC_VECTOR(result(7 downto 0));
            Cout <= STD_LOGIC(result(8));
    end process;

    equalProcess : process(A,B)

    begin
        if (A = B) then
            Equal <= '1';
        else
            Equal <= '0';
        end if;
    end process;

end Behavioral;
