library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hls_top_unified_24 is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    done  : out std_logic
  );
end entity;

architecture rtl of hls_top_unified_24 is
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
  signal r13_q  : signed(31 downto 0);
  signal r13_en  : std_logic;
  signal r14_q  : signed(31 downto 0);
  signal r14_en  : std_logic;
  signal r15_q  : signed(31 downto 0);
  signal r15_en  : std_logic;
  signal r16_q  : signed(31 downto 0);
  signal r16_en  : std_logic;
  signal r17_q  : signed(31 downto 0);
  signal r17_en  : std_logic;
  signal r18_q  : signed(31 downto 0);
  signal r18_en  : std_logic;
  signal r19_q  : signed(31 downto 0);
  signal r19_en  : std_logic;
  signal r20_q  : signed(31 downto 0);
  signal r20_en  : std_logic;
  signal r21_q  : signed(31 downto 0);
  signal r21_en  : std_logic;
  signal r22_q  : signed(31 downto 0);
  signal r22_en  : std_logic;
  signal r23_q  : signed(31 downto 0);
  signal r23_en  : std_logic;
  signal r24_q  : signed(31 downto 0);
  signal r24_en  : std_logic;
  signal r25_q  : signed(31 downto 0);
  signal r25_en  : std_logic;
  signal r26_q  : signed(31 downto 0);
  signal r26_en  : std_logic;
  signal r27_q  : signed(31 downto 0);
  signal r27_en  : std_logic;
  signal r28_q  : signed(31 downto 0);
  signal r28_en  : std_logic;
  signal r29_q  : signed(31 downto 0);
  signal r29_en  : std_logic;
  signal r30_q  : signed(31 downto 0);
  signal r30_en  : std_logic;
  signal r31_q  : signed(31 downto 0);
  signal r31_en  : std_logic;
  signal r32_q  : signed(31 downto 0);
  signal r32_en  : std_logic;
  signal r33_q  : signed(31 downto 0);
  signal r33_en  : std_logic;
  signal r34_q  : signed(31 downto 0);
  signal r34_en  : std_logic;
  signal r35_q  : signed(31 downto 0);
  signal r35_en  : std_logic;
  signal r36_q  : signed(31 downto 0);
  signal r36_en  : std_logic;
  signal r37_q  : signed(31 downto 0);
  signal r37_en  : std_logic;
  
  signal sel_mem_0_addr : integer := 0;
  signal sel_mem_1_addr : integer := 0;
  signal sel_mem_2_addr : integer := 0;
  signal sel_mul_0_in0 : integer := 0;
  signal sel_mul_0_in1 : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  signal sel_mem_2_val : integer := 0;
  
  signal mem_0_en   : std_logic;
  signal mem_0_we   : std_logic;
  signal mem_0_addr : signed(31 downto 0);
  signal mem_0_din  : signed(31 downto 0);
  signal mem_0_dout : signed(31 downto 0);
  signal mem_1_en   : std_logic;
  signal mem_1_we   : std_logic;
  signal mem_1_addr : signed(31 downto 0);
  signal mem_1_din  : signed(31 downto 0);
  signal mem_1_dout : signed(31 downto 0);
  signal mem_2_en   : std_logic;
  signal mem_2_we   : std_logic;
  signal mem_2_addr : signed(31 downto 0);
  signal mem_2_din  : signed(31 downto 0);
  signal mem_2_dout : signed(31 downto 0);
  
  signal sig_0_6_d : signed(31 downto 0);
  signal sig_0_7_d : signed(31 downto 0);
  signal sig_0_46_in : signed(31 downto 0);
  signal sig_0_45_in : signed(31 downto 0);
  signal sig_0_44_in : signed(31 downto 0);
  signal sig_1_8_d : signed(31 downto 0);
  signal sig_1_10_d : signed(31 downto 0);
  signal sig_1_13_d : signed(31 downto 0);
  signal sig_1_17_d : signed(31 downto 0);
  signal sig_1_19_d : signed(31 downto 0);
  signal sig_1_22_d : signed(31 downto 0);
  signal sig_1_26_d : signed(31 downto 0);
  signal sig_1_28_d : signed(31 downto 0);
  signal sig_1_31_d : signed(31 downto 0);
  signal sig_1_35_d : signed(31 downto 0);
  signal sig_1_37_d : signed(31 downto 0);
  signal sig_1_40_d : signed(31 downto 0);
  signal sig_2_9_d : signed(31 downto 0);
  signal sig_2_11_d : signed(31 downto 0);
  signal sig_2_14_d : signed(31 downto 0);
  signal sig_2_18_d : signed(31 downto 0);
  signal sig_2_20_d : signed(31 downto 0);
  signal sig_2_23_d : signed(31 downto 0);
  signal sig_2_27_d : signed(31 downto 0);
  signal sig_2_29_d : signed(31 downto 0);
  signal sig_2_32_d : signed(31 downto 0);
  signal sig_2_36_d : signed(31 downto 0);
  signal sig_2_38_d : signed(31 downto 0);
  signal sig_2_41_d : signed(31 downto 0);
  signal sig_3_49_in : signed(31 downto 0);
  signal sig_3_12_d : signed(31 downto 0);
  signal sig_3_15_d : signed(31 downto 0);
  signal sig_3_21_d : signed(31 downto 0);
  signal sig_3_24_d : signed(31 downto 0);
  signal sig_3_30_d : signed(31 downto 0);
  signal sig_3_33_d : signed(31 downto 0);
  signal sig_3_39_d : signed(31 downto 0);
  signal sig_3_42_d : signed(31 downto 0);
  signal sig_4_49_in : signed(31 downto 0);
  signal sig_4_16_d : signed(31 downto 0);
  signal sig_4_25_d : signed(31 downto 0);
  signal sig_4_34_d : signed(31 downto 0);
  signal sig_4_43_d : signed(31 downto 0);
  signal sig_6_44_in : signed(31 downto 0);
  signal sig_7_45_in : signed(31 downto 0);
  signal sig_8_47_in : signed(31 downto 0);
  signal sig_9_48_in : signed(31 downto 0);
  signal sig_10_47_in : signed(31 downto 0);
  signal sig_11_48_in : signed(31 downto 0);
  signal sig_12_50_in : signed(31 downto 0);
  signal sig_13_47_in : signed(31 downto 0);
  signal sig_14_48_in : signed(31 downto 0);
  signal sig_15_50_in : signed(31 downto 0);
  signal sig_16_51_in : signed(31 downto 0);
  signal sig_17_47_in : signed(31 downto 0);
  signal sig_18_48_in : signed(31 downto 0);
  signal sig_19_47_in : signed(31 downto 0);
  signal sig_20_48_in : signed(31 downto 0);
  signal sig_21_50_in : signed(31 downto 0);
  signal sig_22_47_in : signed(31 downto 0);
  signal sig_23_48_in : signed(31 downto 0);
  signal sig_24_50_in : signed(31 downto 0);
  signal sig_25_51_in : signed(31 downto 0);
  signal sig_26_47_in : signed(31 downto 0);
  signal sig_27_48_in : signed(31 downto 0);
  signal sig_28_47_in : signed(31 downto 0);
  signal sig_29_48_in : signed(31 downto 0);
  signal sig_30_50_in : signed(31 downto 0);
  signal sig_31_47_in : signed(31 downto 0);
  signal sig_32_48_in : signed(31 downto 0);
  signal sig_33_50_in : signed(31 downto 0);
  signal sig_34_51_in : signed(31 downto 0);
  signal sig_35_47_in : signed(31 downto 0);
  signal sig_36_48_in : signed(31 downto 0);
  signal sig_37_47_in : signed(31 downto 0);
  signal sig_38_48_in : signed(31 downto 0);
  signal sig_39_50_in : signed(31 downto 0);
  signal sig_40_47_in : signed(31 downto 0);
  signal sig_41_48_in : signed(31 downto 0);
  signal sig_42_50_in : signed(31 downto 0);
  signal sig_43_51_in : signed(31 downto 0);
  signal sig_44_1_addr : signed(31 downto 0);
  signal sig_45_2_addr : signed(31 downto 0);
  signal sig_46_5_addr : signed(31 downto 0);
  signal sig_47_3_in0 : signed(31 downto 0);
  signal sig_48_3_in1 : signed(31 downto 0);
  signal sig_49_4_in0 : signed(31 downto 0);
  signal sig_50_4_in1 : signed(31 downto 0);
  signal sig_51_5_val : signed(31 downto 0);
  
  
  signal mul_0_y : signed(31 downto 0);
  signal add_0_y : signed(31 downto 0);
  
  signal state : integer range 0 to 13 := 0;
  
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
  
  
  U_r0: Reg32 port map(
    clk => clk,
    en  => r0_en,
    d   => sig_0_6_d,
    q   => r0_q
  );
  U_r1: Reg32 port map(
    clk => clk,
    en  => r1_en,
    d   => sig_0_7_d,
    q   => r1_q
  );
  U_r2: Reg32 port map(
    clk => clk,
    en  => r2_en,
    d   => sig_1_8_d,
    q   => r2_q
  );
  U_r3: Reg32 port map(
    clk => clk,
    en  => r3_en,
    d   => sig_2_9_d,
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
    d   => sig_3_15_d,
    q   => r9_q
  );
  U_r10: Reg32 port map(
    clk => clk,
    en  => r10_en,
    d   => sig_4_16_d,
    q   => r10_q
  );
  U_r11: Reg32 port map(
    clk => clk,
    en  => r11_en,
    d   => sig_1_17_d,
    q   => r11_q
  );
  U_r12: Reg32 port map(
    clk => clk,
    en  => r12_en,
    d   => sig_2_18_d,
    q   => r12_q
  );
  U_r13: Reg32 port map(
    clk => clk,
    en  => r13_en,
    d   => sig_1_19_d,
    q   => r13_q
  );
  U_r14: Reg32 port map(
    clk => clk,
    en  => r14_en,
    d   => sig_2_20_d,
    q   => r14_q
  );
  U_r15: Reg32 port map(
    clk => clk,
    en  => r15_en,
    d   => sig_3_21_d,
    q   => r15_q
  );
  U_r16: Reg32 port map(
    clk => clk,
    en  => r16_en,
    d   => sig_1_22_d,
    q   => r16_q
  );
  U_r17: Reg32 port map(
    clk => clk,
    en  => r17_en,
    d   => sig_2_23_d,
    q   => r17_q
  );
  U_r18: Reg32 port map(
    clk => clk,
    en  => r18_en,
    d   => sig_3_24_d,
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
    d   => sig_1_28_d,
    q   => r22_q
  );
  U_r23: Reg32 port map(
    clk => clk,
    en  => r23_en,
    d   => sig_2_29_d,
    q   => r23_q
  );
  U_r24: Reg32 port map(
    clk => clk,
    en  => r24_en,
    d   => sig_3_30_d,
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
    d   => sig_3_33_d,
    q   => r27_q
  );
  U_r28: Reg32 port map(
    clk => clk,
    en  => r28_en,
    d   => sig_4_34_d,
    q   => r28_q
  );
  U_r29: Reg32 port map(
    clk => clk,
    en  => r29_en,
    d   => sig_1_35_d,
    q   => r29_q
  );
  U_r30: Reg32 port map(
    clk => clk,
    en  => r30_en,
    d   => sig_2_36_d,
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
  U_r33: Reg32 port map(
    clk => clk,
    en  => r33_en,
    d   => sig_3_39_d,
    q   => r33_q
  );
  U_r34: Reg32 port map(
    clk => clk,
    en  => r34_en,
    d   => sig_1_40_d,
    q   => r34_q
  );
  U_r35: Reg32 port map(
    clk => clk,
    en  => r35_en,
    d   => sig_2_41_d,
    q   => r35_q
  );
  U_r36: Reg32 port map(
    clk => clk,
    en  => r36_en,
    d   => sig_3_42_d,
    q   => r36_q
  );
  U_r37: Reg32 port map(
    clk => clk,
    en  => r37_en,
    d   => sig_4_43_d,
    q   => r37_q
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
  
  U_mul_0: Mul32 port map(a => sig_47_3_in0, b => sig_48_3_in1, y => mul_0_y);
  sig_3_49_in <= mul_0_y;
  sig_3_12_d <= mul_0_y;
  sig_3_15_d <= mul_0_y;
  sig_3_21_d <= mul_0_y;
  sig_3_24_d <= mul_0_y;
  sig_3_30_d <= mul_0_y;
  sig_3_33_d <= mul_0_y;
  sig_3_39_d <= mul_0_y;
  sig_3_42_d <= mul_0_y;
  U_add_0: Adder32 port map(a => sig_49_4_in0, b => sig_50_4_in1, y => add_0_y);
  sig_4_49_in <= add_0_y;
  sig_4_16_d <= add_0_y;
  sig_4_25_d <= add_0_y;
  sig_4_34_d <= add_0_y;
  sig_4_43_d <= add_0_y;
  
  sig_0_6_d <= to_signed(0, 32);
  sig_0_7_d <= to_signed(0, 32);
  
  sig_1_8_d <= mem_0_dout;
  sig_1_10_d <= mem_0_dout;
  sig_1_13_d <= mem_0_dout;
  sig_1_17_d <= mem_0_dout;
  sig_1_19_d <= mem_0_dout;
  sig_1_22_d <= mem_0_dout;
  sig_1_26_d <= mem_0_dout;
  sig_1_28_d <= mem_0_dout;
  sig_1_31_d <= mem_0_dout;
  sig_1_35_d <= mem_0_dout;
  sig_1_37_d <= mem_0_dout;
  sig_1_40_d <= mem_0_dout;
  sig_2_9_d <= mem_1_dout;
  sig_2_11_d <= mem_1_dout;
  sig_2_14_d <= mem_1_dout;
  sig_2_18_d <= mem_1_dout;
  sig_2_20_d <= mem_1_dout;
  sig_2_23_d <= mem_1_dout;
  sig_2_27_d <= mem_1_dout;
  sig_2_29_d <= mem_1_dout;
  sig_2_32_d <= mem_1_dout;
  sig_2_36_d <= mem_1_dout;
  sig_2_38_d <= mem_1_dout;
  sig_2_41_d <= mem_1_dout;
  
  -- mem_0_addr mux driving sig_44_1_addr
  process(all)
  begin
    case sel_mem_0_addr is
      when 0 => sig_44_1_addr <= r0_q;
      when 1 => sig_44_1_addr <= to_signed(1, 32);
      when 2 => sig_44_1_addr <= to_signed(2, 32);
      when 3 => sig_44_1_addr <= to_signed(3, 32);
      when 4 => sig_44_1_addr <= to_signed(4, 32);
      when 5 => sig_44_1_addr <= to_signed(5, 32);
      when others => sig_44_1_addr <= (others => '0');
    end case;
  end process;
  
  -- mem_1_addr mux driving sig_45_2_addr
  process(all)
  begin
    case sel_mem_1_addr is
      when 0 => sig_45_2_addr <= r1_q;
      when 1 => sig_45_2_addr <= to_signed(0, 32);
      when 2 => sig_45_2_addr <= to_signed(1, 32);
      when 3 => sig_45_2_addr <= to_signed(2, 32);
      when others => sig_45_2_addr <= (others => '0');
    end case;
  end process;
  
  -- mem_2_addr mux driving sig_46_5_addr
  process(all)
  begin
    case sel_mem_2_addr is
      when 0 => sig_46_5_addr <= to_signed(0, 32);
      when 1 => sig_46_5_addr <= to_signed(1, 32);
      when 2 => sig_46_5_addr <= to_signed(2, 32);
      when 3 => sig_46_5_addr <= to_signed(3, 32);
      when others => sig_46_5_addr <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in0 mux driving sig_47_3_in0
  process(all)
  begin
    case sel_mul_0_in0 is
      when 0 => sig_47_3_in0 <= r2_q;
      when 1 => sig_47_3_in0 <= r4_q;
      when 2 => sig_47_3_in0 <= r7_q;
      when 3 => sig_47_3_in0 <= r11_q;
      when 4 => sig_47_3_in0 <= r13_q;
      when 5 => sig_47_3_in0 <= r16_q;
      when 6 => sig_47_3_in0 <= r20_q;
      when 7 => sig_47_3_in0 <= r22_q;
      when 8 => sig_47_3_in0 <= r25_q;
      when 9 => sig_47_3_in0 <= r29_q;
      when 10 => sig_47_3_in0 <= r31_q;
      when 11 => sig_47_3_in0 <= r34_q;
      when others => sig_47_3_in0 <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in1 mux driving sig_48_3_in1
  process(all)
  begin
    case sel_mul_0_in1 is
      when 0 => sig_48_3_in1 <= r3_q;
      when 1 => sig_48_3_in1 <= r5_q;
      when 2 => sig_48_3_in1 <= r8_q;
      when 3 => sig_48_3_in1 <= r12_q;
      when 4 => sig_48_3_in1 <= r14_q;
      when 5 => sig_48_3_in1 <= r17_q;
      when 6 => sig_48_3_in1 <= r21_q;
      when 7 => sig_48_3_in1 <= r23_q;
      when 8 => sig_48_3_in1 <= r26_q;
      when 9 => sig_48_3_in1 <= r30_q;
      when 10 => sig_48_3_in1 <= r32_q;
      when 11 => sig_48_3_in1 <= r35_q;
      when others => sig_48_3_in1 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in0 mux driving sig_49_4_in0
  process(all)
  begin
    case sel_add_0_in0 is
      when 0 => sig_49_4_in0 <= sig_3_49_in;
      when 1 => sig_49_4_in0 <= sig_4_49_in;
      when 2 => sig_49_4_in0 <= sig_3_49_in;
      when 3 => sig_49_4_in0 <= sig_4_49_in;
      when 4 => sig_49_4_in0 <= sig_3_49_in;
      when 5 => sig_49_4_in0 <= sig_4_49_in;
      when 6 => sig_49_4_in0 <= sig_3_49_in;
      when 7 => sig_49_4_in0 <= sig_4_49_in;
      when others => sig_49_4_in0 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in1 mux driving sig_50_4_in1
  process(all)
  begin
    case sel_add_0_in1 is
      when 0 => sig_50_4_in1 <= r6_q;
      when 1 => sig_50_4_in1 <= r9_q;
      when 2 => sig_50_4_in1 <= r15_q;
      when 3 => sig_50_4_in1 <= r18_q;
      when 4 => sig_50_4_in1 <= r24_q;
      when 5 => sig_50_4_in1 <= r27_q;
      when 6 => sig_50_4_in1 <= r33_q;
      when 7 => sig_50_4_in1 <= r36_q;
      when others => sig_50_4_in1 <= (others => '0');
    end case;
  end process;
  
  -- mem_2_val mux driving sig_51_5_val
  process(all)
  begin
    case sel_mem_2_val is
      when 0 => sig_51_5_val <= r10_q;
      when 1 => sig_51_5_val <= r19_q;
      when 2 => sig_51_5_val <= r28_q;
      when 3 => sig_51_5_val <= r37_q;
      when others => sig_51_5_val <= (others => '0');
    end case;
  end process;
  
  mem_0_addr <= sig_44_1_addr;
  mem_1_addr <= sig_45_2_addr;
  mem_2_addr <= sig_46_5_addr;
  mem_2_din <= sig_51_5_val;
  
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
          when 13 => state <= 13;
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
    r33_en <= '0';
    r34_en <= '0';
    r35_en <= '0';
    r36_en <= '0';
    r37_en <= '0';
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
    sel_mul_0_in1 <= 0;
    sel_add_0_in0 <= 0;
    sel_add_0_in1 <= 0;
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
        r1_en <= '1';
        r2_en <= '1';
        r3_en <= '1';
        sel_mem_0_addr <= 0;
        sel_mem_1_addr <= 0;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 1 =>
        r4_en <= '1';
        r5_en <= '1';
        sel_mem_0_addr <= 1;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 0;
        sel_mul_0_in1 <= 0;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 2 =>
        r6_en <= '1';
        r7_en <= '1';
        r8_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 0;
        sel_mem_0_addr <= 2;
        sel_mem_1_addr <= 3;
        sel_mul_0_in0 <= 1;
        sel_mul_0_in1 <= 1;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 3 =>
        r10_en <= '1';
        r11_en <= '1';
        r12_en <= '1';
        r9_en <= '1';
        sel_add_0_in0 <= 1;
        sel_add_0_in1 <= 1;
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
      when 4 =>
        r13_en <= '1';
        r14_en <= '1';
        sel_mem_0_addr <= 2;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 3;
        sel_mul_0_in1 <= 3;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 5 =>
        r15_en <= '1';
        r16_en <= '1';
        r17_en <= '1';
        sel_add_0_in0 <= 2;
        sel_add_0_in1 <= 2;
        sel_mem_0_addr <= 3;
        sel_mem_1_addr <= 3;
        sel_mul_0_in0 <= 4;
        sel_mul_0_in1 <= 4;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 6 =>
        r18_en <= '1';
        r19_en <= '1';
        r20_en <= '1';
        r21_en <= '1';
        sel_add_0_in0 <= 3;
        sel_add_0_in1 <= 3;
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
      when 7 =>
        r22_en <= '1';
        r23_en <= '1';
        sel_mem_0_addr <= 3;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 6;
        sel_mul_0_in1 <= 6;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 8 =>
        r24_en <= '1';
        r25_en <= '1';
        r26_en <= '1';
        sel_add_0_in0 <= 4;
        sel_add_0_in1 <= 4;
        sel_mem_0_addr <= 4;
        sel_mem_1_addr <= 3;
        sel_mul_0_in0 <= 7;
        sel_mul_0_in1 <= 7;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 9 =>
        r27_en <= '1';
        r28_en <= '1';
        r29_en <= '1';
        r30_en <= '1';
        sel_add_0_in0 <= 5;
        sel_add_0_in1 <= 5;
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
      when 10 =>
        r31_en <= '1';
        r32_en <= '1';
        sel_mem_0_addr <= 4;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 9;
        sel_mul_0_in1 <= 9;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 11 =>
        r33_en <= '1';
        r34_en <= '1';
        r35_en <= '1';
        sel_add_0_in0 <= 6;
        sel_add_0_in1 <= 6;
        sel_mem_0_addr <= 5;
        sel_mem_1_addr <= 3;
        sel_mul_0_in0 <= 10;
        sel_mul_0_in1 <= 10;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 12 =>
        r36_en <= '1';
        r37_en <= '1';
        sel_add_0_in0 <= 7;
        sel_add_0_in1 <= 7;
        sel_mem_2_addr <= 3;
        sel_mem_2_val <= 3;
        sel_mul_0_in0 <= 11;
        sel_mul_0_in1 <= 11;
        mem_2_en <= '1';
        mem_2_we <= '1';
      when 13 =>
        done <= '1';
      when others => null;
    end case;
  end process;
  
end architecture;