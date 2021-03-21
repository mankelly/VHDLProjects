library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memory is
Generic(ADDR_WIDTH : integer := 4;
        DATA_WIDTH : integer := 8);
port(
    clk     : in std_logic;
    wr_en   : in std_logic;
    rd_addr : in integer range 0 to 2**ADDR_WIDTH-1;
    wr_addr : in integer range 0 to 2**ADDR_WIDTH-1;
    wr_data : in std_logic_vector(DATA_WIDTH-1 downto 0);
    rd_data : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
    
end memory;

architecture Behavioral of memory is

type mem is array(0 to 2**ADDR_WIDTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal ram_block : mem;

begin
    
    -- writing to mem
    write_data: process(clk) is
    begin
        if rising_edge(clk) then
            if (wr_en = '1') then
                ram_block(wr_addr) <= wr_data;
            end if;
        end if;            
    end process;
    
    -- reading from mem
    rd_data <= ram_block(rd_addr);
    
end Behavioral;
