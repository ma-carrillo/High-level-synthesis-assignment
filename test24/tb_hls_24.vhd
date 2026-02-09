library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_hls_24 is
end entity;

architecture sim of tb_hls_24 is
  constant CLK_PERIOD     : time    := 10 ns;
  constant TIMEOUT_CYCLES : integer := 20000;

  signal clk  : std_logic := '0';
  signal rst  : std_logic := '1';
  signal done : std_logic;

  constant ADDR_WIDTH : integer := 10;
  constant DEPTH      : integer := 1024;

  -- RamSimple internal array type (must match RamSimple 'ram' signal type)
  type ram_t is array (0 to DEPTH-1) of std_logic_vector(31 downto 0);

  -- External-name alias to internal RAM array for mem_0
  alias dut_mem_0_ram : ram_t is
    << signal .tb_hls_24.dut.U_mem_0.ram : ram_t >>;

  -- External-name alias to internal RAM array for mem_1
  alias dut_mem_1_ram : ram_t is
    << signal .tb_hls_24.dut.U_mem_1.ram : ram_t >>;

  -- External-name alias to internal RAM array for mem_2
  alias dut_mem_2_ram : ram_t is
    << signal .tb_hls_24.dut.U_mem_2.ram : ram_t >>;

  -- Wave-friendly RAM probes (integers)
  signal mem_0_0 : integer := 0;
  signal mem_0_1 : integer := 0;
  signal mem_0_2 : integer := 0;
  signal mem_0_3 : integer := 0;
  signal mem_0_4 : integer := 0;
  signal mem_0_5 : integer := 0;
  signal mem_0_6 : integer := 0;
  signal mem_0_7 : integer := 0;
  signal mem_1_0 : integer := 0;
  signal mem_1_1 : integer := 0;
  signal mem_1_2 : integer := 0;
  signal mem_1_3 : integer := 0;
  signal mem_1_4 : integer := 0;
  signal mem_1_5 : integer := 0;
  signal mem_1_6 : integer := 0;
  signal mem_1_7 : integer := 0;
  signal mem_2_0 : integer := 0;
  signal mem_2_1 : integer := 0;
  signal mem_2_2 : integer := 0;
  signal mem_2_3 : integer := 0;
  signal mem_2_4 : integer := 0;
  signal mem_2_5 : integer := 0;
  signal mem_2_6 : integer := 0;
  signal mem_2_7 : integer := 0;

