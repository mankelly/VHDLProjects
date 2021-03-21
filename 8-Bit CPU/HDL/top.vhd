library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
generic(ADDR_WIDTH : integer := 4;
        DATA_WIDTH : integer := 8);
port(
    signal clk    : in std_logic;
    signal reset  : in std_logic;
    signal wr     : in std_logic;
    signal A      : in std_logic_vector(DATA_WIDTH-1 downto 0);
    signal B      : in std_logic_vector(DATA_WIDTH-1 downto 0);
    signal opcode : in std_logic_vector(DATA_WIDTH-1 downto 0);
    signal Y      : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end top;

architecture Behavioral of top is
    
    signal instr, pc : std_logic_vector(DATA_WIDTH-1 downto 0); -- instruction reg and program counter
    signal full, empty : std_logic;
    signal wr_addr : std_logic_vector(ADDR_WIDTH-1 downto 0);
    signal rd : std_logic;
    
begin
    
    -- Set read
    rd <= not empty; -- always read when not empty
    
    -- Reset Logic
--    rst : process(clk, reset) is 
--    begin
--        if rising_edge(clk) then
--            if reset = '1' then
--                --Y       <= x"00";
--                --instr   <= x"00";
--                --pc      <= x"00";
--            end if;
--        end if;
        
--    end process;
    -- DONT DO THIS, WE ALREADY INSTANTIATED CONNECTS FOR RESET IN EACH MODULE. DOING THIS
    -- WILL BREAK OUR CODE. VALUES ARE ASSIGNED FOR RESET IN EACH MODULE!!!!
    
    -- fifo_ctrl for instr mem
    instr_ctrl : entity work.fifo_ctrl(Behavioral)
    generic map(ADDR_WIDTH => ADDR_WIDTH)
    port map(
            clk     => clk,
            reset   => reset,
            wr      => wr,
            rd      => rd,
            full    => full,
            empty   => empty,
            wr_addr => wr_addr,
            rd_addr => pc(ADDR_WIDTH-1 downto 0)
            );
    
    -- instruction memory gen        
    instr_mem : entity work.memory(Behavioral)
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => DATA_WIDTH)
    port map(
            clk     => clk,
            wr_en   => wr,
            rd_addr => to_integer(unsigned(pc(ADDR_WIDTH-1 downto 0))),
            wr_addr => to_integer(unsigned(wr_addr)),
            wr_data => opcode,
            rd_data => instr
            );
            
    
    -- ALU gen
    alu_8_bit : entity work.ALU(Behavioral)
    generic map(DATA_WIDTH => DATA_WIDTH)
    port map(
            clk   => clk,
            reset => reset,
            A     => A,
            B     => B,
            instr => instr,
            Y     => Y
            );
    
end Behavioral;
