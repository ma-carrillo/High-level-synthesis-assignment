library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hls_top is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    start : in  std_logic;
    done  : out std_logic
  );
end entity;

architecture rtl of hls_top is
  signal r0_q  : signed(31 downto 0);
  signal r0_en  : std_logic;
  signal r1_q  : signed(31 downto 0);
  signal r1_en  : std_logic;
  signal r2_q  : signed(31 downto 0);
  signal r2_en  : std_logic;
  signal r3_q  : signed(31 downto 0);
  signal r3_en  : std_logic;
  signal r4_q  : signed(31 downto 0);
  signal r4_en  : std_logic;
  signal r5_q  : signed(31 downto 0);
  signal r5_en  : std_logic;
  signal r6_q  : signed(31 downto 0);
  signal r6_en  : std_logic;
  signal r7_q  : signed(31 downto 0);
  signal r7_en  : std_logic;
  signal r8_q  : signed(31 downto 0);
  signal r8_en  : std_logic;
  
  signal sel_mem_0_addr : integer := 0;
  signal sel_mul_0_in0 : integer := 0;
  signal sel_mul_0_in1 : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  signal sel_mem_0_val : integer := 0;
  
  signal mem_0_en   : std_logic;
  signal mem_0_we   : std_logic;
  signal mem_0_addr : signed(31 downto 0);
  signal mem_0_din  : signed(31 downto 0);
  signal mem_0_dout : signed(31 downto 0);
  
  signal sig_0_4 : signed(31 downto 0);
  signal sig_0_5 : signed(31 downto 0);
  signal sig_0_7 : signed(31 downto 0);
  signal sig_0_10 : signed(31 downto 0);
  signal sig_1_6 : signed(31 downto 0);
  signal sig_1_8 : signed(31 downto 0);
  signal sig_1_11 : signed(31 downto 0);
  signal sig_2_9 : signed(31 downto 0);
  signal sig_3_12 : signed(31 downto 0);
  signal sig_4_13 : signed(31 downto 0);
  signal sig_5_13 : signed(31 downto 0);
  signal sig_6_14 : signed(31 downto 0);
  signal sig_7_13 : signed(31 downto 0);
  signal sig_8_15 : signed(31 downto 0);
  signal sig_9_16 : signed(31 downto 0);
  signal sig_10_13 : signed(31 downto 0);
  signal sig_11_17 : signed(31 downto 0);
  signal sig_12_18 : signed(31 downto 0);
  signal sig_13_1 : signed(31 downto 0);
  signal sig_13_1 : signed(31 downto 0);
  signal sig_13_1 : signed(31 downto 0);
  signal sig_13_1 : signed(31 downto 0);
  signal sig_14_2 : signed(31 downto 0);
  signal sig_15_2 : signed(31 downto 0);
  signal sig_16_3 : signed(31 downto 0);
  signal sig_17_3 : signed(31 downto 0);
  signal sig_18_1 : signed(31 downto 0);
  
  signal state : integer range 0 to 6 := 0;
  
  -- Component declarations (assumed to exist)
  component Reg32 is
    port(clk: in std_logic; en: in std_logic; d: in signed(31 downto 0); q: out signed(31 downto 0));
  end component;
  component Adder32 is
    port(a: in signed(31 downto 0); b: in signed(31 downto 0); y: out signed(31 downto 0));
  end component;
  component Mul32 is
    port(a: in signed(31 downto 0); b: in signed(31 downto 0); y: out signed(31 downto 0));
  end component;
  component RamSimple is
    port(clk: in std_logic; en: in std_logic; we: in std_logic;
         addr: in signed(31 downto 0); din: in signed(31 downto 0); dout: out signed(31 downto 0));
  end component;
  
begin
  U_r0: Reg32 port map(
    clk => clk,
    en  => r0_en,
    d   => sig_0_4,
    q   => r0_q
  );
  U_r1: Reg32 port map(
    clk => clk,
    en  => r1_en,
    d   => sig_0_5,
    q   => r1_q
  );
  U_r2: Reg32 port map(
    clk => clk,
    en  => r2_en,
    d   => sig_1_6,
    q   => r2_q
  );
  U_r3: Reg32 port map(
    clk => clk,
    en  => r3_en,
    d   => sig_0_7,
    q   => r3_q
  );
  U_r4: Reg32 port map(
    clk => clk,
    en  => r4_en,
    d   => sig_1_8,
    q   => r4_q
  );
  U_r5: Reg32 port map(
    clk => clk,
    en  => r5_en,
    d   => sig_2_9,
    q   => r5_q
  );
  U_r6: Reg32 port map(
    clk => clk,
    en  => r6_en,
    d   => sig_0_10,
    q   => r6_q
  );
  U_r7: Reg32 port map(
    clk => clk,
    en  => r7_en,
    d   => sig_1_11,
    q   => r7_q
  );
  U_r8: Reg32 port map(
    clk => clk,
    en  => r8_en,
    d   => sig_3_12,
    q   => r8_q
  );
  
  U_mem_0: RamSimple port map(
    clk  => clk,
    en   => mem_0_en,
    we   => mem_0_we,
    addr => mem_0_addr,
    din  => mem_0_din,
    dout => mem_0_dout
  );
  
  U_mul_0: Mul32 port map(a => sig_14_2, b => sig_15_2, y => sig_2_9);
  U_add_0: Adder32 port map(a => sig_16_3, b => sig_17_3, y => sig_3_12);
  
  -- Muxes are not expanded here yet (next step: generate a process/case per mux).
  
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        state <= 0;
        done <= '0';
      else
        -- defaults each cycle
        r0_en <= '0';
        r1_en <= '0';
        r2_en <= '0';
        r3_en <= '0';
        r4_en <= '0';
        r5_en <= '0';
        r6_en <= '0';
        r7_en <= '0';
        r8_en <= '0';
        mem_0_en <= '0';
        mem_0_we <= '0';
        done <= '0';
        
        case state is
          when 0 =>
            -- TODO: assert reg enables for ops at time 0
            -- TODO: set mux selects for inputs used at time 0
            -- TODO: set RAM en/we/addr/din for loads/stores at time 0
            state <= state + 1;
          when 1 =>
            -- TODO: assert reg enables for ops at time 1
            -- TODO: set mux selects for inputs used at time 1
            -- TODO: set RAM en/we/addr/din for loads/stores at time 1
            state <= state + 1;
          when 2 =>
            -- TODO: assert reg enables for ops at time 2
            -- TODO: set mux selects for inputs used at time 2
            -- TODO: set RAM en/we/addr/din for loads/stores at time 2
            state <= state + 1;
          when 3 =>
            -- TODO: assert reg enables for ops at time 3
            -- TODO: set mux selects for inputs used at time 3
            -- TODO: set RAM en/we/addr/din for loads/stores at time 3
            state <= state + 1;
          when 4 =>
            -- TODO: assert reg enables for ops at time 4
            -- TODO: set mux selects for inputs used at time 4
            -- TODO: set RAM en/we/addr/din for loads/stores at time 4
            state <= state + 1;
          when 5 =>
            -- TODO: assert reg enables for ops at time 5
            -- TODO: set mux selects for inputs used at time 5
            -- TODO: set RAM en/we/addr/din for loads/stores at time 5
            state <= state + 1;
          when 6 =>
            done <= '1';
            if start = '0' then
              state <= 0;
            end if;
          when others => state <= 0;
        end case;
      end if;
    end if;
  end process;
end architecture;