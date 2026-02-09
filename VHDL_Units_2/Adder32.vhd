-- ============================================================
-- Adder32: std_logic_vector ports, signed arithmetic internally
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder32 is
  port(
    a : in  std_logic_vector(31 downto 0);
    b : in  std_logic_vector(31 downto 0);
    y : out std_logic_vector(31 downto 0)
  );
end entity;

architecture rtl of Adder32 is
begin
  -- Same functionality as: y <= a + b; with signed(31 downto 0)
  y <= std_logic_vector(signed(a) + signed(b));
end architecture;
