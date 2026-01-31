library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mul32 is
  port(
    a : in  signed(31 downto 0);
    b : in  signed(31 downto 0);
    y : out signed(31 downto 0)
  );
end entity;

architecture rtl of Mul32 is
  signal full_prod : signed(63 downto 0);
begin
  full_prod <= a * b;
  y <= full_prod(31 downto 0);
end architecture;
