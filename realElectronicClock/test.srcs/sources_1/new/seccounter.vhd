----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/04/05 17:15:41
-- Design Name: 
-- Module Name: seccounter - stl
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seccounter is port (
    settime:in std_logic;
    clear:in std_logic;
    pause:in std_logic;
    clk:in std_logic;
    inputsec0:in std_logic_vector(3 downto 0);
    inputsec1:in std_logic_vector(3 downto 0);
    outputsec0:out std_logic_vector(3 downto 0);
    outputsec1:out std_logic_vector(3 downto 0);
    cout:out std_logic
);
end seccounter;

architecture stl of seccounter is
    signal tempsec0:std_logic_vector(3 downto 0);
    signal tempsec1:std_logic_vector(3 downto 0);
begin
    process(settime,clk,clear,pause)
    begin
        if(settime='1') then
            tempsec1<=inputsec1;
            tempsec0<=inputsec0;
        elsif(clear='1') then
            tempsec0<="0000";
            tempsec1<="0000";
        elsif(pause='1') then   
            null;
        elsif(rising_edge(clk)) then
            if(tempsec0="1001") then
                tempsec0<="0000";
                if(tempsec1="0101") then
                    tempsec1<="0000";
                    cout<='1';
                else
                    tempsec1<=tempsec1+1;
                end if;
            else
                tempsec0<=tempsec0+1;
                cout<='0';
            end if;
        end if;
    end process;
    outputsec0<=tempsec0;
    outputsec1<=tempsec1;
    --cout<='1' when (tempsec0="0000" and tempsec1="0000"and settime='0') else '0';
end stl;
