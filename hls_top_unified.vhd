library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hls_top_unified is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    done  : out std_logic
  );
end entity;

architecture rtl of hls_top_unified is
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
  signal r9_q  : signed(31 downto 0);
  signal r9_en  : std_logic;
  
  signal sel_mem_0_addr : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  signal sel_mem_0_val : integer := 0;
  signal sel_mul_0_in0 : integer := 0;
  signal sel_mul_0_in1 : integer := 0;
  
  signal mem_0_en   : std_logic;
  signal mem_0_we   : std_logic;
  signal mem_0_addr : signed(31 downto 0);
  signal mem_0_din  : signed(31 downto 0);
  signal mem_0_dout : signed(31 downto 0);
  
  signal sig_0_4 : signed(31 downto 0);
  signal sig_0_5 : signed(31 downto 0);
  signal sig_0_7 : signed(31 downto 0);
  signal sig_0_8 : signed(31 downto 0);
  signal sig_0_10 : signed(31 downto 0);
  signal sig_0_12 : signed(31 downto 0);
  signal sig_1_6 : signed(31 downto 0);
  signal sig_1_11 : signed(31 downto 0);
  signal sig_2_9 : signed(31 downto 0);
  signal sig_3_13 : signed(31 downto 0);
  signal sig_4_14 : signed(31 downto 0);
  signal sig_5_14 : signed(31 downto 0);
  signal sig_6_15 : signed(31 downto 0);
  signal sig_7_16 : signed(31 downto 0);
  signal sig_8_14 : signed(31 downto 0);
  signal sig_9_17 : signed(31 downto 0);
  signal sig_10_14 : signed(31 downto 0);
  signal sig_11_18 : signed(31 downto 0);
  signal sig_12_19 : signed(31 downto 0);
  signal sig_13_17 : signed(31 downto 0);
  signal sig_14_1 : signed(31 downto 0);
  signal sig_15_2 : signed(31 downto 0);
  signal sig_16_2 : signed(31 downto 0);
  signal sig_17_1 : signed(31 downto 0);
  signal sig_18_3 : signed(31 downto 0);
  signal sig_19_3 : signed(31 downto 0);
  
  signal state : integer range 0 to 5 := 0;
  
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
    d   => sig_0_8,
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
    d   => sig_0_12,
    q   => r8_q
  );
  U_r9: Reg32 port map(
    clk => clk,
    en  => r9_en,
    d   => sig_3_13,
    q   => r9_q
  );
  
  U_mem_0: RamSimple port map(
    clk  => clk,
    en   => mem_0_en,
    we   => mem_0_we,
    addr => mem_0_addr,
    din  => mem_0_din,
    dout => mem_0_dout
  );
  
  U_add_0: Adder32 port map(a => sig_15_2, b => sig_16_2, y => sig_2_9);
  U_mul_0: Mul32 port map(a => sig_18_3, b => sig_19_3, y => sig_3_13);
  
  sig_0_4 <= to_signed(3, 32);
  sig_0_5 <= to_signed(0, 32);
  sig_0_7 <= to_signed(1, 32);
  sig_0_8 <= to_signed(1, 32);
  sig_0_10 <= to_signed(4, 32);
  sig_0_12 <= to_signed(2, 32);
  
  sig_1_6 <= mem_0_dout;
  sig_1_11 <= mem_0_dout;
  
  -- mem_0_addr mux driving sig_14_1
  process(all)
  begin
    case sel_mem_0_addr is
      when 0 => sig_14_1 <= r0_q;
      when 1 => sig_14_1 <= r1_q;
      when 2 => sig_14_1 <= r4_q;
      when 3 => sig_14_1 <= r6_q;
      when others => sig_14_1 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in0 mux driving sig_15_2
  process(all)
  begin
    case sel_add_0_in0 is
      when 0 => sig_15_2 <= r2_q;
      when others => sig_15_2 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in1 mux driving sig_16_2
  process(all)
  begin
    case sel_add_0_in1 is
      when 0 => sig_16_2 <= r3_q;
      when others => sig_16_2 <= (others => '0');
    end case;
  end process;
  
  -- mem_0_val mux driving sig_17_1
  process(all)
  begin
    case sel_mem_0_val is
      when 0 => sig_17_1 <= r5_q;
      when 1 => sig_17_1 <= r9_q;
      when others => sig_17_1 <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in0 mux driving sig_18_3
  process(all)
  begin
    case sel_mul_0_in0 is
      when 0 => sig_18_3 <= r7_q;
      when others => sig_18_3 <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in1 mux driving sig_19_3
  process(all)
  begin
    case sel_mul_0_in1 is
      when 0 => sig_19_3 <= r8_q;
      when others => sig_19_3 <= (others => '0');
    end case;
  end process;
  
  mem_0_addr <= sig_14_1;
  mem_0_din <= sig_17_1;
  
  -- State register
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        state <= 0;
      else
        case state is
          when 0 => state <= 1;
          when 1 => state <= 2;
          when 2 => state <= 3;
          when 3 => state <= 4;
          when 4 => state <= 5;
          when 5 => state <= 5;
          when others => state <= 0;
        end case;
      end if;
    end if;
  end process;
  
  -- Control decode (combinational)
  process(all)
  begin
    r0_en <= '0';
    r1_en <= '0';
    r2_en <= '0';
    r3_en <= '0';
    r4_en <= '0';
    r5_en <= '0';
    r6_en <= '0';
    r7_en <= '0';
    r8_en <= '0';
    r9_en <= '0';
    sel_mem_0_addr <= 0;
    sel_add_0_in0 <= 0;
    sel_add_0_in1 <= 0;
    sel_mem_0_val <= 0;
    sel_mul_0_in0 <= 0;
    sel_mul_0_in1 <= 0;
    mem_0_en <= '0';
    mem_0_we <= '0';
    done <= '0';
    
    case state is
      when 0 =>
        r0_en <= '1';
        r1_en <= '1';
        r3_en <= '1';
        r4_en <= '1';
        r6_en <= '1';
        r8_en <= '1';
      when 1 =>
        r2_en <= '1';
        sel_mem_0_addr <= 1;
        mem_0_en <= '1';
      when 2 =>
        r5_en <= '1';
        r7_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 0;
        sel_mem_0_addr <= 2;
        mem_0_en <= '1';
      when 3 =>
        r9_en <= '1';
        sel_mem_0_addr <= 0;
        sel_mem_0_val <= 0;
        sel_mul_0_in0 <= 0;
        sel_mul_0_in1 <= 0;
        mem_0_en <= '1';
        mem_0_we <= '1';
      when 4 =>
        sel_mem_0_addr <= 3;
        sel_mem_0_val <= 1;
        mem_0_en <= '1';
        mem_0_we <= '1';
      when 5 =>
        done <= '1';
      when others => null;
    end case;
  end process;
  
end architecture;