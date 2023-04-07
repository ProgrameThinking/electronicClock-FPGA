library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alarmbi is port(
	hour0,hour1:in std_logic_vector(3 downto 0);
	min0,min1:in std_logic_vector(3 downto 0);
	sethour0,sethour1:in std_logic_vector(3 downto 0);
	setmin0,setmin1:in std_logic_vector(3 downto 0);
	output:out std_logic
);
end alarmbi;

architecture stl of alarmbi is
begin
	output <= '1' 
		when(min0>=setmin0 and min0<=setmin0+1 and min1=setmin1 and hour0=sethour0 and hour1=sethour1)
	else '0';
end stl; 