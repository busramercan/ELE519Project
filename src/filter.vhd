

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.numeric_std.all; -- use that, it's a better coding guideline
--use IEEE.STD_LOGIC_ARITH.ALL;


entity filter is
    generic(
        FILTER_SIZE : integer := 5;
        TOTAL_DATA : integer := 26
    ); 
  port (
    FPGA_SIDE_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    FPGA_SIDE_clk : out STD_LOGIC;
    FPGA_SIDE_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    FPGA_SIDE_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    FPGA_SIDE_en : out STD_LOGIC;
    FPGA_SIDE_rst : out STD_LOGIC;
    FPGA_SIDE_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    clk : in STD_LOGIC
  );
end filter;

architecture STRUCTURE of filter is
    signal CLOCK_FREQUENCY : integer := 100_000_0000;
    --signal counter : integer := 0;
    signal clk_en : std_logic := '0';

    signal getMode : std_logic_vector(31 downto 0);

    type matrix is array (0 to 20) of std_logic_vector(31 downto 0);
    signal photo : matrix;
    signal filtered : matrix;
        
    signal readCounter : unsigned(28 downto 0) := (others => '0');
    signal writeCounter : unsigned(28 downto 0) := (others => '0'); 

    type mode is (waitingMode, readMode, writeMode, endOfRead, endOfWrite);         --state degerleri enum olarak tutuldu. mealy yapisi kullanildi
    signal current : mode := waitingMode;
   
    signal lastAddress : std_logic_vector(31 downto 0) := x"00000000";
    signal waitCycle : integer := 30;
    signal filteringDone : std_logic := '0';
    --signal wait1Cycle : std_logic := '0';
begin
    
    
    process (clk) 
        variable read1 : std_logic_vector(31 downto 0) := x"00000000";
        variable read2 : std_logic_vector(31 downto 0) := x"00000000";
        variable read3 : std_logic_vector(31 downto 0) := x"00000000";
        
        variable tempResult : std_logic_vector(33 downto 0);
        variable filterResult : std_logic_vector(31 downto 0);
       
    begin
        
        if(rising_edge(clk)) then
            getMode <= x"00000000";
            case (current) is
            when waitingMode =>
                        
                FPGA_SIDE_we <= "0000";
                FPGA_SIDE_addr <= x"00000000";  
                getMode <= FPGA_SIDE_dout;
                if getMode = x"0000000A" then
                    current <= readMode;
                end if;
                              
            when readMode =>
                FPGA_SIDE_we <= "0000";
                FPGA_SIDE_addr <= std_logic_vector(unsigned(readCounter + 1)*"100");-- std_logic_vector(shift_left(readCounter+1,2));
               
                if(readCounter >= 2) then
                    photo(to_integer(readCounter - 2)) <= FPGA_SIDE_dout;
                end if;

                readCounter <= unsigned(readCounter + 1); 
                if(readCounter > TOTAL_DATA ) then
                    readCounter <= (others => '0');
                    
                    current <= endOfRead; 
                end if;
            when endOfRead =>
                  FPGA_SIDE_we <= "1111";
                  FPGA_SIDE_addr <= x"00000000";
                  FPGA_SIDE_din <= x"0000000B"; --okuma bitti
                  current <= writeMode;
            when writeMode =>
                
                FPGA_SIDE_we <= "1111";
                FPGA_SIDE_addr <=  std_logic_vector(unsigned(writeCounter + 1)*"100");--std_logic_vector(shift_left(writeCounter+1,2));
               if(to_integer(writeCounter) mod FILTER_SIZE = 0) then
                    read2 :=  photo(to_integer(writeCounter));
                    tempResult := "0" & read2 & "0";
                    read3 :=  photo(to_integer(writeCounter) + 1);
                    tempResult := std_logic_vector(unsigned(tempResult) + unsigned(read3));
                    filterResult := tempResult(33 downto 2);
                    FPGA_SIDE_din <= filterResult(31 downto 0);
                    --FPGA_SIDE_din <= std_logic_vector(unsigned(photo(to_integer(writeCounter))(30 downto 0) & "0") + unsigned(photo(to_integer(writeCounter+1)))); 
               elsif(to_integer(writeCounter) mod FILTER_SIZE = FILTER_SIZE-1) then
                    read1 :=  photo(to_integer(writeCounter - 1));
                    read2 :=  photo(to_integer(writeCounter));
                    tempResult := "0" & read2 & "0";
                    tempResult := std_logic_vector(unsigned(tempResult) + unsigned(read1));
    
                    filterResult := tempResult(33 downto 2);
                    FPGA_SIDE_din <= filterResult(31 downto 0);
                    
               else
                    read1 :=  photo(to_integer(writeCounter - 1));
                    read2 :=  photo(to_integer(writeCounter));
                    read3 :=  photo(to_integer(writeCounter + 1));
                    
                    tempResult := "0" & read2 & "0";
                    tempResult := std_logic_vector(unsigned(read1) + unsigned(tempResult) + unsigned(read3));
    
                    filterResult := tempResult(33 downto 2);
                    FPGA_SIDE_din <= filterResult(31 downto 0);

               end if;
                writeCounter <= unsigned(writeCounter + 1);
                if(writeCounter > TOTAL_DATA ) then
                    writeCounter <= (others => '0');
                    current <= endOfWrite;
                    waitCycle <= 2;
                   -- filteringDone <= '1';
                end if;
            when endOfWrite =>
                if(waitCycle > 0) then
                    
                    FPGA_SIDE_we <= "1111";
                    FPGA_SIDE_addr <= x"00000000";
                    FPGA_SIDE_din <= x"0000000C"; --yazma bitti
                    waitCycle <= waitCycle - 1;
                    
                else
                    current <= waitingMode;
                end if;  
                
  
                --waiting yerine bitti isaretlenecek
                --waitCycle := 3;
            end case;
            
        end if;
    end process;
    
    FPGA_SIDE_clk <= clk;
    FPGA_SIDE_en <= '1';
                --FPGA_SIDE_din <= x"FFAAFFFF";
                --FPGA_SIDE_addr <= x"00000000";
                
end STRUCTURE;


