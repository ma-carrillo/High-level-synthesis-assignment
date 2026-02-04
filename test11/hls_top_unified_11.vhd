library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hls_top_unified_11 is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    done  : out std_logic
  );
end entity;

architecture rtl of hls_top_unified_11 is
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
  signal r10_q  : signed(31 downto 0);
  signal r10_en  : std_logic;
  signal r11_q  : signed(31 downto 0);
  signal r11_en  : std_logic;
  signal r12_q  : signed(31 downto 0);
  signal r12_en  : std_logic;
  
  signal sel_var_s_val : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  
  
  signal sig_0_3 : signed(31 downto 0);
  signal sig_0_4 : signed(31 downto 0);
  signal sig_0_8 : signed(31 downto 0);
  signal sig_0_11 : signed(31 downto 0);
  signal sig_0_14 : signed(31 downto 0);
  signal sig_1_5 : signed(31 downto 0);
  signal sig_1_7 : signed(31 downto 0);
  signal sig_1_10 : signed(31 downto 0);
  signal sig_1_13 : signed(31 downto 0);
  signal sig_2_6 : signed(31 downto 0);
  signal sig_2_9 : signed(31 downto 0);
  signal sig_2_12 : signed(31 downto 0);
  signal sig_2_15 : signed(31 downto 0);
  signal sig_3_16 : signed(31 downto 0);
  signal sig_4_17 : signed(31 downto 0);
  signal sig_5_18 : signed(31 downto 0);
  signal sig_6_16 : signed(31 downto 0);
  signal sig_7_18 : signed(31 downto 0);
  signal sig_8_17 : signed(31 downto 0);
  signal sig_9_16 : signed(31 downto 0);
  signal sig_10_18 : signed(31 downto 0);
  signal sig_11_17 : signed(31 downto 0);
  signal sig_12_16 : signed(31 downto 0);
  signal sig_13_18 : signed(31 downto 0);
  signal sig_14_17 : signed(31 downto 0);
  signal sig_15_16 : signed(31 downto 0);
  signal sig_16_1 : signed(31 downto 0);
  signal sig_17_2 : signed(31 downto 0);
  signal sig_18_2 : signed(31 downto 0);
  
  signal var_s_en : std_logic;
  signal var_s_d  : signed(31 downto 0);
  signal var_s_q  : signed(31 downto 0);
  
  signal add_0_y : signed(31 downto 0);
  
  signal state : integer range 0 to 14 := 0;
  
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
      addr : in  signed(ADDR_WIDTH-1 downto 0);
      din  : in  signed(DATA_WIDTH-1 downto 0);
      dout : out signed(DATA_WIDTH-1 downto 0)
    );
  end component;
  
