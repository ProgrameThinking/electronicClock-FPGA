----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/04/04 16:52:25
-- Design Name: 
-- Module Name: choosebit - stl
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

entity choosebit is port ( 
    clk:in std_logic;
    btn1,btn2:in std_logic;
    settime,setalarm:in std_logic;
    start:in std_logic;
    inputchoose:in std_logic_vector(7 downto 0);
    init:in std_logic_vector(7 downto 0);
    outputchoose:out std_logic_vector(7 downto 0)
);
end choosebit;

architecture stl of choosebit is
    --signal inputchoose:std_logic_vector(7 downto 0):="11111110";
    signal tempoutputchoose:std_logic_vector(7 downto 0);
begin
    process(btn1,btn2,start,clk,settime,setalarm)
    begin
        if(start='0') then
            tempoutputchoose<=init;
        elsif(settime='1' or setalarm='1') then
            tempoutputchoose<=inputchoose;
            if(rising_edge(clk)) then
                if(btn1='1') then   --????
                    tempoutputchoose<=tempoutputchoose(1)&tempoutputchoose(7 downto 2)&tempoutputchoose(0);
                elsif(btn2='1') then--б┴ио??
                    tempoutputchoose<=tempoutputchoose(6 downto 1)&tempoutputchoose(7)&tempoutputchoose(0);
                end if;
            end if;
        end if;
    end process;
    outputchoose<=tempoutputchoose;
end stl;
