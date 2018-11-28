----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/25/2018 05:31:28 PM
-- Design Name:
-- Module Name: aluBoardTest - Behavioral
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

entity aluBoardTest is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           leds : out STD_LOGIC_VECTOR (4 downto 0);
           segmentData : out STD_LOGIC_VECTOR (6 downto 0);
           segmentSelect : out STD_LOGIC_VECTOR (3 downto 0);
           up : in STD_LOGIC;
           down : in STD_LOGIC;
           clk : in STD_LOGIC);
end aluBoardTest;

architecture Behavioral of aluBoardTest is

    signal opcode : STD_LOGIC_VECTOR(3 downto 0);
    signal result : STD_LOGIC_VECTOR(7 downto 0);
    signal Cout : STD_LOGIC;
    signal upSignal, downSignal : STD_LOGIC;
    signal ones, tens, hundreds : STD_LOGIC_VECTOR(3 downto 0);
    signal BCD : STD_LOGIC_VECTOR(3 downto 0);
    signal clk_divided : STD_LOGIC;

begin

    leds(3 downto 0) <= opcode;

    alu1 : entity work.alu(Behavioral)
        port map(
            A => A,
            B => B,
            Op => opcode,
            Res => result,
            Cout => Cout,
            Equal => leds(4)
        );

    upOneShot1 : entity work.oneShot(Behavioral)
        port map(
            clk => clk,
            inSignal => up,
            shot => upSignal
        );

    downOneShot1 : entity work.oneShot(Behavioral)
        port map(
            clk => clk,
            inSignal => down,
            shot => downSignal
        );

    opCodeCounter1 : entity work.upDownCounter(Behavioral)
        port map(
            clk => clk,
            up => upSignal,
            down => downSignal,
            countOut => opcode
        );

    binaryToBCD1 : entity work.binToBCD(Behavioral)
        port map(
            bin => result,
            ones => ones,
            tens => tens,
            hundreds => hundreds,
            Cout => Cout
        );

    multiplexer1 : entity work.segmentMux(Behavioral)
        port map(
            clk => clk_divided,
            ones => ones,
            tens => tens,
            hundreds => hundreds,
            minus => Cout,
            BCD => BCD,
            segmentSelect => segmentSelect
        );

    toseg1 : entity work.bcdToseg(Behavioral)
        port map(
            BCD => BCD,
            segment => segmentData
        );

    clock_divider1 : entity work.clock_divider(Behavioral)
        port map(
            clk => clk,
            clk_divided => clk_divided
        );

end Behavioral;
