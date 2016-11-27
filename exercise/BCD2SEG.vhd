library ieee;  
 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity BCD2SEG is
	port(	--clk : in std_logic;
			s: in std_logic_vector(7 downto 0);
			y1:buffer  std_logic_vector(3 downto 0);
			y2:buffer  std_logic_vector(3 downto 0)
			--y3:out std_logic_vector(7 downto 0)
	);

end BCD2SEG ;

architecture behav of BCD2SEG is
begin 
process (s)	
	variable tmp : integer ; 
	variable s1:std_logic_vector(7 downto 0):= "00101110" ;
	variable y11:std_logic_vector(3 downto 0);
	variable y21:std_logic_vector(3 downto 0);
begin 
		tmp := conv_integer(s1);
		--q1 := tmp/10 ;
		--q2 := q1/10  ;
			y11 := conv_std_logic_vector(tmp rem 10 , 4);
			y21 := conv_std_logic_vector((tmp/10) rem 10 , 4);
			y1 <= y11 ;
			y2 <= y21;
			--y3 <= y2 & y1 ;
			--y3 <= conv_std_logic_vector(q2 rem 10 , 4);
end process;

end behav;