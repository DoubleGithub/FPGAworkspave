LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL;
	
ENTITY SHFT IS

PORT( 
	DIN : IN STD_LOGIC_VECTOR (3 DOWNTO 0); 
	DOUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	M : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END SHFT;

ARCHITECTURE behav OF SHFT IS
BEGIN	
		M <=  B"0001";
		DOUT <= B"0001" WHEN DIN(0) = '1'  ELSE
						 B"0010" WHEN DIN(1) = '1'  ELSE
						 B"0100" WHEN DIN(2) = '1'  ELSE
						 B"1000" WHEN DIN(3) = '1'  ELSE 
						 B"0000" ;
END behav;