library ieee;
use ieee.std_logic_1164.all;

entity hls_top_unified_23 is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    done  : out std_logic
  );
end entity;

architecture rtl of hls_top_unified_23 is
  signal r0_q  : std_logic_vector(31 downto 0);
  signal r0_en  : std_logic;
  signal r1_q  : std_logic_vector(31 downto 0);
  signal r1_en  : std_logic;
  signal r2_q  : std_logic_vector(31 downto 0);
  signal r2_en  : std_logic;
  signal r3_q  : std_logic_vector(31 downto 0);
  signal r3_en  : std_logic;
  signal r4_q  : std_logic_vector(31 downto 0);
  signal r4_en  : std_logic;
  signal r5_q  : std_logic_vector(31 downto 0);
  signal r5_en  : std_logic;
  signal r6_q  : std_logic_vector(31 downto 0);
  signal r6_en  : std_logic;
  signal r7_q  : std_logic_vector(31 downto 0);
  signal r7_en  : std_logic;
  
  signal sel_var_s_val : integer := 0;
  signal sel_mem_0_addr : integer := 0;
  signal sel_mem_1_addr : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  signal sel_mul_0_in0 : integer := 0;
  signal sel_mul_0_in1 : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  
  signal mem_0_en   : std_logic;
  signal mem_0_we   : std_logic;
  signal mem_0_addr : std_logic_vector(31 downto 0);
  signal mem_0_din  : std_logic_vector(31 downto 0);
  signal mem_0_dout : std_logic_vector(31 downto 0);
  signal mem_1_en   : std_logic;
  signal mem_1_we   : std_logic;
  signal mem_1_addr : std_logic_vector(31 downto 0);
  signal mem_1_din  : std_logic_vector(31 downto 0);
  signal mem_1_dout : std_logic_vector(31 downto 0);
  
  signal sig_0_14_in : std_logic_vector(31 downto 0);
  signal sig_0_15_in : std_logic_vector(31 downto 0);
  signal sig_0_16_in : std_logic_vector(31 downto 0);
  signal sig_1_17_in : std_logic_vector(31 downto 0);
  signal sig_2_6_d : std_logic_vector(31 downto 0);
  signal sig_2_8_d : std_logic_vector(31 downto 0);
  signal sig_2_10_d : std_logic_vector(31 downto 0);
  signal sig_2_12_d : std_logic_vector(31 downto 0);
  signal sig_3_7_d : std_logic_vector(31 downto 0);
  signal sig_3_9_d : std_logic_vector(31 downto 0);
  signal sig_3_11_d : std_logic_vector(31 downto 0);
  signal sig_3_13_d : std_logic_vector(31 downto 0);
  signal sig_4_20_in : std_logic_vector(31 downto 0);
  signal sig_5_14_in : std_logic_vector(31 downto 0);
  signal sig_6_18_in : std_logic_vector(31 downto 0);
  signal sig_7_19_in : std_logic_vector(31 downto 0);
  signal sig_8_18_in : std_logic_vector(31 downto 0);
  signal sig_9_19_in : std_logic_vector(31 downto 0);
  signal sig_10_18_in : std_logic_vector(31 downto 0);
  signal sig_11_19_in : std_logic_vector(31 downto 0);
  signal sig_12_18_in : std_logic_vector(31 downto 0);
  signal sig_13_19_in : std_logic_vector(31 downto 0);
  signal sig_14_1_val : std_logic_vector(31 downto 0);
  signal sig_15_2_addr : std_logic_vector(31 downto 0);
  signal sig_16_3_addr : std_logic_vector(31 downto 0);
  signal sig_17_5_in0 : std_logic_vector(31 downto 0);
  signal sig_18_4_in0 : std_logic_vector(31 downto 0);
  signal sig_19_4_in1 : std_logic_vector(31 downto 0);
  signal sig_20_5_in1 : std_logic_vector(31 downto 0);
  
  signal var_s_en : std_logic;
  signal var_s_d  : std_logic_vector(31 downto 0);
  signal var_s_q  : std_logic_vector(31 downto 0);
  
  signal mul_0_y : std_logic_vector(31 downto 0);
  signal add_0_y : std_logic_vector(31 downto 0);
  
  signal state : integer range 0 to 5 := 0;
  
  -- Component declarations (assumed to exist)
  component Reg32 is
    port(clk: in std_logic; en: in std_logic; d: in std_logic_vector(31 downto 0); q: out std_logic_vector(31 downto 0));
  end component;
  
  component Adder32 is
    port(a: in std_logic_vector(31 downto 0); b: in std_logic_vector(31 downto 0); y: out std_logic_vector(31 downto 0));
  end component;
  
  component Mul32 is
    port(a: in std_logic_vector(31 downto 0); b: in std_logic_vector(31 downto 0); y: out std_logic_vector(31 downto 0));
  end component;
  
  component RamSimple is
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
  end component;
  
