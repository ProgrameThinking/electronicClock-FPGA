----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/04/05 22:54:22
-- Design Name: 
-- Module Name: main - stl
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

entity main is port ( 
    stdclk:in std_logic;
    clear,pause,start,btn1,btn2:in std_logic;
    krow:out std_logic_vector(3 downto 0);
    kcol:in std_logic_vector(3 downto 0);
    output:out std_logic_vector(7 downto 0);
    led:out std_logic_vector(23 downto 0);
    wengweng:out std_logic;
    which:out std_logic_vector(7 downto 0)
);
end main;

architecture stl of main is
    component divider is port ( 
        stdclk:in std_logic;--100MHz
        n:in integer;
        output:out std_logic
    );
    end component;
    component seccounter is port (
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
    end component;
    component mincounter is port (
        settime:in std_logic;
        clear:in std_logic;
        clk:in std_logic;
        sec0,sec1:in std_logic_vector(3 downto 0);
        inputmin0:in std_logic_vector(3 downto 0);
        inputmin1:in std_logic_vector(3 downto 0);
        outputmin0:out std_logic_vector(3 downto 0);
        outputmin1:out std_logic_vector(3 downto 0);
        cout:out std_logic
    );
    end component;
    component hourcounter is port (
        settime:in std_logic;
        clear:in std_logic;
        clk:in std_logic;
        inputhour0:in std_logic_vector(3 downto 0);
        inputhour1:in std_logic_vector(3 downto 0);
        outputhour0:out std_logic_vector(3 downto 0);
        outputhour1:out std_logic_vector(3 downto 0);
        cout:out std_logic
    );
    end component;
    component bit_trans_mos is port ( 
        bitt:in std_logic_vector(3 downto 0);
        mos:out std_logic_vector(7 downto 0)
    );
    end component;
    component show_mos is port ( 
        start:in std_logic;
        clk:in std_logic;   --10000Hz
        blingblingclk:in std_logic; --2Hz
        q0,q1,q2,q3,q4,q5,q6,q7:in std_logic_vector(7 downto 0);
        whichbling:in std_logic_vector(7 downto 0);
        output:out std_logic_vector(7 downto 0);
        which:out std_logic_vector(7 downto 0)
    );
    end component;
    component choosebit is port ( 
        clk:in std_logic;
        btn1,btn2:in std_logic;
        settime,setalarm:in std_logic;
        start:in std_logic;
        inputchoose:in std_logic_vector(7 downto 0);
        init:in std_logic_vector(7 downto 0);
        outputchoose:out std_logic_vector(7 downto 0)
    );
    end component;
    component debounce is port ( 
        clk:in std_logic;   --消抖时序：20HZ
        key:in std_logic;
        output:out std_logic    
    );
    end component;
    component martixInput is port(
        clk:in std_logic;   --1000Hz
        clear:in std_logic;
        krow:out std_logic_vector(3 downto 0);
        kcol:in std_logic_vector(3 downto 0);
        pressed,confirm:out std_logic;
        seg_num:out std_logic_vector(3 downto 0)
    );
    end component;
    component choosemodel is port (
        clk:in std_logic;
        input:in std_logic_vector(3 downto 0);
        settime:out std_logic;
        setalarm:out std_logic;
        q8:out std_logic_vector(3 downto 0)
    );
    end component;
    component inputbit is port (
        choose:in std_logic_vector(7 downto 0);
        pressed:in std_logic;
        input:in std_logic_vector(3 downto 0);
        q1,q2,q3,q4,q5,q6,q7,q8:inout std_logic_vector(3 downto 0)
    );
    end component;
    component hourlybi is port(
        min0,min1,sec0,sec1:in std_logic_vector(3 downto 0);
        output:out std_logic
    );
    end component;
    component alarmbi is port(
        hour0,hour1:in std_logic_vector(3 downto 0);
        min0,min1:in std_logic_vector(3 downto 0);
        sethour0,sethour1:in std_logic_vector(3 downto 0);
        setmin0,setmin1:in std_logic_vector(3 downto 0);
        output:out std_logic
    );
    end component;
    component blzzer is port(
        clk:in std_logic;
        sig:in std_logic;
        --led:out std_logic_vector(23 downto 0);
        stdclk:in std_logic;
        output:out std_logic
    );
    end component;
    --显示模式
    signal q8:std_logic_vector(3 downto 0);
    --需要设置的时频
    signal oneHz,twentyHz,fiveHz,fourThousandHz,oneThousandHz,zeropointfourHz,flush:std_logic;
    --数码管对应信号(数码管真正显示的数字来源)
    --q1~q6分别代表时分秒
    signal q1:std_logic_vector(3 downto 0):="0000";
    signal q2:std_logic_vector(3 downto 0):="0000";
    signal q3:std_logic_vector(3 downto 0):="0000";
    signal q4:std_logic_vector(3 downto 0):="0000";
    signal q5:std_logic_vector(3 downto 0):="0000";
    signal q6:std_logic_vector(3 downto 0):="0000";
    --正常计时时间
    signal nq1:std_logic_vector(3 downto 0):="0000";
    signal nq2:std_logic_vector(3 downto 0):="0000";
    signal nq3:std_logic_vector(3 downto 0):="0000";
    signal nq4:std_logic_vector(3 downto 0):="0000";
    signal nq5:std_logic_vector(3 downto 0):="0000";
    signal nq6:std_logic_vector(3 downto 0):="0000";
    --设置模式下，设置的值
    signal setq1:std_logic_vector(3 downto 0):="0000";
    signal setq2:std_logic_vector(3 downto 0):="0000";
    signal setq3:std_logic_vector(3 downto 0):="0000";
    signal setq4:std_logic_vector(3 downto 0):="0000";
    signal setq5:std_logic_vector(3 downto 0):="0000";
    signal setq6:std_logic_vector(3 downto 0):="0000";
    --临时储存
    signal tq1:std_logic_vector(3 downto 0):="0000";
    signal tq2:std_logic_vector(3 downto 0):="0000";
    signal tq3:std_logic_vector(3 downto 0):="0000";
    signal tq4:std_logic_vector(3 downto 0):="0000";
    signal tq5:std_logic_vector(3 downto 0):="0000";
    signal tq6:std_logic_vector(3 downto 0):="0000";
    signal tq7:std_logic_vector(3 downto 0):="0000";
    signal tq8:std_logic_vector(3 downto 0):="0000";
    --设置的闹钟
    signal aq1:std_logic_vector(3 downto 0):="ZZZZ";
    signal aq2:std_logic_vector(3 downto 0):="ZZZZ";
    signal aq3:std_logic_vector(3 downto 0):="ZZZZ";
    signal aq4:std_logic_vector(3 downto 0):="ZZZZ";
    signal aq5:std_logic_vector(3 downto 0):="ZZZZ";
    signal aq6:std_logic_vector(3 downto 0):="ZZZZ";
    --分秒进位信号
    signal secc,minc:std_logic;
    --7段数码管的储存值
    signal mq1:std_logic_vector(7 downto 0):="11000000";
    signal mq2:std_logic_vector(7 downto 0):="11000000";
    signal mq3:std_logic_vector(7 downto 0):="11000000";
    signal mq4:std_logic_vector(7 downto 0):="11000000";
    signal mq5:std_logic_vector(7 downto 0):="11000000";
    signal mq6:std_logic_vector(7 downto 0):="11000000";
    signal mq7:std_logic_vector(7 downto 0):="11000000";
    signal mq8:std_logic_vector(7 downto 0):="10001000";
    --消抖后的按钮
    signal btn1pressed,btn2pressed,confirm:std_logic;
    signal rchoose,tempchoose:std_logic_vector(7 downto 0);
    --模式选择
    signal settimemodel,setalarmmodel:std_logic;
    --确认是否按下和是否确认
    signal pressed:std_logic;
    --存储矩阵键盘输入数值
    signal tempmartix:std_logic_vector(3 downto 0);
    --整点报时、闹钟报时
    signal bi1,bi2,tempbi:std_logic;
    --流水灯信号
    signal temp11,temp22:std_logic_vector(11 downto 0);
begin
    	process(tempbi,flush,start)
        begin
           if(start='0') then
               temp11<="100000000000";
               temp22<="000000000001";
           elsif(rising_edge(flush)) then
               temp11<=temp11(0)&temp11(11 downto 1);
               temp22<=temp22(10 downto 0)&temp22(11);
           end if;
        end process;
        led(23 downto 12)<=temp22;
        led(11 downto 0)<=temp11;
    
    
    u51:hourlybi port map(min0=>nq4,min1=>nq3,sec0=>nq6,sec1=>nq5,output=>bi1);
    u55:divider port map(stdclk=>stdclk,n=>1250000,output=>flush);
    u52:alarmbi port map(hour0=>nq2,hour1=>nq1,min0=>nq4,min1=>nq3,
                          sethour0=>aq2,sethour1=>aq1,setmin0=>aq4,setmin1=>aq3,                                                                    
                          output=>bi2);
    tempbi<=(bi1 or bi2);
    u50:blzzer port map(clk=>oneThousandHz,sig=>tempbi,output=>wengweng,stdclk=>stdclk);                          
    u8:divider port map(stdclk=>stdclk,n=>10000000,output=>fiveHz);
    u20:divider port map(stdclk=>stdclk,n=>125000,output=>fourThousandHz);
    u22:divider port map(stdclk=>stdclk,n=>50000,output=>oneThousandHz);
    u2: divider port map(stdclk=>stdclk,n=>50000000,output=>oneHz);
    u9: seccounter port map(settime=>confirm,clear=>clear,pause=>pause,clk=>oneHz,inputsec0=>setq6,inputsec1=>setq5,outputsec0=>nq6,outputsec1=>nq5,cout=>secc);                     
    u10:mincounter port map(settime=>confirm,clear=>clear,clk=>secc,inputmin0=>setq4,inputmin1=>setq3,outputmin0=>nq4,outputmin1=>nq3,cout=>minc,sec0=>nq6,sec1=>nq5);                     
    u12:hourcounter port map(settime=>confirm,clear=>clear,clk=>minc,inputhour0=>setq2,inputhour1=>setq1,outputhour0=>nq2,outputhour1=>nq1); 
    u17: bit_trans_mos port map(bitt=>q1,mos=>mq1);
    u18: bit_trans_mos port map(bitt=>q2,mos=>mq2);
    u19: bit_trans_mos port map(bitt=>q3,mos=>mq3);
    u110:bit_trans_mos port map(bitt=>q4,mos=>mq4);
    u111:bit_trans_mos port map(bitt=>q5,mos=>mq5);
    u112:bit_trans_mos port map(bitt=>q6,mos=>mq6);
    u113:bit_trans_mos port map(bitt=>"1111",mos=>mq7);
    u114:bit_trans_mos port map(bitt=>q8,mos=>mq8);
    --led(7 downto 0)<=tempchoose when(tempbi='0');
    u115:show_mos port map(start=>start,blingblingclk=>oneHz,clk=>fourThousandHz,
                          q0=>mq8,q1=>mq7,q2=>mq6,whichbling=>rchoose,
                          q3=>mq5,q4=>mq4,q5=>mq3,q6=>mq2,q7=>mq1,
                          output=>output,which=>which);
    u101:divider port map(stdclk=>stdclk,n=>2500000,output=>twentyHz);
    u7:choosebit port map(clk=>fiveHz,btn1=>btn1,btn2=>btn2,settime=>settimemodel,setalarm=>setalarmmodel,start=>start,
                      inputchoose=>tempchoose,outputchoose=>tempchoose,init=>"11111101");
    u5:martixInput port map(clk=>oneThousandHz,clear=>clear,krow=>krow,kcol=>kcol,pressed=>pressed,seg_num=>tempmartix,confirm=>confirm);
    u66:choosemodel port map(clk=>fourThousandHz,input=>tempmartix,settime=>settimemodel,setalarm=>setalarmmodel,q8=>q8);
    u13:inputbit port map(choose=>tempchoose,pressed=>pressed,input=>tempmartix,
                        q1=>tq1,q2=>tq2,q3=>tq3,q4=>tq4,q5=>tq5,q6=>tq6,q7=>tq7,q8=>tq8
                        );
    process(settimemodel,setalarmmodel)
    begin
        if(settimemodel='1') then
            setq1<=tq1;setq2<=tq2;setq3<=tq3;
            setq4<=tq4;setq5<=tq5;setq6<=tq6;
            q1<=tq1;q2<=tq2;q3<=tq3;
            q4<=tq4;q5<=tq5;q6<=tq6;
        elsif(setalarmmodel='1') then
            aq1<=tq1;aq2<=tq2;aq3<=tq3;
            aq4<=tq4;aq5<=tq5;aq6<=tq6;
            q1<=tq1;q2<=tq2;q3<=tq3;
            q4<=tq4;q5<=tq5;q6<=tq6;
        else
            q1<=nq1;q2<=nq2;q3<=nq3;
            q4<=nq4;q5<=nq5;q6<=nq6;
        end if;
    end process;
    process(settimemodel,setalarmmodel)
      begin
          if(settimemodel='1' or setalarmmodel='1') then
              rchoose<=tempchoose;
          else
              rchoose<="11111111";
          end if;
      end process;
end stl;
