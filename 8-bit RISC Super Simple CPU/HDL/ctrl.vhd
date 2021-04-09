library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ctrl is 
    port(
        signal instr : in std_logic_vector(7 downto 0);
        signal j, reg_to_mem, mem_to_reg, wr_to_A, wr_to_B : out std_logic;
        signal alu_op : out std_logic_vector(1 downto 0)
        );
end ctrl;

architecture Behavioral of ctrl is 
    
    
    
begin
    
    ctrl_out : process(instr) is
    begin
        
        case instr(7 downto 4) is
            
            when "0000" => -- NO OP
                j <= '0';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '0';
                wr_to_B <= '0';
                alu_op <= "11"; -- DO NOTHING
                
            when "0001" => -- load word (A)
                j <= '0';
                reg_to_mem <= '0';
                mem_to_reg <= '1';
                wr_to_A <= '1';
                wr_to_B <= '0';
                alu_op <= "10";
            
            when "0010" => -- load word (B)
                j <= '0';
                reg_to_mem <= '0';
                mem_to_reg <= '1';
                wr_to_A <= '0';
                wr_to_B <= '1';
                alu_op <= "10";
            
            when "0011" => -- store word (A)
                j <= '0';
                reg_to_mem <= '1';
                mem_to_reg <= '0';
                wr_to_A <= '0';
                wr_to_B <= '0';
                alu_op <= "00"; -- pass through A
                
            when "0100" => -- move B to A
                j <= '0';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '1';
                wr_to_B <= '0';
                alu_op <= "00"; -- pass through B
                
            when "0101" => -- two's comp [negative]
                j <= '0';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '1';
                wr_to_B <= '0';
                alu_op <= "00";
                
            when "0110" => -- and
                j <= '0';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '1';
                wr_to_B <= '0';   
                alu_op <= "00";
            
            when "0111" => -- or
                j <= '0';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '1';
                wr_to_B <= '0';
                alu_op <= "00";
            
            when "1000" => -- add
                j <= '0';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '1';
                wr_to_B <= '0';
                alu_op <= "00";
            
            when "1001" => -- jump
                j <= '1';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '0';
                wr_to_B <= '0';
                alu_op <= "01";
            
            when "1010" => -- jump C
                j <= '1';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '0';
                wr_to_B <= '0';
                alu_op <= "01";
            
            when "1011" => -- jump Z
                j <= '1';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '0';
                wr_to_B <= '0';
                alu_op <= "01";
            
            when "1100" => -- jump N
                j <= '1';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '0';
                wr_to_B <= '0';
                alu_op <= "01";
            
            when "1101" => -- li to A
                j <= '0';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '1';
                wr_to_B <= '0';
                alu_op <= "10";
            
            --when "1110" => -- OUT
                
            
            --when "1111" => -- HALT
                
              
            when others => 
                j <= '0';
                reg_to_mem <= '0';
                mem_to_reg <= '0';
                wr_to_A <= '0';
                wr_to_B <= '0';
                alu_op <= "11"; -- DO NOTHING
            
        end case;
        
    end process;
    
end Behavioral;