begin
  U_var_s: Reg32 port map(
    clk => clk,
    en  => var_s_en,
    d   => var_s_d,
    q   => var_s_q
  );
  
  sig_1_17_in <= var_s_q;
  
  U_r0: Reg32 port map(
    clk => clk,
    en  => r0_en,
    d   => sig_2_6_d,
    q   => r0_q
  );
  U_r1: Reg32 port map(
    clk => clk,
    en  => r1_en,
    d   => sig_3_7_d,
    q   => r1_q
  );
  U_r2: Reg32 port map(
    clk => clk,
    en  => r2_en,
    d   => sig_2_8_d,
    q   => r2_q
  );
  U_r3: Reg32 port map(
    clk => clk,
    en  => r3_en,
    d   => sig_3_9_d,
    q   => r3_q
  );
  U_r4: Reg32 port map(
    clk => clk,
    en  => r4_en,
    d   => sig_2_10_d,
    q   => r4_q
  );
  U_r5: Reg32 port map(
    clk => clk,
    en  => r5_en,
    d   => sig_3_11_d,
    q   => r5_q
  );
  U_r6: Reg32 port map(
    clk => clk,
    en  => r6_en,
    d   => sig_2_12_d,
    q   => r6_q
  );
  U_r7: Reg32 port map(
    clk => clk,
    en  => r7_en,
    d   => sig_3_13_d,
    q   => r7_q
  );
  
  U_mem_0: RamSimple
    generic map (
      ADDR_WIDTH => 10,
      DATA_WIDTH => 32,
      INIT_0 => 7,
      INIT_1 => 5,
      INIT_2 => 11,
      INIT_3 => 0,
      INIT_4 => 0,
      INIT_5 => 0,
      INIT_6 => 0,
      INIT_7 => 0
    )
    port map (
      clk  => clk,
      en   => mem_0_en,
      we   => mem_0_we,
      addr => mem_0_addr(9 downto 0),
      din  => mem_0_din,
      dout => mem_0_dout
    );
  
  U_mem_1: RamSimple
    generic map (
      ADDR_WIDTH => 10,
      DATA_WIDTH => 32,
      INIT_0 => 1,
      INIT_1 => 2,
      INIT_2 => 3,
      INIT_3 => 4,
      INIT_4 => 0,
      INIT_5 => 0,
      INIT_6 => 0,
      INIT_7 => 0
    )
    port map (
      clk  => clk,
      en   => mem_1_en,
      we   => mem_1_we,
      addr => mem_1_addr(9 downto 0),
      din  => mem_1_din,
      dout => mem_1_dout
    );
  
  U_mul_0: Mul32 port map(a => sig_18_4_in0, b => sig_19_4_in1, y => mul_0_y);
  sig_4_20_in <= mul_0_y;
  U_add_0: Adder32 port map(a => sig_17_5_in0, b => sig_20_5_in1, y => add_0_y);
  sig_5_14_in <= add_0_y;
  
  var_s_d <= sig_14_1_val;
  
  sig_2_6_d <= mem_0_dout;
  sig_2_8_d <= mem_0_dout;
  sig_2_10_d <= mem_0_dout;
  sig_2_12_d <= mem_0_dout;
  sig_3_7_d <= mem_1_dout;
  sig_3_9_d <= mem_1_dout;
  sig_3_11_d <= mem_1_dout;
  sig_3_13_d <= mem_1_dout;
  
  -- var_s_val mux driving sig_14_1_val
  process(all)
  begin
    case sel_var_s_val is
      when 0 => sig_14_1_val <= x"00000000";
      when 1 => sig_14_1_val <= sig_5_14_in;
      when 2 => sig_14_1_val <= sig_5_14_in;
      when 3 => sig_14_1_val <= sig_5_14_in;
      when 4 => sig_14_1_val <= sig_5_14_in;
      when others => sig_14_1_val <= (others => '0');
    end case;
  end process;
  
  -- mem_0_addr mux driving sig_15_2_addr
  process(all)
  begin
    case sel_mem_0_addr is
      when 0 => sig_15_2_addr <= x"00000000";
      when 1 => sig_15_2_addr <= x"00000001";
      when 2 => sig_15_2_addr <= x"00000002";
      when 3 => sig_15_2_addr <= x"00000003";
      when others => sig_15_2_addr <= (others => '0');
    end case;
  end process;
  
  -- mem_1_addr mux driving sig_16_3_addr
  process(all)
  begin
    case sel_mem_1_addr is
      when 0 => sig_16_3_addr <= x"00000000";
      when 1 => sig_16_3_addr <= x"00000001";
      when 2 => sig_16_3_addr <= x"00000002";
      when 3 => sig_16_3_addr <= x"00000003";
      when others => sig_16_3_addr <= (others => '0');
    end case;
  end process;
  
  -- add_0_in0 mux driving sig_17_5_in0
  process(all)
  begin
    case sel_add_0_in0 is
      when 0 => sig_17_5_in0 <= var_s_q;
      when others => sig_17_5_in0 <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in0 mux driving sig_18_4_in0
  process(all)
  begin
    case sel_mul_0_in0 is
      when 0 => sig_18_4_in0 <= r0_q;
      when 1 => sig_18_4_in0 <= r2_q;
      when 2 => sig_18_4_in0 <= r4_q;
      when 3 => sig_18_4_in0 <= r6_q;
      when others => sig_18_4_in0 <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in1 mux driving sig_19_4_in1
  process(all)
  begin
    case sel_mul_0_in1 is
      when 0 => sig_19_4_in1 <= r1_q;
      when 1 => sig_19_4_in1 <= r3_q;
      when 2 => sig_19_4_in1 <= r5_q;
      when 3 => sig_19_4_in1 <= r7_q;
      when others => sig_19_4_in1 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in1 mux driving sig_20_5_in1
  process(all)
  begin
    case sel_add_0_in1 is
      when 0 => sig_20_5_in1 <= sig_4_20_in;
      when 1 => sig_20_5_in1 <= sig_4_20_in;
      when 2 => sig_20_5_in1 <= sig_4_20_in;
      when 3 => sig_20_5_in1 <= sig_4_20_in;
      when others => sig_20_5_in1 <= (others => '0');
    end case;
  end process;
  
  mem_0_addr <= sig_15_2_addr;
  mem_1_addr <= sig_16_3_addr;
  
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
    sel_var_s_val <= 0;
    sel_mem_0_addr <= 0;
    sel_mem_1_addr <= 0;
    sel_add_0_in0 <= 0;
    sel_mul_0_in0 <= 0;
    sel_mul_0_in1 <= 0;
    sel_add_0_in1 <= 0;
    mem_0_en <= '0';
    mem_0_we <= '0';
    mem_1_en <= '0';
    mem_1_we <= '0';
    var_s_en <= '0';
    done <= '0';
    
    case state is
      when 0 =>
        r0_en <= '1';
        r1_en <= '1';
        sel_mem_0_addr <= 0;
        sel_mem_1_addr <= 0;
        sel_var_s_val <= 0;
        mem_0_en <= '1';
        mem_1_en <= '1';
        var_s_en <= '1';
      when 1 =>
        r2_en <= '1';
        r3_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 0;
        sel_mem_0_addr <= 1;
        sel_mem_1_addr <= 1;
        sel_mul_0_in0 <= 0;
        sel_mul_0_in1 <= 0;
        sel_var_s_val <= 1;
        mem_0_en <= '1';
        mem_1_en <= '1';
        var_s_en <= '1';
      when 2 =>
        r4_en <= '1';
        r5_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 1;
        sel_mem_0_addr <= 2;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 1;
        sel_mul_0_in1 <= 1;
        sel_var_s_val <= 2;
        mem_0_en <= '1';
        mem_1_en <= '1';
        var_s_en <= '1';
      when 3 =>
        r6_en <= '1';
        r7_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 2;
        sel_mem_0_addr <= 3;
        sel_mem_1_addr <= 3;
        sel_mul_0_in0 <= 2;
        sel_mul_0_in1 <= 2;
        sel_var_s_val <= 3;
        mem_0_en <= '1';
        mem_1_en <= '1';
        var_s_en <= '1';
      when 4 =>
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 3;
        sel_mul_0_in0 <= 3;
        sel_mul_0_in1 <= 3;
        sel_var_s_val <= 4;
        var_s_en <= '1';
      when 5 =>
        done <= '1';
      when others => null;
    end case;
  end process;
  
end architecture;