library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory is
    port(
        signal clk : in std_logic;
        signal addr : in std_logic_vector(3 downto 0);
        signal wr_en : in std_logic;
        signal wr_data : in std_logic_vector(7 downto 0);
        signal rd_data : out std_logic_vector(7 downto 0)
        );
end memory;

architecture Behavioral of memory is
    
    type reg_arr is array(15 downto 0) of std_logic_vector(7 downto 0);
    signal mem : reg_arr;
    
begin
    
    write_data : process(clk) is
    begin
        if rising_edge(clk) then
            if (wr_en = '1') then
                mem(to_integer(unsigned(addr))) <= wr_data;
            end if;
        end if;
        
    end process;
    
    -- read data
    rd_data <= mem(to_integer(unsigned(addr)));
    
end Behavioral;
