library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Counter is
	port(
		clk: in std_logic ;
		en: in std_logic ;
		start: in std_logic ;
		time_over: out std_logic ;
		time_set: in std_logic_vector(3 downto 0);
		roll_status_led: buffer std_logic_vector(1 downto 0); --表示四种状态：停止(00)，待机(01)，
														   --正转(10)，反转(11)
		
		time_remain_dis: out std_logic_vector(3 downto 0);
		time_current_dis_h: buffer std_logic_vector(3 downto 0);
		time_current_dis_l: buffer std_logic_vector(3 downto 0)
		); 
end Counter ;

architecture behav of Counter is 
	begin 
	process (clk , time_set,en,start)
		variable time_over_v: std_logic ;
		variable time_set_v : std_logic_vector (3 downto 0) ; 
		variable time_remain_dis_v : std_logic_vector(3 downto 0);               
		variable roll_status_led_v: std_logic_vector(1 downto 0); 
		variable time_count_first_5s : std_logic_vector (3 downto 0) := "0101" ;          --第二次执行process时，是否会重新
		variable time_count_first_60s : std_logic_vector (7 downto 0) := "00111100" ;
		variable time_count_second_5s : std_logic_vector (3 downto 0) := "0101"  ;
		variable time_count_second_60s : std_logic_vector (7 downto 0) := "00111100" ;
		variable time_current_dis_h_v: std_logic_vector(3 downto 0);
		variable time_current_dis_l_v: std_logic_vector(3 downto 0);
		variable tmp : integer ;  --二进制转bcd码的中间变量
	begin
		if 	start = '0' then                 --未开始时，所有位清零
			roll_status_led_v := "00" ;        --停止状态
			time_current_dis_h_v := "0000" ;
			time_current_dis_l_v := "0000" ;
			time_remain_dis_v  := "0000" ;
			time_over_v := '0' ;
			time_set_v := time_set ;         --装入time_set初值
		elsif rising_edge (clk) then         --信号的赋值会晚一个时钟周期，待注意
			if en = '0' then
				roll_status_led_v := roll_status_led_v ;
				time_current_dis_h_v := time_current_dis_h_v ;
				time_current_dis_l_v := time_current_dis_l_v ;
				time_remain_dis_v  := time_remain_dis_v;
				time_over_v := time_over_v ;
			elsif en = '1' then              --使能信号
				if time_set_v = "0000" then 
					time_over_v := '1' ;       --倒计时结束
					time_current_dis_l_v := "0000"; --------------------
					time_remain_dis_v := "0000";    --------------------
					roll_status_led_v := "00" ; --停止状态 -------------
					
				elsif time_set_v /= "0000" then
					time_remain_dis_v := time_set_v ; 
					if  time_count_first_5s = "0000" then 
						if  time_count_first_60s = "00000000" then 
							if  time_count_second_5s = "0000" then 
								if  time_count_second_60s = "00000000" then
									if time_over_v = '1' then 
										time_over_v := '1' ;           --终止
									else 
										time_set_v := time_set_v - 1 ; --倒计时次数减一
										time_count_first_5s := "0101" ; --秒数重装     
										time_count_first_60s := "00111100" ; 
										time_count_second_5s := "0101"  ;    
										time_count_second_60s := "00111100" ;	
									end if ;							
								else 
									
									roll_status_led_v := "11" ;        --反转状态	
									tmp := conv_integer(time_count_second_60s);            --二进制转换为bcd码
									time_current_dis_h_v := conv_std_logic_vector((tmp/10) rem 10 , 4); 
									time_current_dis_l_v := conv_std_logic_vector(tmp rem 10 , 4);	
									time_count_second_60s := time_count_second_60s - 1 ;
								end if ;						
							else 	
								
								roll_status_led_v := "01" ;        --待机状态					
								time_current_dis_h_v := "0000" ;
								time_current_dis_l_v := time_count_second_5s ;
								time_count_second_5s := time_count_second_5s - 1 ;
							end if ;
						else 
							
							roll_status_led_v := "10" ;        --正转状态	
							tmp := conv_integer(time_count_first_60s);            --二进制转换为bcd码
							time_current_dis_h_v := conv_std_logic_vector((tmp/10) rem 10 , 4); 
							time_current_dis_l_v := conv_std_logic_vector(tmp rem 10 , 4);
							time_count_first_60s := time_count_first_60s - 1 ;
						end if ;
					else 	
						
						roll_status_led_v := "01" ;        --待机状态					
						time_current_dis_h_v := "0000" ;
						time_current_dis_l_v := time_count_first_5s ;
						time_count_first_5s := time_count_first_5s - 1 ;						
					end if ;
				end if ;
			end if ;
		end if ;
		time_over <=  time_over_v ;
		roll_status_led	<= roll_status_led_v ;											  
		time_remain_dis <= time_remain_dis_v ;
		time_current_dis_h <= time_current_dis_h_v ;
		time_current_dis_l <= time_current_dis_l_v ;
	end process ;		
end behav ;