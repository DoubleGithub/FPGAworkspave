library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Counter is
	port(
		lk,clk: in std_logic ;
		en: in std_logic ;
		start: in std_logic ;
		time_over: out std_logic ;
		time_set: in std_logic_vector(3 downto 0);
		roll_status_led: buffer std_logic_vector(3 downto 0);   --��ʾ����״̬��ֹͣ(00)������(01)��
														   		--��ת(10)����ת(11)
		
		time_remain_dis_l: out std_logic_vector(3 downto 0);
		time_remain_dis_h: out std_logic_vector(3 downto 0);
		time_current_dis_h: buffer std_logic_vector(3 downto 0);
		time_current_dis_l: buffer std_logic_vector(3 downto 0)
		); 
end Counter ;

architecture behav of Counter is 
	begin 
	process (lk,clk , time_set,en,start)
		variable time_over_v: std_logic ;
		variable time_set_v : std_logic_vector (3 downto 0) ; 
		variable time_remain_dis_l_v : std_logic_vector(3 downto 0); 
		variable time_remain_dis_h_v : std_logic_vector(3 downto 0);                
		variable roll_status_led_v: std_logic_vector(3 downto 0); 
		variable time_count_first_5s : std_logic_vector (3 downto 0);          --�ڶ���ִ��processʱ���Ƿ������
		variable time_count_first_60s : std_logic_vector (7 downto 0) ;
		variable time_count_second_5s : std_logic_vector (3 downto 0)  ;
		variable time_count_second_60s : std_logic_vector (7 downto 0);
		variable time_current_dis_h_v: std_logic_vector(3 downto 0);
		variable time_current_dis_l_v: std_logic_vector(3 downto 0);
		variable tmp : integer ;  --������תbcd����м����
	begin
		if 	start = '0' then                 --δ��ʼʱ������λ����
	        time_count_first_5s  := "0101";
	        time_count_first_60s := "00111100" ;
	        time_count_second_5s := "0101" ;
	        time_count_second_60s := "00111100";
			roll_status_led_v := "0000" ;        --ֹͣ״̬
			time_current_dis_h_v := "0000" ;
			time_current_dis_l_v := "0000" ;
			time_remain_dis_l_v  := "0000" ;
			time_remain_dis_h_v  := "0000" ;
			time_over_v := '0' ;  
            IF LK = '1'THEN 
		         time_set_v := time_set ; --װ��time_set��?  
		         time_current_dis_h_v := "0000" ;
			     time_current_dis_l_v := "0000" ;      
		    else 
	             time_set_v := "0000";
	        END IF;
		elsif rising_edge (clk) then         --�źŵĸ�ֵ����һ��ʱ�����ڣ���ע��
		    
			if en = '0' then
				roll_status_led_v := roll_status_led_v ;
				time_current_dis_h_v := time_current_dis_h_v ;
				time_current_dis_l_v := time_current_dis_l_v ;
				time_remain_dis_l_v  := time_remain_dis_l_v;
				time_remain_dis_h_v  := time_remain_dis_h_v;
				time_over_v := time_over_v ;
			elsif en = '1' then              --ʹ���ź�
				if time_set_v = "0000" then 
					time_over_v := '1' ;       --����ʱ����
					time_current_dis_l_v := "0000"; --------------------
					time_remain_dis_l_v := "0000";    --------------------
					time_remain_dis_h_v := "0000";    --------------------
					roll_status_led_v := "0001" ; --ֹͣ״̬ -------------
					
				elsif time_set_v /= "0000" then
				    tmp := conv_integer(time_set_v); 
				    time_remain_dis_h_v := conv_std_logic_vector((tmp/10) rem 10 , 4); 
					time_remain_dis_l_v := conv_std_logic_vector(tmp rem 10 , 4);
					if  time_count_first_5s = "0000" then 
						if  time_count_first_60s = "00000000" then 
							if  time_count_second_5s = "0000" then 
								if  time_count_second_60s = "00000000" then
									if time_over_v = '1' then 
										time_over_v := '1' ;           --��ֹ
									else 
										time_set_v := time_set_v - 1 ; --����ʱ������һ
										time_count_first_5s := "0101" ; --������װ     
										time_count_first_60s := "00111100" ; 
										time_count_second_5s := "0101"  ;    
										time_count_second_60s := "00111100" ;	
									end if ;							
								else 		
									roll_status_led_v := "1001" ;        --��ת״̬	
									tmp := conv_integer(time_count_second_60s);            --������ת��Ϊbcd��
									time_current_dis_h_v := conv_std_logic_vector((tmp/10) rem 10 , 4); 
									time_current_dis_l_v := conv_std_logic_vector(tmp rem 10 , 4);	
									time_count_second_60s := time_count_second_60s - 1 ;
								end if ;						
							else 	
								
								roll_status_led_v := "0011" ;        --����״̬					
								time_current_dis_h_v := "0000" ;
								time_current_dis_l_v := time_count_second_5s ;
								time_count_second_5s := time_count_second_5s - 1 ;
							end if ;
						else 
							
							roll_status_led_v := "0101" ;        --��ת״̬	
							tmp := conv_integer(time_count_first_60s);            --������ת��Ϊbcd��
							time_current_dis_h_v := conv_std_logic_vector((tmp/10) rem 10 , 4); 
							time_current_dis_l_v := conv_std_logic_vector(tmp rem 10 , 4);
							time_count_first_60s := time_count_first_60s - 1 ;
						end if ;
					else 	
						
						roll_status_led_v := "0011" ;        --����״̬					
						time_current_dis_h_v := "0000" ;
						time_current_dis_l_v := time_count_first_5s ;
						time_count_first_5s := time_count_first_5s - 1 ;						
					end if ;
				end if ;
			end if ;
		end if ;
		time_over <=  time_over_v ;
		roll_status_led	<= roll_status_led_v ;											  
		time_remain_dis_l <= time_remain_dis_l_v ;
		time_remain_dis_h <= time_remain_dis_h_v ;
		time_current_dis_h <= time_current_dis_h_v ;
		time_current_dis_l <= time_current_dis_l_v ;
	end process ;		
end behav ;