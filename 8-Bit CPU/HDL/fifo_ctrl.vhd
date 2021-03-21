library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fifo_ctrl is
generic(ADDR_WIDTH : integer := 4);
port(
    signal clk, reset  : in std_logic;
    signal wr, rd      : in std_logic;
    signal full, empty : inout std_logic;
    signal wr_addr     : out std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal rd_addr     : out std_logic_vector(ADDR_WIDTH - 1 downto 0)
    );
end fifo_ctrl;

architecture Behavioral of fifo_ctrl is
    
    signal wr_ptr, wr_ptr_next   : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal rd_ptr, rd_ptr_next   : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal full_next, empty_next : std_logic;
    signal sel                   : std_logic_vector(1 downto 0);
    
begin
    
    -- Register Segment
    reg_seg : process(clk, reset, full_next, empty_next, wr_ptr_next, rd_ptr_next) is 
    begin
        if rising_edge(clk) then
            if reset = '1' then
                full  <= '0';
                empty  <= '1';
                wr_ptr <= x"0";
                rd_ptr <= x"0";
            else
                full   <= full_next;
                empty  <= empty_next;
                wr_ptr <= wr_ptr_next;
                rd_ptr <= rd_ptr_next;
            end if;
        end if;
        
    end process;
    
    -- Next State Logic
    comb : process(sel, full, empty, rd_ptr, wr_ptr) is
    begin
        
        full_next  <= full;
        empty_next  <= empty;
        wr_ptr_next <= wr_ptr;
        rd_ptr_next <= rd_ptr;
        
        case sel is -- (wr & rd)
        
            when "01" => -- read
                if empty = '0' then
                
                    rd_ptr_next <= rd_ptr + '1';
                    full_next <= '0';
                    if rd_ptr + '1' = wr_ptr then
                    
                        empty_next <= '1';
                        
                    end if;
                    
                end if;
                
            when "10" => -- write
                if full = '0' then
                    
                    wr_ptr_next <= wr_ptr + '1';
                    empty_next <= '0';
                    if wr_ptr + '1' = rd_ptr then
                        
                        full_next <= '1';
                        
                    end if;
                    
                end if;
                
            when "11" => -- read and write
                    
                wr_ptr_next <= wr_ptr + 1;
                rd_ptr_next <= rd_ptr + 1;
               
            when others => -- no read/write DO NOTHING
                
        end case;
        
    end process;
    
    -- Output Logic and 2-bit select
    wr_addr <= wr_ptr;
    rd_addr <= rd_ptr;
    sel <= wr & rd;    

end Behavioral;
