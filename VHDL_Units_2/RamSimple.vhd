-- ============================================================
-- RamSimple: std_logic_vector ports, numeric_std internally
-- Same behavior:
--   - addr treated as unsigned for indexing (same as to_integer(unsigned(signed_addr)))
--   - sync write when en='1' and we='1'
--   - async read gated by en (else zeros)
--   - init values stored as two's-complement bit patterns via to_signed
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RamSimple is
  generic (
    ADDR_WIDTH : integer := 10;
    DATA_WIDTH : integer := 32;

    INIT_0 : integer := 0;
    INIT_1 : integer := 0;
    INIT_2 : integer := 0;
    INIT_3 : integer := 0;
    INIT_4 : integer := 0;
    INIT_5 : integer := 0;
    INIT_6 : integer := 0;
    INIT_7 : integer := 0
  );
  port (
    clk  : in  std_logic;
    en   : in  std_logic;
    we   : in  std_logic;
    addr : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    din  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    dout : out std_logic_vector(DATA_WIDTH-1 downto 0)
  );
end entity;

architecture rtl of RamSimple is
  type ram_t is array (0 to (2**ADDR_WIDTH)-1) of std_logic_vector(DATA_WIDTH-1 downto 0);

  signal ram : ram_t := (
    0 => std_logic_vector(to_signed(INIT_0, DATA_WIDTH)),
    1 => std_logic_vector(to_signed(INIT_1, DATA_WIDTH)),
    2 => std_logic_vector(to_signed(INIT_2, DATA_WIDTH)),
    3 => std_logic_vector(to_signed(INIT_3, DATA_WIDTH)),
    4 => std_logic_vector(to_signed(INIT_4, DATA_WIDTH)),
    5 => std_logic_vector(to_signed(INIT_5, DATA_WIDTH)),
    6 => std_logic_vector(to_signed(INIT_6, DATA_WIDTH)),
    7 => std_logic_vector(to_signed(INIT_7, DATA_WIDTH)),
    others => (others => '0')
  );

  function addr_to_int(a : std_logic_vector(ADDR_WIDTH-1 downto 0)) return integer is
  begin
    -- Same indexing semantics as original:
    -- return to_integer(unsigned(signed_addr));
    return to_integer(unsigned(a));
  end function;

  signal a_i : integer range 0 to (2**ADDR_WIDTH)-1;
begin
  a_i <= addr_to_int(addr);

  -- synchronous write
  process(clk)
  begin
    if rising_edge(clk) then
      if en = '1' and we = '1' then
        ram(a_i) <= din;
      end if;
    end if;
  end process;

  -- async read
  dout <= ram(a_i) when en = '1' else (others => '0');
end architecture;
