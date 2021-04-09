library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
    port(
        signal alu_control : in std_logic_vector(2 downto 0);
        signal A : in std_logic_vector(7 downto 0);
        signal B : in std_logic_vector(7 downto 0);
        signal Y : out std_logic_vector(7 downto 0);
        signal C : out std_logic; -- Carry
        signal F : out std_logic_vector(1 downto 0) -- Flags [z, n]
        );
end alu;

architecture Behavioral of alu is
    
    signal alu_out  : std_logic_vector(7 downto 0);
    signal neg_flag : std_logic; 
    
begin
    
    alu_oper : process(alu_control, A, B) is
    begin
        case alu_control is
            
            when "000" => -- Add
                alu_out <= A + B;
            when "001" => -- And  
                alu_out <= A and B;
            when "010" => -- Or
                alu_out <= A or B;
            when "011" => -- Two's Compliment
                alu_out <= not (A - x"01");
            when "100" => -- Pass Through A
                alu_out <= A;
            when "101" => -- Pass Through B
                alu_out <= B;
            when others => alu_out <= x"00";
            
        end case;
        
    end process;
    
    C <= '1' when (alu_out(7) = '1' and A(7) = '0' and B(7) = '0') else '0'; -- carry flag
    neg_flag <= '1' when (alu_out(7) = '1' and (A(7) = '1' or B(7) = '1')) else '0'; -- neg flag
    F(0) <= neg_flag; -- neg flag
    F(1) <= '1' when alu_out(6 downto 0) = "0000000" else '0'; -- zero flag
    Y <= neg_flag & alu_out(6 downto 0); -- output of ALU
    
end Behavioral;
