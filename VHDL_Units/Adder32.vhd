library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder32 is
  port(
    a : in  signed(31 downto 0);
    b : in  signed(31 downto 0);
    y : out signed(31 downto 0)
  );
end entity;

architecture rtl of Adder32 is
begin
  y <= a + b;
end architecture;