begin
  U_var_s: Reg32 port map(
    clk => clk,
    en  => var_s_en,
    d   => var_s_d,
    q   => var_s_q
  );
  
  sig_1_5 <= var_s_q;
  sig_1_7 <= var_s_q;
  sig_1_10 <= var_s_q;
  sig_1_13 <= var_s_q;
  
  U_r0: Reg32 port map(
    clk => clk,
    en  => r0_en,
    d   => sig_0_3,
    q   => r0_q
  );
  U_r1: Reg32 port map(
    clk => clk,
    en  => r1_en,
    d   => sig_0_4,
    q   => r1_q
  );
  U_r2: Reg32 port map(
    clk => clk,
    en  => r2_en,
    d   => sig_1_5,
    q   => r2_q
  );
  U_r3: Reg32 port map(
    clk => clk,
    en  => r3_en,
    d   => sig_2_6,
    q   => r3_q
  );
  U_r4: Reg32 port map(
    clk => clk,
    en  => r4_en,
    d   => sig_1_7,
    q   => r4_q
  );
  U_r5: Reg32 port map(
    clk => clk,
    en  => r5_en,
    d   => sig_0_8,
    q   => r5_q
  );
  U_r6: Reg32 port map(
    clk => clk,
    en  => r6_en,
    d   => sig_2_9,
    q   => r6_q
  );
  U_r7: Reg32 port map(
    clk => clk,
    en  => r7_en,
    d   => sig_1_10,
    q   => r7_q
  );
  U_r8: Reg32 port map(
    clk => clk,
    en  => r8_en,
    d   => sig_0_11,
    q   => r8_q
  );
  U_r9: Reg32 port map(
    clk => clk,
    en  => r9_en,
    d   => sig_2_12,
    q   => r9_q
  );
  U_r10: Reg32 port map(
    clk => clk,
    en  => r10_en,
    d   => sig_1_13,
    q   => r10_q
  );
  U_r11: Reg32 port map(
    clk => clk,
    en  => r11_en,
    d   => sig_0_14,
    q   => r11_q
  );
  U_r12: Reg32 port map(
    clk => clk,
    en  => r12_en,
    d   => sig_2_15,
    q   => r12_q
  );
  
  U_add_0: Adder32 port map(a => sig_18_2, b => sig_17_2, y => add_0_y);
  sig_2_6 <= add_0_y;
  sig_2_9 <= add_0_y;
  sig_2_12 <= add_0_y;
  sig_2_15 <= add_0_y;
  
  var_s_d <= sig_16_1;
  sig_0_3 <= to_signed(0, 32);
  sig_0_4 <= to_signed(0, 32);
  sig_0_8 <= to_signed(1, 32);
  sig_0_11 <= to_signed(2, 32);
  sig_0_14 <= to_signed(3, 32);
  
  
  -- var_s_val mux driving sig_16_1
  process(all)
  begin
    case sel_var_s_val is
      when 0 => sig_16_1 <= r0_q;
      when 1 => sig_16_1 <= r3_q;
      when 2 => sig_16_1 <= r6_q;
      when 3 => sig_16_1 <= r9_q;
      when 4 => sig_16_1 <= r12_q;
      when others => sig_16_1 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in1 mux driving sig_17_2
  process(all)
  begin
    case sel_add_0_in1 is
      when 0 => sig_17_2 <= r1_q;
      when 1 => sig_17_2 <= r5_q;
      when 2 => sig_17_2 <= r8_q;
      when 3 => sig_17_2 <= r11_q;
      when others => sig_17_2 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in0 mux driving sig_18_2
  process(all)
  begin
    case sel_add_0_in0 is
      when 0 => sig_18_2 <= r2_q;
      when 1 => sig_18_2 <= r4_q;
      when 2 => sig_18_2 <= r7_q;
      when 3 => sig_18_2 <= r10_q;
      when others => sig_18_2 <= (others => '0');
    end case;
  end process;
  
  
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
          when 5 => state <= 6;
          when 6 => state <= 7;
          when 7 => state <= 8;
          when 8 => state <= 9;
          when 9 => state <= 10;
          when 10 => state <= 11;
          when 11 => state <= 12;
          when 12 => state <= 13;
          when 13 => state <= 14;
          when 14 => state <= 14;
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
    r10_en <= '0';
    r11_en <= '0';
    r12_en <= '0';
    r2_en <= '0';
    r3_en <= '0';
    r4_en <= '0';
    r5_en <= '0';
    r6_en <= '0';
    r7_en <= '0';
    r8_en <= '0';
    r9_en <= '0';
    sel_var_s_val <= 0;
    sel_add_0_in1 <= 0;
    sel_add_0_in0 <= 0;
    var_s_en <= '0';
    done <= '0';
    
    case state is
      when 0 =>
        r0_en <= '1';
        r1_en <= '1';
        r11_en <= '1';
        r5_en <= '1';
        r8_en <= '1';
      when 1 =>
        sel_var_s_val <= 0;
        var_s_en <= '1';
      when 2 =>
        r2_en <= '1';
      when 3 =>
        r3_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 0;
      when 4 =>
        sel_var_s_val <= 1;
        var_s_en <= '1';
      when 5 =>
        r4_en <= '1';
      when 6 =>
        r6_en <= '1';
        sel_add_0_in0 <= 1;
        sel_add_0_in1 <= 1;
      when 7 =>
        sel_var_s_val <= 2;
        var_s_en <= '1';
      when 8 =>
        r7_en <= '1';
      when 9 =>
        r9_en <= '1';
        sel_add_0_in0 <= 2;
        sel_add_0_in1 <= 2;
      when 10 =>
        sel_var_s_val <= 3;
        var_s_en <= '1';
      when 11 =>
        r10_en <= '1';
      when 12 =>
        r12_en <= '1';
        sel_add_0_in0 <= 3;
        sel_add_0_in1 <= 3;
      when 13 =>
        sel_var_s_val <= 4;
        var_s_en <= '1';
      when 14 =>
        done <= '1';
      when others => null;
    end case;
  end process;
  
end architecture;