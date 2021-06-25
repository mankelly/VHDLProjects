library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Quad_SPI_Master is
    port(
        signal IO : inout std_logic_vector(3 downto 0);
        signal rw : in std_logic
        );
end Quad_SPI_Master;

Library UNISIM;
use UNISIM.vcomponents.all;


architecture Behavioral of Quad_SPI_Master is
    signal IO_IN : std_logic_vector(3 downto 0);
    signal IO_OUT : std_logic_vector(3 downto 0);
    signal IO_IN_TEMP : std_logic_vector(3 downto 0);
begin
    
    IOBUF_inst0 : IOBUF
    port map (
      O => IO_IN(0),   -- IO_IN is the output of the buffer where IO acts as an input
      I => IO_OUT(0),   -- IO_OUT is the input to the buffer, where it outputs to IO when T = '0'
      IO => IO(0), -- OUR IO SIGNAL
      T => rw    -- 1 == READ, 0 == WRITE
    );
    
    IOBUF_inst1 : IOBUF
    port map (
      O => IO_IN(1),   -- 1-bit output: Buffer output
      I => IO_OUT(1),   -- 1-bit input: Buffer input
      IO => IO(1), -- 1-bit inout: Buffer inout (connect directly to top-level port)
      T => rw    -- 1-bit input: 3-state enable input
    );
    
    IOBUF_inst2 : IOBUF
    port map (
      O => IO_IN(2),   -- 1-bit output: Buffer output
      I => IO_OUT(2),   -- 1-bit input: Buffer input
      IO => IO(2), -- 1-bit inout: Buffer inout (connect directly to top-level port)
      T => rw    -- 1-bit input: 3-state enable input
    );
    
    IOBUF_inst3 : IOBUF
    port map (
      O => IO_IN(3),   -- 1-bit output: Buffer output
      I => IO_OUT(3),   -- 1-bit input: Buffer input
      IO => IO(3), -- 1-bit inout: Buffer inout (connect directly to top-level port)
      T => rw    -- 1-bit input: 3-state enable input
    );
    
    -- EXAMPLE OF USING IO_OUT & IO_IN
    IO_OUT <= "1111" when rw = '0' else "ZZZZ"; 
    IO_IN_TEMP <= IO_IN; -- IO_IN IS BEING SET IN THE IO BUFFER
    
end Behavioral;
