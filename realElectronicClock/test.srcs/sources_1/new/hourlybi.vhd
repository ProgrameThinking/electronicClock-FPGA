--The timer chimes lasts for four seconds.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity hourlybi is port(
	min0,min1,sec0,sec1:in std_logic_vector(3 downto 0);
	output:out std_logic
);
end hourlybi;

architecture stl of hourlybi is 
begin
	output<='1' 
		--time-> xx:00:00~xx:00:02
		when((min0="0000" and min1="0000" and sec1="0000")and(sec0="0000" or sec0="0001" or sec0="0010"))
	else '0';
end stl;