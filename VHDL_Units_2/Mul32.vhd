-- ============================================================
-- Mul32: std_logic_vector ports, signed multiply internally
-- keeps low 32 bits exactly as before
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mul32 is
  port(
    a : in  std_logic_vector(31 downto 0);
    b : in  std_logic_vector(31 downto 0);
    y : out std_logic_vector(31 downto 0)
  );
end entity;

architecture rtl of Mul32 is
  signal full_prod : signed(63 downto 0);
begin
  -- Same functionality as original:
  -- full_prod <= a * b;  y <= full_prod(31 downto 0);
  full_prod <= signed(a) * signed(b);
  y <= std_logic_vector(full_prod(31 downto 0));
end architecture;
