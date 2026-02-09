library ieee;
use ieee.std_logic_1164.all;

entity hls_top_unified_24 is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    done  : out std_logic
  );
end entity;

architecture rtl of hls_top_unified_24 is
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
  signal r8_q  : std_logic_vector(31 downto 0);
  signal r8_en  : std_logic;
  signal r9_q  : std_logic_vector(31 downto 0);
  signal r9_en  : std_logic;
  signal r10_q  : std_logic_vector(31 downto 0);
  signal r10_en  : std_logic;
  signal r11_q  : std_logic_vector(31 downto 0);
  signal r11_en  : std_logic;
  signal r12_q  : std_logic_vector(31 downto 0);
  signal r12_en  : std_logic;
  signal r13_q  : std_logic_vector(31 downto 0);
  signal r13_en  : std_logic;
  signal r14_q  : std_logic_vector(31 downto 0);
  signal r14_en  : std_logic;
  signal r15_q  : std_logic_vector(31 downto 0);
  signal r15_en  : std_logic;
  signal r16_q  : std_logic_vector(31 downto 0);
  signal r16_en  : std_logic;
  signal r17_q  : std_logic_vector(31 downto 0);
  signal r17_en  : std_logic;
  signal r18_q  : std_logic_vector(31 downto 0);
  signal r18_en  : std_logic;
  signal r19_q  : std_logic_vector(31 downto 0);
  signal r19_en  : std_logic;
  signal r20_q  : std_logic_vector(31 downto 0);
  signal r20_en  : std_logic;
  signal r21_q  : std_logic_vector(31 downto 0);
  signal r21_en  : std_logic;
  signal r22_q  : std_logic_vector(31 downto 0);
  signal r22_en  : std_logic;
  signal r23_q  : std_logic_vector(31 downto 0);
  signal r23_en  : std_logic;
  signal r24_q  : std_logic_vector(31 downto 0);
  signal r24_en  : std_logic;
  signal r25_q  : std_logic_vector(31 downto 0);
  signal r25_en  : std_logic;
  signal r26_q  : std_logic_vector(31 downto 0);
  signal r26_en  : std_logic;
  signal r27_q  : std_logic_vector(31 downto 0);
  signal r27_en  : std_logic;
  signal r28_q  : std_logic_vector(31 downto 0);
  signal r28_en  : std_logic;
  signal r29_q  : std_logic_vector(31 downto 0);
  signal r29_en  : std_logic;
  signal r30_q  : std_logic_vector(31 downto 0);
  signal r30_en  : std_logic;
  signal r31_q  : std_logic_vector(31 downto 0);
  signal r31_en  : std_logic;
  signal r32_q  : std_logic_vector(31 downto 0);
  signal r32_en  : std_logic;
  
  signal sel_mem_0_addr : integer := 0;
  signal sel_mem_1_addr : integer := 0;
  signal sel_mem_2_addr : integer := 0;
  signal sel_mul_0_in0 : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  signal sel_mul_0_in1 : integer := 0;
  signal sel_mem_2_val : integer := 0;
  
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
  signal mem_2_en   : std_logic;
  signal mem_2_we   : std_logic;
  signal mem_2_addr : std_logic_vector(31 downto 0);
  signal mem_2_din  : std_logic_vector(31 downto 0);
  signal mem_2_dout : std_logic_vector(31 downto 0);
  
  signal sig_0_39_in : std_logic_vector(31 downto 0);
  signal sig_0_40_in : std_logic_vector(31 downto 0);
  signal sig_0_41_in : std_logic_vector(31 downto 0);
  signal sig_1_6_d : std_logic_vector(31 downto 0);
  signal sig_1_7_d : std_logic_vector(31 downto 0);
  signal sig_1_10_d : std_logic_vector(31 downto 0);
  signal sig_1_13_d : std_logic_vector(31 downto 0);
  signal sig_1_15_d : std_logic_vector(31 downto 0);
  signal sig_1_18_d : std_logic_vector(31 downto 0);
  signal sig_1_21_d : std_logic_vector(31 downto 0);
  signal sig_1_23_d : std_logic_vector(31 downto 0);
  signal sig_1_26_d : std_logic_vector(31 downto 0);
  signal sig_1_29_d : std_logic_vector(31 downto 0);
  signal sig_1_31_d : std_logic_vector(31 downto 0);
  signal sig_1_34_d : std_logic_vector(31 downto 0);
  signal sig_1_37_d : std_logic_vector(31 downto 0);
  signal sig_2_8_d : std_logic_vector(31 downto 0);
  signal sig_2_11_d : std_logic_vector(31 downto 0);
  signal sig_2_14_d : std_logic_vector(31 downto 0);
  signal sig_2_16_d : std_logic_vector(31 downto 0);
  signal sig_2_19_d : std_logic_vector(31 downto 0);
  signal sig_2_22_d : std_logic_vector(31 downto 0);
  signal sig_2_24_d : std_logic_vector(31 downto 0);
  signal sig_2_27_d : std_logic_vector(31 downto 0);
  signal sig_2_30_d : std_logic_vector(31 downto 0);
  signal sig_2_32_d : std_logic_vector(31 downto 0);
  signal sig_2_35_d : std_logic_vector(31 downto 0);
  signal sig_2_38_d : std_logic_vector(31 downto 0);
  signal sig_3_45_in : std_logic_vector(31 downto 0);
  signal sig_3_12_d : std_logic_vector(31 downto 0);
  signal sig_3_46_in : std_logic_vector(31 downto 0);
  signal sig_3_20_d : std_logic_vector(31 downto 0);
  signal sig_3_28_d : std_logic_vector(31 downto 0);
  signal sig_3_36_d : std_logic_vector(31 downto 0);
  signal sig_4_9_d : std_logic_vector(31 downto 0);
  signal sig_4_44_in : std_logic_vector(31 downto 0);
  signal sig_4_17_d : std_logic_vector(31 downto 0);
  signal sig_4_25_d : std_logic_vector(31 downto 0);
  signal sig_4_33_d : std_logic_vector(31 downto 0);
  signal sig_6_42_in : std_logic_vector(31 downto 0);
  signal sig_7_43_in : std_logic_vector(31 downto 0);
  signal sig_8_44_in : std_logic_vector(31 downto 0);
  signal sig_9_43_in : std_logic_vector(31 downto 0);
  signal sig_10_42_in : std_logic_vector(31 downto 0);
  signal sig_11_45_in : std_logic_vector(31 downto 0);
  signal sig_12_43_in : std_logic_vector(31 downto 0);
  signal sig_13_42_in : std_logic_vector(31 downto 0);
  signal sig_14_45_in : std_logic_vector(31 downto 0);
  signal sig_15_42_in : std_logic_vector(31 downto 0);
  signal sig_16_45_in : std_logic_vector(31 downto 0);
  signal sig_17_43_in : std_logic_vector(31 downto 0);
  signal sig_18_42_in : std_logic_vector(31 downto 0);
  signal sig_19_45_in : std_logic_vector(31 downto 0);
  signal sig_20_43_in : std_logic_vector(31 downto 0);
  signal sig_21_42_in : std_logic_vector(31 downto 0);
  signal sig_22_45_in : std_logic_vector(31 downto 0);
  signal sig_23_42_in : std_logic_vector(31 downto 0);
  signal sig_24_45_in : std_logic_vector(31 downto 0);
  signal sig_25_43_in : std_logic_vector(31 downto 0);
  signal sig_26_42_in : std_logic_vector(31 downto 0);
  signal sig_27_45_in : std_logic_vector(31 downto 0);
  signal sig_28_43_in : std_logic_vector(31 downto 0);
  signal sig_29_42_in : std_logic_vector(31 downto 0);
  signal sig_30_45_in : std_logic_vector(31 downto 0);
  signal sig_31_42_in : std_logic_vector(31 downto 0);
  signal sig_32_45_in : std_logic_vector(31 downto 0);
  signal sig_33_43_in : std_logic_vector(31 downto 0);
  signal sig_34_42_in : std_logic_vector(31 downto 0);
  signal sig_35_45_in : std_logic_vector(31 downto 0);
  signal sig_36_43_in : std_logic_vector(31 downto 0);
  signal sig_37_42_in : std_logic_vector(31 downto 0);
  signal sig_38_45_in : std_logic_vector(31 downto 0);
  signal sig_39_1_addr : std_logic_vector(31 downto 0);
  signal sig_40_2_addr : std_logic_vector(31 downto 0);
  signal sig_41_5_addr : std_logic_vector(31 downto 0);
  signal sig_42_4_in0 : std_logic_vector(31 downto 0);
  signal sig_43_3_in0 : std_logic_vector(31 downto 0);
  signal sig_44_3_in1 : std_logic_vector(31 downto 0);
  signal sig_45_4_in1 : std_logic_vector(31 downto 0);
  signal sig_46_5_val : std_logic_vector(31 downto 0);
  
  
  signal add_0_y : std_logic_vector(31 downto 0);
  signal mul_0_y : std_logic_vector(31 downto 0);
  
  signal state : integer range 0 to 14 := 0;
  
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
  
  
  U_r0: Reg32 port map(
    clk => clk,
    en  => r0_en,
    d   => sig_1_6_d,
    q   => r0_q
  );
  U_r1: Reg32 port map(
    clk => clk,
    en  => r1_en,
    d   => sig_1_7_d,
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
    d   => sig_4_9_d,
    q   => r3_q
  );
  U_r4: Reg32 port map(
    clk => clk,
    en  => r4_en,
    d   => sig_1_10_d,
    q   => r4_q
  );
  U_r5: Reg32 port map(
    clk => clk,
    en  => r5_en,
    d   => sig_2_11_d,
    q   => r5_q
  );
  U_r6: Reg32 port map(
    clk => clk,
    en  => r6_en,
    d   => sig_3_12_d,
    q   => r6_q
  );
  U_r7: Reg32 port map(
    clk => clk,
    en  => r7_en,
    d   => sig_1_13_d,
    q   => r7_q
  );
  U_r8: Reg32 port map(
    clk => clk,
    en  => r8_en,
    d   => sig_2_14_d,
    q   => r8_q
  );
  U_r9: Reg32 port map(
    clk => clk,
    en  => r9_en,
    d   => sig_1_15_d,
    q   => r9_q
  );
  U_r10: Reg32 port map(
    clk => clk,
    en  => r10_en,
    d   => sig_2_16_d,
    q   => r10_q
  );
  U_r11: Reg32 port map(
    clk => clk,
    en  => r11_en,
    d   => sig_4_17_d,
    q   => r11_q
  );
  U_r12: Reg32 port map(
    clk => clk,
    en  => r12_en,
    d   => sig_1_18_d,
    q   => r12_q
  );
  U_r13: Reg32 port map(
    clk => clk,
    en  => r13_en,
    d   => sig_2_19_d,
    q   => r13_q
  );
  U_r14: Reg32 port map(
    clk => clk,
    en  => r14_en,
    d   => sig_3_20_d,
    q   => r14_q
  );
  U_r15: Reg32 port map(
    clk => clk,
    en  => r15_en,
    d   => sig_1_21_d,
    q   => r15_q
  );
  U_r16: Reg32 port map(
    clk => clk,
    en  => r16_en,
    d   => sig_2_22_d,
    q   => r16_q
  );
  U_r17: Reg32 port map(
    clk => clk,
    en  => r17_en,
    d   => sig_1_23_d,
    q   => r17_q
  );
  U_r18: Reg32 port map(
    clk => clk,
    en  => r18_en,
    d   => sig_2_24_d,
    q   => r18_q
  );
  U_r19: Reg32 port map(
    clk => clk,
    en  => r19_en,
    d   => sig_4_25_d,
    q   => r19_q
  );
  U_r20: Reg32 port map(
    clk => clk,
    en  => r20_en,
    d   => sig_1_26_d,
    q   => r20_q
  );
  U_r21: Reg32 port map(
    clk => clk,
    en  => r21_en,
    d   => sig_2_27_d,
    q   => r21_q
  );
  U_r22: Reg32 port map(
    clk => clk,
    en  => r22_en,
    d   => sig_3_28_d,
    q   => r22_q
  );
  U_r23: Reg32 port map(
    clk => clk,
    en  => r23_en,
    d   => sig_1_29_d,
    q   => r23_q
  );
  U_r24: Reg32 port map(
    clk => clk,
    en  => r24_en,
    d   => sig_2_30_d,
    q   => r24_q
  );
  U_r25: Reg32 port map(
    clk => clk,
    en  => r25_en,
    d   => sig_1_31_d,
    q   => r25_q
  );
  U_r26: Reg32 port map(
    clk => clk,
    en  => r26_en,
    d   => sig_2_32_d,
    q   => r26_q
  );
  U_r27: Reg32 port map(
    clk => clk,
    en  => r27_en,
    d   => sig_4_33_d,
    q   => r27_q
  );
  U_r28: Reg32 port map(
    clk => clk,
    en  => r28_en,
    d   => sig_1_34_d,
    q   => r28_q
  );
  U_r29: Reg32 port map(
    clk => clk,
    en  => r29_en,
    d   => sig_2_35_d,
    q   => r29_q
  );
  U_r30: Reg32 port map(
    clk => clk,
    en  => r30_en,
    d   => sig_3_36_d,
    q   => r30_q
  );
  U_r31: Reg32 port map(
    clk => clk,
    en  => r31_en,
    d   => sig_1_37_d,
    q   => r31_q
  );
  U_r32: Reg32 port map(
    clk => clk,
    en  => r32_en,
    d   => sig_2_38_d,
    q   => r32_q
  );
  
  U_mem_0: RamSimple
    generic map (
      ADDR_WIDTH => 10,
      DATA_WIDTH => 32,
      INIT_0 => 1,
      INIT_1 => 2,
      INIT_2 => 3,
      INIT_3 => 4,
      INIT_4 => 5,
      INIT_5 => 6,
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
      INIT_0 => 7,
      INIT_1 => 8,
      INIT_2 => 9,
      INIT_3 => 0,
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
  
  U_mem_2: RamSimple
    generic map (
      ADDR_WIDTH => 10,
      DATA_WIDTH => 32,
      INIT_0 => 0,
      INIT_1 => 0,
      INIT_2 => 0,
      INIT_3 => 0,
      INIT_4 => 0,
      INIT_5 => 0,
      INIT_6 => 0,
      INIT_7 => 0
    )
    port map (
      clk  => clk,
      en   => mem_2_en,
      we   => mem_2_we,
      addr => mem_2_addr(9 downto 0),
      din  => mem_2_din,
      dout => mem_2_dout
    );
  
  U_add_0: Adder32 port map(a => sig_43_3_in0, b => sig_44_3_in1, y => add_0_y);
  sig_3_45_in <= add_0_y;
  sig_3_12_d <= add_0_y;
  sig_3_46_in <= add_0_y;
  sig_3_20_d <= add_0_y;
  sig_3_28_d <= add_0_y;
  sig_3_36_d <= add_0_y;
  U_mul_0: Mul32 port map(a => sig_42_4_in0, b => sig_45_4_in1, y => mul_0_y);
  sig_4_9_d <= mul_0_y;
  sig_4_44_in <= mul_0_y;
  sig_4_17_d <= mul_0_y;
  sig_4_25_d <= mul_0_y;
  sig_4_33_d <= mul_0_y;
  
  
  sig_1_6_d <= mem_0_dout;
  sig_1_7_d <= mem_0_dout;
  sig_1_10_d <= mem_0_dout;
  sig_1_13_d <= mem_0_dout;
  sig_1_15_d <= mem_0_dout;
  sig_1_18_d <= mem_0_dout;
  sig_1_21_d <= mem_0_dout;
  sig_1_23_d <= mem_0_dout;
  sig_1_26_d <= mem_0_dout;
  sig_1_29_d <= mem_0_dout;
  sig_1_31_d <= mem_0_dout;
  sig_1_34_d <= mem_0_dout;
  sig_1_37_d <= mem_0_dout;
  sig_2_8_d <= mem_1_dout;
  sig_2_11_d <= mem_1_dout;
  sig_2_14_d <= mem_1_dout;
  sig_2_16_d <= mem_1_dout;
  sig_2_19_d <= mem_1_dout;
  sig_2_22_d <= mem_1_dout;
  sig_2_24_d <= mem_1_dout;
  sig_2_27_d <= mem_1_dout;
  sig_2_30_d <= mem_1_dout;
  sig_2_32_d <= mem_1_dout;
  sig_2_35_d <= mem_1_dout;
  sig_2_38_d <= mem_1_dout;
  
  -- mem_0_addr mux driving sig_39_1_addr
  process(all)
  begin
    case sel_mem_0_addr is
      when 0 => sig_39_1_addr <= x"00000000";
      when 1 => sig_39_1_addr <= x"00000001";
      when 2 => sig_39_1_addr <= x"00000002";
      when 3 => sig_39_1_addr <= x"00000003";
      when 4 => sig_39_1_addr <= x"00000004";
      when 5 => sig_39_1_addr <= x"00000005";
      when others => sig_39_1_addr <= (others => '0');
    end case;
  end process;
  
  -- mem_1_addr mux driving sig_40_2_addr
  process(all)
  begin
    case sel_mem_1_addr is
      when 0 => sig_40_2_addr <= x"00000000";
      when 1 => sig_40_2_addr <= x"00000001";
      when 2 => sig_40_2_addr <= x"00000002";
      when others => sig_40_2_addr <= (others => '0');
    end case;
  end process;
  
  -- mem_2_addr mux driving sig_41_5_addr
  process(all)
  begin
    case sel_mem_2_addr is
      when 0 => sig_41_5_addr <= x"00000000";
      when 1 => sig_41_5_addr <= x"00000001";
      when 2 => sig_41_5_addr <= x"00000002";
      when 3 => sig_41_5_addr <= x"00000003";
      when others => sig_41_5_addr <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in0 mux driving sig_42_4_in0
  process(all)
  begin
    case sel_mul_0_in0 is
      when 0 => sig_42_4_in0 <= r0_q;
      when 1 => sig_42_4_in0 <= r4_q;
      when 2 => sig_42_4_in0 <= r7_q;
      when 3 => sig_42_4_in0 <= r9_q;
      when 4 => sig_42_4_in0 <= r12_q;
      when 5 => sig_42_4_in0 <= r15_q;
      when 6 => sig_42_4_in0 <= r17_q;
      when 7 => sig_42_4_in0 <= r20_q;
      when 8 => sig_42_4_in0 <= r23_q;
      when 9 => sig_42_4_in0 <= r25_q;
      when 10 => sig_42_4_in0 <= r28_q;
      when 11 => sig_42_4_in0 <= r31_q;
      when others => sig_42_4_in0 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in0 mux driving sig_43_3_in0
  process(all)
  begin
    case sel_add_0_in0 is
      when 0 => sig_43_3_in0 <= r1_q;
      when 1 => sig_43_3_in0 <= r3_q;
      when 2 => sig_43_3_in0 <= r6_q;
      when 3 => sig_43_3_in0 <= r11_q;
      when 4 => sig_43_3_in0 <= r14_q;
      when 5 => sig_43_3_in0 <= r19_q;
      when 6 => sig_43_3_in0 <= r22_q;
      when 7 => sig_43_3_in0 <= r27_q;
      when 8 => sig_43_3_in0 <= r30_q;
      when others => sig_43_3_in0 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in1 mux driving sig_44_3_in1
  process(all)
  begin
    case sel_add_0_in1 is
      when 0 => sig_44_3_in1 <= r2_q;
      when 1 => sig_44_3_in1 <= sig_4_44_in;
      when 2 => sig_44_3_in1 <= sig_4_44_in;
      when 3 => sig_44_3_in1 <= sig_4_44_in;
      when 4 => sig_44_3_in1 <= sig_4_44_in;
      when 5 => sig_44_3_in1 <= sig_4_44_in;
      when 6 => sig_44_3_in1 <= sig_4_44_in;
      when 7 => sig_44_3_in1 <= sig_4_44_in;
      when 8 => sig_44_3_in1 <= sig_4_44_in;
      when others => sig_44_3_in1 <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in1 mux driving sig_45_4_in1
  process(all)
  begin
    case sel_mul_0_in1 is
      when 0 => sig_45_4_in1 <= sig_3_45_in;
      when 1 => sig_45_4_in1 <= r5_q;
      when 2 => sig_45_4_in1 <= r8_q;
      when 3 => sig_45_4_in1 <= r10_q;
      when 4 => sig_45_4_in1 <= r13_q;
      when 5 => sig_45_4_in1 <= r16_q;
      when 6 => sig_45_4_in1 <= r18_q;
      when 7 => sig_45_4_in1 <= r21_q;
      when 8 => sig_45_4_in1 <= r24_q;
      when 9 => sig_45_4_in1 <= r26_q;
      when 10 => sig_45_4_in1 <= r29_q;
      when 11 => sig_45_4_in1 <= r32_q;
      when others => sig_45_4_in1 <= (others => '0');
    end case;
  end process;
  
  -- mem_2_val mux driving sig_46_5_val
  process(all)
  begin
    case sel_mem_2_val is
      when 0 => sig_46_5_val <= sig_3_46_in;
      when 1 => sig_46_5_val <= sig_3_46_in;
      when 2 => sig_46_5_val <= sig_3_46_in;
      when 3 => sig_46_5_val <= sig_3_46_in;
      when others => sig_46_5_val <= (others => '0');
    end case;
  end process;
  
  mem_0_addr <= sig_39_1_addr;
  mem_1_addr <= sig_40_2_addr;
  mem_2_addr <= sig_41_5_addr;
  mem_2_din <= sig_46_5_val;
  
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
    r13_en <= '0';
    r14_en <= '0';
    r15_en <= '0';
    r16_en <= '0';
    r17_en <= '0';
    r18_en <= '0';
    r19_en <= '0';
    r2_en <= '0';
    r20_en <= '0';
    r21_en <= '0';
    r22_en <= '0';
    r23_en <= '0';
    r24_en <= '0';
    r25_en <= '0';
    r26_en <= '0';
    r27_en <= '0';
    r28_en <= '0';
    r29_en <= '0';
    r3_en <= '0';
    r30_en <= '0';
    r31_en <= '0';
    r32_en <= '0';
    r4_en <= '0';
    r5_en <= '0';
    r6_en <= '0';
    r7_en <= '0';
    r8_en <= '0';
    r9_en <= '0';
    sel_mem_0_addr <= 0;
    sel_mem_1_addr <= 0;
    sel_mem_2_addr <= 0;
    sel_mul_0_in0 <= 0;
    sel_add_0_in0 <= 0;
    sel_add_0_in1 <= 0;
    sel_mul_0_in1 <= 0;
    sel_mem_2_val <= 0;
    mem_0_en <= '0';
    mem_0_we <= '0';
    mem_1_en <= '0';
    mem_1_we <= '0';
    mem_2_en <= '0';
    mem_2_we <= '0';
    done <= '0';
    
    case state is
      when 0 =>
        r0_en <= '1';
        r2_en <= '1';
        sel_mem_0_addr <= 0;
        sel_mem_1_addr <= 0;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 1 =>
        r1_en <= '1';
        r5_en <= '1';
        sel_mem_0_addr <= 0;
        sel_mem_1_addr <= 1;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 2 =>
        r3_en <= '1';
        r4_en <= '1';
        r8_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 0;
        sel_mem_0_addr <= 1;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 0;
        sel_mul_0_in1 <= 0;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 3 =>
        r10_en <= '1';
        r6_en <= '1';
        r7_en <= '1';
        sel_add_0_in0 <= 1;
        sel_add_0_in1 <= 1;
        sel_mem_0_addr <= 2;
        sel_mem_1_addr <= 0;
        sel_mul_0_in0 <= 1;
        sel_mul_0_in1 <= 1;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 4 =>
        r13_en <= '1';
        r9_en <= '1';
        sel_add_0_in0 <= 2;
        sel_add_0_in1 <= 2;
        sel_mem_0_addr <= 1;
        sel_mem_1_addr <= 1;
        sel_mem_2_addr <= 0;
        sel_mem_2_val <= 0;
        sel_mul_0_in0 <= 2;
        sel_mul_0_in1 <= 2;
        mem_0_en <= '1';
        mem_1_en <= '1';
        mem_2_en <= '1';
        mem_2_we <= '1';
      when 5 =>
        r11_en <= '1';
        r12_en <= '1';
        r16_en <= '1';
        sel_mem_0_addr <= 2;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 3;
        sel_mul_0_in1 <= 3;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 6 =>
        r14_en <= '1';
        r15_en <= '1';
        r18_en <= '1';
        sel_add_0_in0 <= 3;
        sel_add_0_in1 <= 3;
        sel_mem_0_addr <= 3;
        sel_mem_1_addr <= 0;
        sel_mul_0_in0 <= 4;
        sel_mul_0_in1 <= 4;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 7 =>
        r17_en <= '1';
        r21_en <= '1';
        sel_add_0_in0 <= 4;
        sel_add_0_in1 <= 4;
        sel_mem_0_addr <= 2;
        sel_mem_1_addr <= 1;
        sel_mem_2_addr <= 1;
        sel_mem_2_val <= 1;
        sel_mul_0_in0 <= 5;
        sel_mul_0_in1 <= 5;
        mem_0_en <= '1';
        mem_1_en <= '1';
        mem_2_en <= '1';
        mem_2_we <= '1';
      when 8 =>
        r19_en <= '1';
        r20_en <= '1';
        r24_en <= '1';
        sel_mem_0_addr <= 3;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 6;
        sel_mul_0_in1 <= 6;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 9 =>
        r22_en <= '1';
        r23_en <= '1';
        r26_en <= '1';
        sel_add_0_in0 <= 5;
        sel_add_0_in1 <= 5;
        sel_mem_0_addr <= 4;
        sel_mem_1_addr <= 0;
        sel_mul_0_in0 <= 7;
        sel_mul_0_in1 <= 7;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 10 =>
        r25_en <= '1';
        r29_en <= '1';
        sel_add_0_in0 <= 6;
        sel_add_0_in1 <= 6;
        sel_mem_0_addr <= 3;
        sel_mem_1_addr <= 1;
        sel_mem_2_addr <= 2;
        sel_mem_2_val <= 2;
        sel_mul_0_in0 <= 8;
        sel_mul_0_in1 <= 8;
        mem_0_en <= '1';
        mem_1_en <= '1';
        mem_2_en <= '1';
        mem_2_we <= '1';
      when 11 =>
        r27_en <= '1';
        r28_en <= '1';
        r32_en <= '1';
        sel_mem_0_addr <= 4;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 9;
        sel_mul_0_in1 <= 9;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 12 =>
        r30_en <= '1';
        r31_en <= '1';
        sel_add_0_in0 <= 7;
        sel_add_0_in1 <= 7;
        sel_mem_0_addr <= 5;
        sel_mul_0_in0 <= 10;
        sel_mul_0_in1 <= 10;
        mem_0_en <= '1';
      when 13 =>
        sel_add_0_in0 <= 8;
        sel_add_0_in1 <= 8;
        sel_mem_2_addr <= 3;
        sel_mem_2_val <= 3;
        sel_mul_0_in0 <= 11;
        sel_mul_0_in1 <= 11;
        mem_2_en <= '1';
        mem_2_we <= '1';
      when 14 =>
        done <= '1';
      when others => null;
    end case;
  end process;
  
end architecture;