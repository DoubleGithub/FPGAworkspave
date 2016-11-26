 library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity LedCoding is
	port(
		roll_status_led: in std_logic_vector(1 downto 0);   --表示四种状态：停止(00)，待机(01)，
														   		--正转(10)，反转(11)
		Led_dis: out std_logic_vector (3 downto 0)
		);
end LedCoding ;

architecture behav of LedCoding is 
	begin
	process(roll_status_led)
		begin 
			case roll_status_led is
				when "00" => Led_dis <= "0001";
				when "01" => Led_dis <= "0010";
				when "10" => Led_dis <= "0100";
				when "11" => Led_dis <= "1000";
			end case ;
	end process ;							
end behav ;