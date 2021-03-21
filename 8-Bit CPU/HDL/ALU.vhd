library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- need this for math operators
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    generic(DATA_WIDTH : integer := 8);
    port(
        signal clk      : in std_logic;
        signal reset    : in std_logic;
        signal A        : in std_logic_vector(DATA_WIDTH-1 downto 0);
        signal B        : in std_logic_vector(DATA_WIDTH-1 downto 0);
        signal instr    : in std_logic_vector(DATA_WIDTH-1 downto 0);
        signal Y        : out std_logic_vector(DATA_WIDTH-1 downto 0)
        );
        
end ALU;

architecture Behavioral of ALU is
    
    signal opcode   : std_logic_vector(3 downto 0);
    signal op       : std_logic; -- has different use cases depending on case statement
    signal c_b      : std_logic; -- carry/borrow
    
begin
    
    -- Mux thats performs all operations
    MUX : process(clk, reset, A, B, opcode, op, c_b) is
    begin
        
        if reset = '1' then
            Y <= x"00";
        else
            
            case opcode is
                
                when "0000" => -- add
                    Y <= A + B;
                when "0001" => -- add w/ carry
                    Y <= A + B + c_b;
                when "0010" => -- sub
                    Y <= A - B;
                when "0011" => -- sub w/ borrow
                    Y <= A - b - c_b;
                when "0100" => -- two's compliment
                    if op = '1' then 
                        Y <= not (A-1);
                    else
                        Y <= not (B-1);
                    end if;
                when "0101" => -- increment
                    if op = '1' then 
                        Y <= A+1;
                    else
                        Y <= B+1;
                    end if;
                when "0110" => -- decrement
                    if op = '1' then 
                        Y <= A-1;
                    else
                        Y <= B-1;
                    end if;
                when "0111" => -- pass through
                    if op = '1' then 
                        Y <= A;
                    else
                        Y <= B;
                    end if;
                when "1000" => -- and
                    Y <= A and B;
                when "1001" => -- or
                    Y <= A or B;
                when "1010" => -- xor
                    Y <= A xor B;
                when "1011" => -- one's compliment
                    if op = '1' then 
                        Y <= not A;
                    else
                        Y <= not B;
                    end if;
                when "1100" => -- arithmetic shift A
                    -- shift left else shift right
                    if op = '1' then
                        Y <= A(6 downto 0) & "0";
                    else
                        Y <= A(7) & A(7 downto 1);
                    end if;
                when "1101" => -- logical shift A
                    -- shift left else shift right
                    if op = '1' then 
                        Y <= A(6 downto 0) & "0";
                    else
                        Y <= "0" & A(7 downto 1);
                    end if;
                when "1110" => -- rotate A
                    -- rotate left else rotate right
                    if op = '1' then 
                        Y <= A(6 downto 0) & A(7);
                    else
                        Y <= A(0) & A(7 downto 1);
                    end if;
                when "1111" => -- rotate through carry A
                    -- rotate left else rotate right
                    if op = '1' then 
                        Y <= A(6 downto 0) & c_b;
                    else
                        Y <= c_b & A(7 downto 1);
                    end if;
                when others =>
                    Y <= x"00";
            end case;
        
        end if;
        
    end process;
    
    -- taking instructions from the instr input
    opcode <= instr(3 downto 0);
    op <= instr(4);
    c_b <= instr(5);
    
end Behavioral;
