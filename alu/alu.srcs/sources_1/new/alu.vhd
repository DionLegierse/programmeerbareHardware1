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
        variable result : SIGNED(8 downto 0);
    begin
        case Op is
            --addition
            when "0000" =>
                result := ('0' & SIGNED(A)) + ('0' & SIGNED(B));
            --ABsubtraction
            when "0001" =>
                result := ('0' & SIGNED(A)) - ('0' & SIGNED(B));
            --BAsubtraction
            when "0010" =>
                result := ('0' & SIGNED(B)) - ('0' & SIGNED(A));
            --onlyA
            when "0100" =>
                result := SIGNED(A(7) & A);
            --onlyB
            when "0101" =>
                result := SIGNED(B(7) & B);
            --minA
            when "0110" =>
                result := (not (A(7) & SIGNED(A))) + 1;
            --minB
            when "0111" =>
                result := (not (B(7) & SIGNED(B))) + 1;
            --shiftLeftA
            when "1000" =>
                result := SIGNED(A & '0');
            --shiftRightA
            when "1001" =>
                result := SIGNED("00" & A(7 downto 1));
            --RotateLeftA
            when "1010" =>
                result := SIGNED(A & A(7));
            --RotateRightA
            when "1011" =>
                result := SIGNED('0' & A(0) & A(7 downto 1));
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
