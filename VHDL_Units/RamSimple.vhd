library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RamSimple is
  generic (
    ADDR_WIDTH : integer := 10;  -- 2^10 = 1024 words
    DATA_WIDTH : integer := 32
  );
  port (
    clk  : in  std_logic;
    en   : in  std_logic;
    we   : in  std_logic;
    addr : in  signed(DATA_WIDTH-1 downto 0);  -- uses low ADDR_WIDTH bits
    din  : in  signed(DATA_WIDTH-1 downto 0);
    dout : out signed(DATA_WIDTH-1 downto 0)
  );
end entity;

architecture rtl of RamSimple is
  type ram_t is array (0 to (2**ADDR_WIDTH)-1) of signed(DATA_WIDTH-1 downto 0);
  signal ram : ram_t := (others => (others => '0'));

  -- address conversion: use low ADDR_WIDTH bits
  function addr_to_int(a : signed(DATA_WIDTH-1 downto 0)) return integer is
    variable u : unsigned(ADDR_WIDTH-1 downto 0);
  begin
    u := unsigned(a(ADDR_WIDTH-1 downto 0));
    return to_integer(u);
  end function;

  signal a_i : integer range 0 to (2**ADDR_WIDTH)-1;
begin
  a_i <= addr_to_int(addr);

  -- synchronous write
  process(clk)
  begin
    if rising_edge(clk) then
      if en = '1' then
        if we = '1' then
          ram(a_i) <= din;
        end if;
      end if;
    end if;
  end process;

  -- asynchronous read (combinational)
  process(all)
  begin
    if en = '1' then
      dout <= ram(a_i);
    else
      dout <= (others => '0');
    end if;
  end process;
end architecture;
