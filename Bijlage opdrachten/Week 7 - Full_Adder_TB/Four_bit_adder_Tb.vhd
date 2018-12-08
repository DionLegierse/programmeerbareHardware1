-- Vhdl test bench created from schematic C:\Users\jlgheuve\Documents\FPGA programmeren\Les1_full_Adder\TOP.sch - Thu Jan 28 12:12:45 2016
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY Four_bit_adder_tb IS
END Four_bit_adder_tb;
ARCHITECTURE behavioral OF Four_bit_adder_tb IS 

   COMPONENT Four_bit_adder
	Port ( A0 : in STD_LOGIC;
           A1 : in STD_LOGIC;
           A2 : in STD_LOGIC;
           A3 : in STD_LOGIC;
           B0 : in STD_LOGIC;
           B1 : in STD_LOGIC;
           B2 : in STD_LOGIC;
           B3 : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S0 : out STD_LOGIC;
           S1 : out STD_LOGIC;
           S2 : out STD_LOGIC;
           S3 : out STD_LOGIC;
           C_out : out STD_LOGIC);
   END COMPONENT;

   SIGNAL A0	:	STD_LOGIC;
   SIGNAL B0	:	STD_LOGIC;
   SIGNAL S0	:	STD_LOGIC;
   SIGNAL A1	:	STD_LOGIC;
   SIGNAL B1	:	STD_LOGIC;
   SIGNAL S1	:	STD_LOGIC;
   SIGNAL A2	:	STD_LOGIC;
   SIGNAL B2	:	STD_LOGIC;
   SIGNAL S2	:	STD_LOGIC;
   SIGNAL A3	:	STD_LOGIC;
   SIGNAL B3	:	STD_LOGIC;
   SIGNAL C_out	:	STD_LOGIC;
   SIGNAL C_in  :	STD_LOGIC;
   SIGNAL S3	:	STD_LOGIC;
	Signal Test_case: STD_LOGIC_VECTOR (7 downto 0):= (others =>'0');
	signal OK: boolean := true;

BEGIN

   UUT: Four_bit_adder PORT MAP(
		A0 => A0, 
		B0 => B0, 
		S0 => S0, 
		A1 => A1, 
		B1 => B1, 
		S1 => S1, 
		A2 => A2, 
		B2 => B2, 
		S2 => S2, 
		A3 => A3, 
		B3 => B3, 
		C_out => C_out, 
		S3 => S3,
		C_in => C_in
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
			variable S0_t	:	STD_LOGIC;
			variable S1_t	:	STD_LOGIC;
			variable S2_t	:	STD_LOGIC;
			variable S3_t	:	STD_LOGIC;
			variable C_out_t	:	STD_LOGIC;
			variable A : integer;
			variable B : integer;
			variable sum : integer;


	BEGIN
		C_in <= '0'; -- C_in is ignored in this test
		for I in 0 to 255 loop
			
			Test_case <= Std_logic_vector(to_unsigned(I,8));
			A0 <= Test_case(0);
			A1 <= Test_case(1);
			A2 <= Test_case(2);
			A3 <= Test_case(3);
			B0 <= Test_case(4);
			B1 <= Test_case(5);
			B2 <= Test_case(6);
			B3 <= Test_case(7);
			
			
			A := To_integer(unsigned(test_case(3 downto 0)));
			B := To_integer(unsigned(test_case(7 downto 4)));
			sum := A+B;
			
			S0_t := to_unsigned(sum,5)(0);
			S1_t := to_unsigned(sum,5)(1);
			S2_t := to_unsigned(sum,5)(2);
			S3_t := to_unsigned(sum,5)(3);
			C_out_t := to_unsigned(sum,5)(4);
			
			wait for 5 ns;
				
			If S0 /= S0_t then
				OK <= false;
			end if;
			
			if S1 /= S1_t then
				OK <= false;
			end if;
			
			if S2 /= S2_t then
				OK <= false;
			end if;
			
			if S3 /= S3_t then
				OK <= false;
			end if;
			
			if C_out /= C_out_t then
				OK <= false;
			end if;
			
			wait for 5 ns;
			
		
		end loop;
		
		
		
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