begin
  -- Clock
  clk <= not clk after CLK_PERIOD/2;

  -- DUT
  dut : entity work.hls_top_unified_24
    port map (
      clk  => clk,
      rst  => rst,
      done => done
    );

  -- Continuous probes (wave-friendly)
  p_probes : process(all)
  begin
    mem_0_0 <= to_integer(signed(dut_mem_0_ram(0)));
    mem_0_1 <= to_integer(signed(dut_mem_0_ram(1)));
    mem_0_2 <= to_integer(signed(dut_mem_0_ram(2)));
    mem_0_3 <= to_integer(signed(dut_mem_0_ram(3)));
    mem_0_4 <= to_integer(signed(dut_mem_0_ram(4)));
    mem_0_5 <= to_integer(signed(dut_mem_0_ram(5)));
    mem_0_6 <= to_integer(signed(dut_mem_0_ram(6)));
    mem_0_7 <= to_integer(signed(dut_mem_0_ram(7)));
    mem_1_0 <= to_integer(signed(dut_mem_1_ram(0)));
    mem_1_1 <= to_integer(signed(dut_mem_1_ram(1)));
    mem_1_2 <= to_integer(signed(dut_mem_1_ram(2)));
    mem_1_3 <= to_integer(signed(dut_mem_1_ram(3)));
    mem_1_4 <= to_integer(signed(dut_mem_1_ram(4)));
    mem_1_5 <= to_integer(signed(dut_mem_1_ram(5)));
    mem_1_6 <= to_integer(signed(dut_mem_1_ram(6)));
    mem_1_7 <= to_integer(signed(dut_mem_1_ram(7)));
    mem_2_0 <= to_integer(signed(dut_mem_2_ram(0)));
    mem_2_1 <= to_integer(signed(dut_mem_2_ram(1)));
    mem_2_2 <= to_integer(signed(dut_mem_2_ram(2)));
    mem_2_3 <= to_integer(signed(dut_mem_2_ram(3)));
    mem_2_4 <= to_integer(signed(dut_mem_2_ram(4)));
    mem_2_5 <= to_integer(signed(dut_mem_2_ram(5)));
    mem_2_6 <= to_integer(signed(dut_mem_2_ram(6)));
    mem_2_7 <= to_integer(signed(dut_mem_2_ram(7)));
  end process;

  -- Reset
  p_reset : process
  begin
    rst <= '1';
    wait for 5*CLK_PERIOD;
    rst <= '0';
    wait;
  end process;

  -- Run + (optional) RAM dumps
  p_run : process
    variable cycles : integer := 0;
    variable v      : integer := 0;
  begin
    -- Let hierarchy elaborate so external-name aliases resolve
    wait for 0 ns;

    -- Print RAM init (first few locations)
    report "RAM INIT mem_0[0..7]";
    v := to_integer(signed(dut_mem_0_ram(0)));
    report "  mem_0[0] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(1)));
    report "  mem_0[1] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(2)));
    report "  mem_0[2] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(3)));
    report "  mem_0[3] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(4)));
    report "  mem_0[4] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(5)));
    report "  mem_0[5] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(6)));
    report "  mem_0[6] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(7)));
    report "  mem_0[7] = " & integer'image(v);
    report "RAM INIT mem_1[0..7]";
    v := to_integer(signed(dut_mem_1_ram(0)));
    report "  mem_1[0] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(1)));
    report "  mem_1[1] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(2)));
    report "  mem_1[2] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(3)));
    report "  mem_1[3] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(4)));
    report "  mem_1[4] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(5)));
    report "  mem_1[5] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(6)));
    report "  mem_1[6] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(7)));
    report "  mem_1[7] = " & integer'image(v);
    report "RAM INIT mem_2[0..7]";
    v := to_integer(signed(dut_mem_2_ram(0)));
    report "  mem_2[0] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(1)));
    report "  mem_2[1] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(2)));
    report "  mem_2[2] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(3)));
    report "  mem_2[3] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(4)));
    report "  mem_2[4] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(5)));
    report "  mem_2[5] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(6)));
    report "  mem_2[6] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(7)));
    report "  mem_2[7] = " & integer'image(v);

    -- Wait until reset deasserted
    wait until rst = '0';
    wait until rising_edge(clk);

    -- Wait for done or timeout
    while done /= '1' loop
      wait until rising_edge(clk);
      cycles := cycles + 1;
      if cycles >= TIMEOUT_CYCLES then
        assert false report "TIMEOUT: done did not assert" severity failure;
      end if;
    end loop;

    report "DONE asserted after " & integer'image(cycles) & " cycles.";

    -- Print RAM after DONE (first few locations)
    report "RAM FINAL mem_0[0..7]";
    v := to_integer(signed(dut_mem_0_ram(0)));
    report "  mem_0[0] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(1)));
    report "  mem_0[1] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(2)));
    report "  mem_0[2] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(3)));
    report "  mem_0[3] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(4)));
    report "  mem_0[4] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(5)));
    report "  mem_0[5] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(6)));
    report "  mem_0[6] = " & integer'image(v);
    v := to_integer(signed(dut_mem_0_ram(7)));
    report "  mem_0[7] = " & integer'image(v);
    report "RAM FINAL mem_1[0..7]";
    v := to_integer(signed(dut_mem_1_ram(0)));
    report "  mem_1[0] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(1)));
    report "  mem_1[1] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(2)));
    report "  mem_1[2] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(3)));
    report "  mem_1[3] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(4)));
    report "  mem_1[4] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(5)));
    report "  mem_1[5] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(6)));
    report "  mem_1[6] = " & integer'image(v);
    v := to_integer(signed(dut_mem_1_ram(7)));
    report "  mem_1[7] = " & integer'image(v);
    report "RAM FINAL mem_2[0..7]";
    v := to_integer(signed(dut_mem_2_ram(0)));
    report "  mem_2[0] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(1)));
    report "  mem_2[1] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(2)));
    report "  mem_2[2] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(3)));
    report "  mem_2[3] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(4)));
    report "  mem_2[4] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(5)));
    report "  mem_2[5] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(6)));
    report "  mem_2[6] = " & integer'image(v);
    v := to_integer(signed(dut_mem_2_ram(7)));
    report "  mem_2[7] = " & integer'image(v);

    wait;
  end process;

end architecture;