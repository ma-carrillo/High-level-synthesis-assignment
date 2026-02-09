-- ============================================================
-- Reg32: std_logic_vector ports, same register behavior
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg32 is
  port(
    clk : in  std_logic;
    en  : in  std_logic;
    d   : in  std_logic_vector(31 downto 0);
    q   : out std_logic_vector(31 downto 0)
  );
end entity;

architecture rtl of Reg32 is
  signal q_r : std_logic_vector(31 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if en = '1' then
        q_r <= d;
      end if;
    end if;
  end process;

  q <= q_r;
end architecture;
