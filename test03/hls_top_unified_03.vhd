library ieee;
use ieee.std_logic_1164.all;

entity hls_top_unified_03 is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    done  : out std_logic
  );
end entity;

architecture rtl of hls_top_unified_03 is
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
  signal r33_q  : std_logic_vector(31 downto 0);
  signal r33_en  : std_logic;
  signal r34_q  : std_logic_vector(31 downto 0);
  signal r34_en  : std_logic;
  signal r35_q  : std_logic_vector(31 downto 0);
  signal r35_en  : std_logic;
  signal r36_q  : std_logic_vector(31 downto 0);
  signal r36_en  : std_logic;
  signal r37_q  : std_logic_vector(31 downto 0);
  signal r37_en  : std_logic;
  signal r38_q  : std_logic_vector(31 downto 0);
  signal r38_en  : std_logic;
  signal r39_q  : std_logic_vector(31 downto 0);
  signal r39_en  : std_logic;
  signal r40_q  : std_logic_vector(31 downto 0);
  signal r40_en  : std_logic;
  signal r41_q  : std_logic_vector(31 downto 0);
  signal r41_en  : std_logic;
  signal r42_q  : std_logic_vector(31 downto 0);
  signal r42_en  : std_logic;
  signal r43_q  : std_logic_vector(31 downto 0);
  signal r43_en  : std_logic;
  signal r44_q  : std_logic_vector(31 downto 0);
  signal r44_en  : std_logic;
  signal r45_q  : std_logic_vector(31 downto 0);
  signal r45_en  : std_logic;
  signal r46_q  : std_logic_vector(31 downto 0);
  signal r46_en  : std_logic;
  signal r47_q  : std_logic_vector(31 downto 0);
  signal r47_en  : std_logic;
  signal r48_q  : std_logic_vector(31 downto 0);
  signal r48_en  : std_logic;
  signal r49_q  : std_logic_vector(31 downto 0);
  signal r49_en  : std_logic;
  signal r50_q  : std_logic_vector(31 downto 0);
  signal r50_en  : std_logic;
  signal r51_q  : std_logic_vector(31 downto 0);
  signal r51_en  : std_logic;
  signal r52_q  : std_logic_vector(31 downto 0);
  signal r52_en  : std_logic;
  signal r53_q  : std_logic_vector(31 downto 0);
  signal r53_en  : std_logic;
  signal r54_q  : std_logic_vector(31 downto 0);
  signal r54_en  : std_logic;
  signal r55_q  : std_logic_vector(31 downto 0);
  signal r55_en  : std_logic;
  signal r56_q  : std_logic_vector(31 downto 0);
  signal r56_en  : std_logic;
  signal r57_q  : std_logic_vector(31 downto 0);
  signal r57_en  : std_logic;
  signal r58_q  : std_logic_vector(31 downto 0);
  signal r58_en  : std_logic;
  signal r59_q  : std_logic_vector(31 downto 0);
  signal r59_en  : std_logic;
  signal r60_q  : std_logic_vector(31 downto 0);
  signal r60_en  : std_logic;
  signal r61_q  : std_logic_vector(31 downto 0);
  signal r61_en  : std_logic;
  signal r62_q  : std_logic_vector(31 downto 0);
  signal r62_en  : std_logic;
  signal r63_q  : std_logic_vector(31 downto 0);
  signal r63_en  : std_logic;
  signal r64_q  : std_logic_vector(31 downto 0);
  signal r64_en  : std_logic;
  signal r65_q  : std_logic_vector(31 downto 0);
  signal r65_en  : std_logic;
  signal r66_q  : std_logic_vector(31 downto 0);
  signal r66_en  : std_logic;
  signal r67_q  : std_logic_vector(31 downto 0);
  signal r67_en  : std_logic;
  signal r68_q  : std_logic_vector(31 downto 0);
  signal r68_en  : std_logic;
  signal r69_q  : std_logic_vector(31 downto 0);
  signal r69_en  : std_logic;
  signal r70_q  : std_logic_vector(31 downto 0);
  signal r70_en  : std_logic;
  signal r71_q  : std_logic_vector(31 downto 0);
  signal r71_en  : std_logic;
  
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
  
  signal sig_0_6 : std_logic_vector(31 downto 0);
  signal sig_0_7 : std_logic_vector(31 downto 0);
  signal sig_0_8 : std_logic_vector(31 downto 0);
  signal sig_0_9 : std_logic_vector(31 downto 0);
  signal sig_0_10 : std_logic_vector(31 downto 0);
  signal sig_0_11 : std_logic_vector(31 downto 0);
  signal sig_0_15 : std_logic_vector(31 downto 0);
  signal sig_0_16 : std_logic_vector(31 downto 0);
  signal sig_0_17 : std_logic_vector(31 downto 0);
  signal sig_0_18 : std_logic_vector(31 downto 0);
  signal sig_0_19 : std_logic_vector(31 downto 0);
  signal sig_0_20 : std_logic_vector(31 downto 0);
  signal sig_0_21 : std_logic_vector(31 downto 0);
  signal sig_0_26 : std_logic_vector(31 downto 0);
  signal sig_0_27 : std_logic_vector(31 downto 0);
  signal sig_0_28 : std_logic_vector(31 downto 0);
  signal sig_0_29 : std_logic_vector(31 downto 0);
  signal sig_0_30 : std_logic_vector(31 downto 0);
  signal sig_0_31 : std_logic_vector(31 downto 0);
  signal sig_0_32 : std_logic_vector(31 downto 0);
  signal sig_0_33 : std_logic_vector(31 downto 0);
  signal sig_0_45 : std_logic_vector(31 downto 0);
  signal sig_0_46 : std_logic_vector(31 downto 0);
  signal sig_0_47 : std_logic_vector(31 downto 0);
  signal sig_0_48 : std_logic_vector(31 downto 0);
  signal sig_0_60 : std_logic_vector(31 downto 0);
  signal sig_0_61 : std_logic_vector(31 downto 0);
  signal sig_0_73 : std_logic_vector(31 downto 0);
  signal sig_1_12 : std_logic_vector(31 downto 0);
  signal sig_1_22 : std_logic_vector(31 downto 0);
  signal sig_1_34 : std_logic_vector(31 downto 0);
  signal sig_1_38 : std_logic_vector(31 downto 0);
  signal sig_1_41 : std_logic_vector(31 downto 0);
  signal sig_1_49 : std_logic_vector(31 downto 0);
  signal sig_1_53 : std_logic_vector(31 downto 0);
  signal sig_1_56 : std_logic_vector(31 downto 0);
  signal sig_1_62 : std_logic_vector(31 downto 0);
  signal sig_1_66 : std_logic_vector(31 downto 0);
  signal sig_1_69 : std_logic_vector(31 downto 0);
  signal sig_1_74 : std_logic_vector(31 downto 0);
  signal sig_2_13 : std_logic_vector(31 downto 0);
  signal sig_2_23 : std_logic_vector(31 downto 0);
  signal sig_2_35 : std_logic_vector(31 downto 0);
  signal sig_2_39 : std_logic_vector(31 downto 0);
  signal sig_2_42 : std_logic_vector(31 downto 0);
  signal sig_2_50 : std_logic_vector(31 downto 0);
  signal sig_2_54 : std_logic_vector(31 downto 0);
  signal sig_2_57 : std_logic_vector(31 downto 0);
  signal sig_2_63 : std_logic_vector(31 downto 0);
  signal sig_2_67 : std_logic_vector(31 downto 0);
  signal sig_2_70 : std_logic_vector(31 downto 0);
  signal sig_2_75 : std_logic_vector(31 downto 0);
  signal sig_3_14 : std_logic_vector(31 downto 0);
  signal sig_3_24 : std_logic_vector(31 downto 0);
  signal sig_3_36 : std_logic_vector(31 downto 0);
  signal sig_3_40 : std_logic_vector(31 downto 0);
  signal sig_3_43 : std_logic_vector(31 downto 0);
  signal sig_3_51 : std_logic_vector(31 downto 0);
  signal sig_3_55 : std_logic_vector(31 downto 0);
  signal sig_3_58 : std_logic_vector(31 downto 0);
  signal sig_3_64 : std_logic_vector(31 downto 0);
  signal sig_3_68 : std_logic_vector(31 downto 0);
  signal sig_3_71 : std_logic_vector(31 downto 0);
  signal sig_3_76 : std_logic_vector(31 downto 0);
  signal sig_4_25 : std_logic_vector(31 downto 0);
  signal sig_4_37 : std_logic_vector(31 downto 0);
  signal sig_4_44 : std_logic_vector(31 downto 0);
  signal sig_4_52 : std_logic_vector(31 downto 0);
  signal sig_4_59 : std_logic_vector(31 downto 0);
  signal sig_4_65 : std_logic_vector(31 downto 0);
  signal sig_4_72 : std_logic_vector(31 downto 0);
  signal sig_4_77 : std_logic_vector(31 downto 0);
  signal sig_6_78 : std_logic_vector(31 downto 0);
  signal sig_7_79 : std_logic_vector(31 downto 0);
  signal sig_8_80 : std_logic_vector(31 downto 0);
  signal sig_9_79 : std_logic_vector(31 downto 0);
  signal sig_10_79 : std_logic_vector(31 downto 0);
  signal sig_11_79 : std_logic_vector(31 downto 0);
  signal sig_12_81 : std_logic_vector(31 downto 0);
  signal sig_13_82 : std_logic_vector(31 downto 0);
  signal sig_14_83 : std_logic_vector(31 downto 0);
  signal sig_15_78 : std_logic_vector(31 downto 0);
  signal sig_16_79 : std_logic_vector(31 downto 0);
  signal sig_17_78 : std_logic_vector(31 downto 0);
  signal sig_18_79 : std_logic_vector(31 downto 0);
  signal sig_19_80 : std_logic_vector(31 downto 0);
  signal sig_20_79 : std_logic_vector(31 downto 0);
  signal sig_21_79 : std_logic_vector(31 downto 0);
  signal sig_22_81 : std_logic_vector(31 downto 0);
  signal sig_23_82 : std_logic_vector(31 downto 0);
  signal sig_24_84 : std_logic_vector(31 downto 0);
  signal sig_25_83 : std_logic_vector(31 downto 0);
  signal sig_26_78 : std_logic_vector(31 downto 0);
  signal sig_27_79 : std_logic_vector(31 downto 0);
  signal sig_28_78 : std_logic_vector(31 downto 0);
  signal sig_29_79 : std_logic_vector(31 downto 0);
  signal sig_30_78 : std_logic_vector(31 downto 0);
  signal sig_31_79 : std_logic_vector(31 downto 0);
  signal sig_32_80 : std_logic_vector(31 downto 0);
  signal sig_33_79 : std_logic_vector(31 downto 0);
  signal sig_34_81 : std_logic_vector(31 downto 0);
  signal sig_35_82 : std_logic_vector(31 downto 0);
  signal sig_36_84 : std_logic_vector(31 downto 0);
  signal sig_37_85 : std_logic_vector(31 downto 0);
  signal sig_38_81 : std_logic_vector(31 downto 0);
  signal sig_39_82 : std_logic_vector(31 downto 0);
  signal sig_40_83 : std_logic_vector(31 downto 0);
  signal sig_41_81 : std_logic_vector(31 downto 0);
  signal sig_42_82 : std_logic_vector(31 downto 0);
  signal sig_43_84 : std_logic_vector(31 downto 0);
  signal sig_44_83 : std_logic_vector(31 downto 0);
  signal sig_45_78 : std_logic_vector(31 downto 0);
  signal sig_46_78 : std_logic_vector(31 downto 0);
  signal sig_47_78 : std_logic_vector(31 downto 0);
  signal sig_48_80 : std_logic_vector(31 downto 0);
  signal sig_49_81 : std_logic_vector(31 downto 0);
  signal sig_50_82 : std_logic_vector(31 downto 0);
  signal sig_51_84 : std_logic_vector(31 downto 0);
  signal sig_52_85 : std_logic_vector(31 downto 0);
  signal sig_53_81 : std_logic_vector(31 downto 0);
  signal sig_54_82 : std_logic_vector(31 downto 0);
  signal sig_55_83 : std_logic_vector(31 downto 0);
  signal sig_56_81 : std_logic_vector(31 downto 0);
  signal sig_57_82 : std_logic_vector(31 downto 0);
  signal sig_58_84 : std_logic_vector(31 downto 0);
  signal sig_59_83 : std_logic_vector(31 downto 0);
  signal sig_60_78 : std_logic_vector(31 downto 0);
  signal sig_61_78 : std_logic_vector(31 downto 0);
  signal sig_62_81 : std_logic_vector(31 downto 0);
  signal sig_63_82 : std_logic_vector(31 downto 0);
  signal sig_64_84 : std_logic_vector(31 downto 0);
  signal sig_65_85 : std_logic_vector(31 downto 0);
  signal sig_66_81 : std_logic_vector(31 downto 0);
  signal sig_67_82 : std_logic_vector(31 downto 0);
  signal sig_68_83 : std_logic_vector(31 downto 0);
  signal sig_69_81 : std_logic_vector(31 downto 0);
  signal sig_70_82 : std_logic_vector(31 downto 0);
  signal sig_71_84 : std_logic_vector(31 downto 0);
  signal sig_72_83 : std_logic_vector(31 downto 0);
  signal sig_73_78 : std_logic_vector(31 downto 0);
  signal sig_74_81 : std_logic_vector(31 downto 0);
  signal sig_75_82 : std_logic_vector(31 downto 0);
  signal sig_76_84 : std_logic_vector(31 downto 0);
  signal sig_77_85 : std_logic_vector(31 downto 0);
  signal sig_78_1 : std_logic_vector(31 downto 0);
  signal sig_79_2 : std_logic_vector(31 downto 0);
  signal sig_80_5 : std_logic_vector(31 downto 0);
  signal sig_81_3 : std_logic_vector(31 downto 0);
  signal sig_82_3 : std_logic_vector(31 downto 0);
  signal sig_83_4 : std_logic_vector(31 downto 0);
  signal sig_84_4 : std_logic_vector(31 downto 0);
  signal sig_85_5 : std_logic_vector(31 downto 0);
  
  signal state : integer range 0 to 16 := 0;
  
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
    d   => sig_0_6,
    q   => r0_q
  );
  U_r1: Reg32 port map(
    clk => clk,
    en  => r1_en,
    d   => sig_0_7,
    q   => r1_q
  );
  U_r2: Reg32 port map(
    clk => clk,
    en  => r2_en,
    d   => sig_0_8,
    q   => r2_q
  );
  U_r3: Reg32 port map(
    clk => clk,
    en  => r3_en,
    d   => sig_0_9,
    q   => r3_q
  );
  U_r4: Reg32 port map(
    clk => clk,
    en  => r4_en,
    d   => sig_0_10,
    q   => r4_q
  );
  U_r5: Reg32 port map(
    clk => clk,
    en  => r5_en,
    d   => sig_0_11,
    q   => r5_q
  );
  U_r6: Reg32 port map(
    clk => clk,
    en  => r6_en,
    d   => sig_1_12,
    q   => r6_q
  );
  U_r7: Reg32 port map(
    clk => clk,
    en  => r7_en,
    d   => sig_2_13,
    q   => r7_q
  );
  U_r8: Reg32 port map(
    clk => clk,
    en  => r8_en,
    d   => sig_3_14,
    q   => r8_q
  );
  U_r9: Reg32 port map(
    clk => clk,
    en  => r9_en,
    d   => sig_0_15,
    q   => r9_q
  );
  U_r10: Reg32 port map(
    clk => clk,
    en  => r10_en,
    d   => sig_0_16,
    q   => r10_q
  );
  U_r11: Reg32 port map(
    clk => clk,
    en  => r11_en,
    d   => sig_0_17,
    q   => r11_q
  );
  U_r12: Reg32 port map(
    clk => clk,
    en  => r12_en,
    d   => sig_0_18,
    q   => r12_q
  );
  U_r13: Reg32 port map(
    clk => clk,
    en  => r13_en,
    d   => sig_0_19,
    q   => r13_q
  );
  U_r14: Reg32 port map(
    clk => clk,
    en  => r14_en,
    d   => sig_0_20,
    q   => r14_q
  );
  U_r15: Reg32 port map(
    clk => clk,
    en  => r15_en,
    d   => sig_0_21,
    q   => r15_q
  );
  U_r16: Reg32 port map(
    clk => clk,
    en  => r16_en,
    d   => sig_1_22,
    q   => r16_q
  );
  U_r17: Reg32 port map(
    clk => clk,
    en  => r17_en,
    d   => sig_2_23,
    q   => r17_q
  );
  U_r18: Reg32 port map(
    clk => clk,
    en  => r18_en,
    d   => sig_3_24,
    q   => r18_q
  );
  U_r19: Reg32 port map(
    clk => clk,
    en  => r19_en,
    d   => sig_4_25,
    q   => r19_q
  );
  U_r20: Reg32 port map(
    clk => clk,
    en  => r20_en,
    d   => sig_0_26,
    q   => r20_q
  );
  U_r21: Reg32 port map(
    clk => clk,
    en  => r21_en,
    d   => sig_0_27,
    q   => r21_q
  );
  U_r22: Reg32 port map(
    clk => clk,
    en  => r22_en,
    d   => sig_0_28,
    q   => r22_q
  );
  U_r23: Reg32 port map(
    clk => clk,
    en  => r23_en,
    d   => sig_0_29,
    q   => r23_q
  );
  U_r24: Reg32 port map(
    clk => clk,
    en  => r24_en,
    d   => sig_0_30,
    q   => r24_q
  );
  U_r25: Reg32 port map(
    clk => clk,
    en  => r25_en,
    d   => sig_0_31,
    q   => r25_q
  );
  U_r26: Reg32 port map(
    clk => clk,
    en  => r26_en,
    d   => sig_0_32,
    q   => r26_q
  );
  U_r27: Reg32 port map(
    clk => clk,
    en  => r27_en,
    d   => sig_0_33,
    q   => r27_q
  );
  U_r28: Reg32 port map(
    clk => clk,
    en  => r28_en,
    d   => sig_1_34,
    q   => r28_q
  );
  U_r29: Reg32 port map(
    clk => clk,
    en  => r29_en,
    d   => sig_2_35,
    q   => r29_q
  );
  U_r30: Reg32 port map(
    clk => clk,
    en  => r30_en,
    d   => sig_3_36,
    q   => r30_q
  );
  U_r31: Reg32 port map(
    clk => clk,
    en  => r31_en,
    d   => sig_4_37,
    q   => r31_q
  );
  U_r32: Reg32 port map(
    clk => clk,
    en  => r32_en,
    d   => sig_1_38,
    q   => r32_q
  );
  U_r33: Reg32 port map(
    clk => clk,
    en  => r33_en,
    d   => sig_2_39,
    q   => r33_q
  );
  U_r34: Reg32 port map(
    clk => clk,
    en  => r34_en,
    d   => sig_3_40,
    q   => r34_q
  );
  U_r35: Reg32 port map(
    clk => clk,
    en  => r35_en,
    d   => sig_1_41,
    q   => r35_q
  );
  U_r36: Reg32 port map(
    clk => clk,
    en  => r36_en,
    d   => sig_2_42,
    q   => r36_q
  );
  U_r37: Reg32 port map(
    clk => clk,
    en  => r37_en,
    d   => sig_3_43,
    q   => r37_q
  );
  U_r38: Reg32 port map(
    clk => clk,
    en  => r38_en,
    d   => sig_4_44,
    q   => r38_q
  );
  U_r39: Reg32 port map(
    clk => clk,
    en  => r39_en,
    d   => sig_0_45,
    q   => r39_q
  );
  U_r40: Reg32 port map(
    clk => clk,
    en  => r40_en,
    d   => sig_0_46,
    q   => r40_q
  );
  U_r41: Reg32 port map(
    clk => clk,
    en  => r41_en,
    d   => sig_0_47,
    q   => r41_q
  );
  U_r42: Reg32 port map(
    clk => clk,
    en  => r42_en,
    d   => sig_0_48,
    q   => r42_q
  );
  U_r43: Reg32 port map(
    clk => clk,
    en  => r43_en,
    d   => sig_1_49,
    q   => r43_q
  );
  U_r44: Reg32 port map(
    clk => clk,
    en  => r44_en,
    d   => sig_2_50,
    q   => r44_q
  );
  U_r45: Reg32 port map(
    clk => clk,
    en  => r45_en,
    d   => sig_3_51,
    q   => r45_q
  );
  U_r46: Reg32 port map(
    clk => clk,
    en  => r46_en,
    d   => sig_4_52,
    q   => r46_q
  );
  U_r47: Reg32 port map(
    clk => clk,
    en  => r47_en,
    d   => sig_1_53,
    q   => r47_q
  );
  U_r48: Reg32 port map(
    clk => clk,
    en  => r48_en,
    d   => sig_2_54,
    q   => r48_q
  );
  U_r49: Reg32 port map(
    clk => clk,
    en  => r49_en,
    d   => sig_3_55,
    q   => r49_q
  );
  U_r50: Reg32 port map(
    clk => clk,
    en  => r50_en,
    d   => sig_1_56,
    q   => r50_q
  );
  U_r51: Reg32 port map(
    clk => clk,
    en  => r51_en,
    d   => sig_2_57,
    q   => r51_q
  );
  U_r52: Reg32 port map(
    clk => clk,
    en  => r52_en,
    d   => sig_3_58,
    q   => r52_q
  );
  U_r53: Reg32 port map(
    clk => clk,
    en  => r53_en,
    d   => sig_4_59,
    q   => r53_q
  );
  U_r54: Reg32 port map(
    clk => clk,
    en  => r54_en,
    d   => sig_0_60,
    q   => r54_q
  );
  U_r55: Reg32 port map(
    clk => clk,
    en  => r55_en,
    d   => sig_0_61,
    q   => r55_q
  );
  U_r56: Reg32 port map(
    clk => clk,
    en  => r56_en,
    d   => sig_1_62,
    q   => r56_q
  );
  U_r57: Reg32 port map(
    clk => clk,
    en  => r57_en,
    d   => sig_2_63,
    q   => r57_q
  );
  U_r58: Reg32 port map(
    clk => clk,
    en  => r58_en,
    d   => sig_3_64,
    q   => r58_q
  );
  U_r59: Reg32 port map(
    clk => clk,
    en  => r59_en,
    d   => sig_4_65,
    q   => r59_q
  );
  U_r60: Reg32 port map(
    clk => clk,
    en  => r60_en,
    d   => sig_1_66,
    q   => r60_q
  );
  U_r61: Reg32 port map(
    clk => clk,
    en  => r61_en,
    d   => sig_2_67,
    q   => r61_q
  );
  U_r62: Reg32 port map(
    clk => clk,
    en  => r62_en,
    d   => sig_3_68,
    q   => r62_q
  );
  U_r63: Reg32 port map(
    clk => clk,
    en  => r63_en,
    d   => sig_1_69,
    q   => r63_q
  );
  U_r64: Reg32 port map(
    clk => clk,
    en  => r64_en,
    d   => sig_2_70,
    q   => r64_q
  );
  U_r65: Reg32 port map(
    clk => clk,
    en  => r65_en,
    d   => sig_3_71,
    q   => r65_q
  );
  U_r66: Reg32 port map(
    clk => clk,
    en  => r66_en,
    d   => sig_4_72,
    q   => r66_q
  );
  U_r67: Reg32 port map(
    clk => clk,
    en  => r67_en,
    d   => sig_0_73,
    q   => r67_q
  );
  U_r68: Reg32 port map(
    clk => clk,
    en  => r68_en,
    d   => sig_1_74,
    q   => r68_q
  );
  U_r69: Reg32 port map(
    clk => clk,
    en  => r69_en,
    d   => sig_2_75,
    q   => r69_q
  );
  U_r70: Reg32 port map(
    clk => clk,
    en  => r70_en,
    d   => sig_3_76,
    q   => r70_q
  );
  U_r71: Reg32 port map(
    clk => clk,
    en  => r71_en,
    d   => sig_4_77,
    q   => r71_q
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
  
  U_mul_0: Mul32 port map(a => sig_81_3, b => sig_82_3, y => sig_3_14);
  sig_3_24 <= sig_3_14;
  sig_3_36 <= sig_3_14;
  sig_3_40 <= sig_3_14;
  sig_3_43 <= sig_3_14;
  sig_3_51 <= sig_3_14;
  sig_3_55 <= sig_3_14;
  sig_3_58 <= sig_3_14;
  sig_3_64 <= sig_3_14;
  sig_3_68 <= sig_3_14;
  sig_3_71 <= sig_3_14;
  sig_3_76 <= sig_3_14;
  U_add_0: Adder32 port map(a => sig_83_4, b => sig_84_4, y => sig_4_25);
  sig_4_37 <= sig_4_25;
  sig_4_44 <= sig_4_25;
  sig_4_52 <= sig_4_25;
  sig_4_59 <= sig_4_25;
  sig_4_65 <= sig_4_25;
  sig_4_72 <= sig_4_25;
  sig_4_77 <= sig_4_25;
  
  sig_0_6 <= x"00000000";
  sig_0_7 <= x"00000000";
  sig_0_8 <= x"00000000";
  sig_0_9 <= x"00000000";
  sig_0_10 <= x"00000000";
  sig_0_11 <= x"00000000";
  sig_0_15 <= x"00000001";
  sig_0_16 <= x"00000001";
  sig_0_17 <= x"00000001";
  sig_0_18 <= x"00000001";
  sig_0_19 <= x"00000001";
  sig_0_20 <= x"00000001";
  sig_0_21 <= x"00000001";
  sig_0_26 <= x"00000002";
  sig_0_27 <= x"00000002";
  sig_0_28 <= x"00000002";
  sig_0_29 <= x"00000002";
  sig_0_30 <= x"00000002";
  sig_0_31 <= x"00000002";
  sig_0_32 <= x"00000002";
  sig_0_33 <= x"00000002";
  sig_0_45 <= x"00000003";
  sig_0_46 <= x"00000003";
  sig_0_47 <= x"00000003";
  sig_0_48 <= x"00000003";
  sig_0_60 <= x"00000004";
  sig_0_61 <= x"00000004";
  sig_0_73 <= x"00000005";
  
  sig_1_12 <= mem_0_dout;
  sig_1_22 <= mem_0_dout;
  sig_1_34 <= mem_0_dout;
  sig_1_38 <= mem_0_dout;
  sig_1_41 <= mem_0_dout;
  sig_1_49 <= mem_0_dout;
  sig_1_53 <= mem_0_dout;
  sig_1_56 <= mem_0_dout;
  sig_1_62 <= mem_0_dout;
  sig_1_66 <= mem_0_dout;
  sig_1_69 <= mem_0_dout;
  sig_1_74 <= mem_0_dout;
  sig_2_13 <= mem_1_dout;
  sig_2_23 <= mem_1_dout;
  sig_2_35 <= mem_1_dout;
  sig_2_39 <= mem_1_dout;
  sig_2_42 <= mem_1_dout;
  sig_2_50 <= mem_1_dout;
  sig_2_54 <= mem_1_dout;
  sig_2_57 <= mem_1_dout;
  sig_2_63 <= mem_1_dout;
  sig_2_67 <= mem_1_dout;
  sig_2_70 <= mem_1_dout;
  sig_2_75 <= mem_1_dout;
  
  -- mem_0_addr mux driving sig_78_1
  process(all)
  begin
    case sel_mem_0_addr is
      when 0 => sig_78_1 <= r0_q;
      when 1 => sig_78_1 <= r9_q;
      when 2 => sig_78_1 <= r11_q;
      when 3 => sig_78_1 <= r20_q;
      when 4 => sig_78_1 <= r22_q;
      when 5 => sig_78_1 <= r24_q;
      when 6 => sig_78_1 <= r39_q;
      when 7 => sig_78_1 <= r40_q;
      when 8 => sig_78_1 <= r41_q;
      when 9 => sig_78_1 <= r54_q;
      when 10 => sig_78_1 <= r55_q;
      when 11 => sig_78_1 <= r67_q;
      when others => sig_78_1 <= (others => '0');
    end case;
  end process;
  
  -- mem_1_addr mux driving sig_79_2
  process(all)
  begin
    case sel_mem_1_addr is
      when 0 => sig_79_2 <= r1_q;
      when 1 => sig_79_2 <= r3_q;
      when 2 => sig_79_2 <= r4_q;
      when 3 => sig_79_2 <= r5_q;
      when 4 => sig_79_2 <= r10_q;
      when 5 => sig_79_2 <= r12_q;
      when 6 => sig_79_2 <= r14_q;
      when 7 => sig_79_2 <= r15_q;
      when 8 => sig_79_2 <= r21_q;
      when 9 => sig_79_2 <= r23_q;
      when 10 => sig_79_2 <= r25_q;
      when 11 => sig_79_2 <= r27_q;
      when others => sig_79_2 <= (others => '0');
    end case;
  end process;
  
  -- mem_2_addr mux driving sig_80_5
  process(all)
  begin
    case sel_mem_2_addr is
      when 0 => sig_80_5 <= r2_q;
      when 1 => sig_80_5 <= r13_q;
      when 2 => sig_80_5 <= r26_q;
      when 3 => sig_80_5 <= r42_q;
      when others => sig_80_5 <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in0 mux driving sig_81_3
  process(all)
  begin
    case sel_mul_0_in0 is
      when 0 => sig_81_3 <= r6_q;
      when 1 => sig_81_3 <= r16_q;
      when 2 => sig_81_3 <= r28_q;
      when 3 => sig_81_3 <= r32_q;
      when 4 => sig_81_3 <= r35_q;
      when 5 => sig_81_3 <= r43_q;
      when 6 => sig_81_3 <= r47_q;
      when 7 => sig_81_3 <= r50_q;
      when 8 => sig_81_3 <= r56_q;
      when 9 => sig_81_3 <= r60_q;
      when 10 => sig_81_3 <= r63_q;
      when 11 => sig_81_3 <= r68_q;
      when others => sig_81_3 <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in1 mux driving sig_82_3
  process(all)
  begin
    case sel_mul_0_in1 is
      when 0 => sig_82_3 <= r7_q;
      when 1 => sig_82_3 <= r17_q;
      when 2 => sig_82_3 <= r29_q;
      when 3 => sig_82_3 <= r33_q;
      when 4 => sig_82_3 <= r36_q;
      when 5 => sig_82_3 <= r44_q;
      when 6 => sig_82_3 <= r48_q;
      when 7 => sig_82_3 <= r51_q;
      when 8 => sig_82_3 <= r57_q;
      when 9 => sig_82_3 <= r61_q;
      when 10 => sig_82_3 <= r64_q;
      when 11 => sig_82_3 <= r69_q;
      when others => sig_82_3 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in0 mux driving sig_83_4
  process(all)
  begin
    case sel_add_0_in0 is
      when 0 => sig_83_4 <= r8_q;
      when 1 => sig_83_4 <= r19_q;
      when 2 => sig_83_4 <= r34_q;
      when 3 => sig_83_4 <= r38_q;
      when 4 => sig_83_4 <= r49_q;
      when 5 => sig_83_4 <= r53_q;
      when 6 => sig_83_4 <= r62_q;
      when 7 => sig_83_4 <= r66_q;
      when others => sig_83_4 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in1 mux driving sig_84_4
  process(all)
  begin
    case sel_add_0_in1 is
      when 0 => sig_84_4 <= r18_q;
      when 1 => sig_84_4 <= r30_q;
      when 2 => sig_84_4 <= r37_q;
      when 3 => sig_84_4 <= r45_q;
      when 4 => sig_84_4 <= r52_q;
      when 5 => sig_84_4 <= r58_q;
      when 6 => sig_84_4 <= r65_q;
      when 7 => sig_84_4 <= r70_q;
      when others => sig_84_4 <= (others => '0');
    end case;
  end process;
  
  -- mem_2_val mux driving sig_85_5
  process(all)
  begin
    case sel_mem_2_val is
      when 0 => sig_85_5 <= r31_q;
      when 1 => sig_85_5 <= r46_q;
      when 2 => sig_85_5 <= r59_q;
      when 3 => sig_85_5 <= r71_q;
      when others => sig_85_5 <= (others => '0');
    end case;
  end process;
  
  mem_0_addr <= sig_78_1;
  mem_1_addr <= sig_79_2;
  mem_2_addr <= sig_80_5;
  mem_2_din <= sig_85_5;
  
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
          when 14 => state <= 15;
          when 15 => state <= 16;
          when 16 => state <= 16;
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
    r38_en <= '0';
    r39_en <= '0';
    r4_en <= '0';
    r40_en <= '0';
    r41_en <= '0';
    r42_en <= '0';
    r43_en <= '0';
    r44_en <= '0';
    r45_en <= '0';
    r46_en <= '0';
    r47_en <= '0';
    r48_en <= '0';
    r49_en <= '0';
    r5_en <= '0';
    r50_en <= '0';
    r51_en <= '0';
    r52_en <= '0';
    r53_en <= '0';
    r54_en <= '0';
    r55_en <= '0';
    r56_en <= '0';
    r57_en <= '0';
    r58_en <= '0';
    r59_en <= '0';
    r6_en <= '0';
    r60_en <= '0';
    r61_en <= '0';
    r62_en <= '0';
    r63_en <= '0';
    r64_en <= '0';
    r65_en <= '0';
    r66_en <= '0';
    r67_en <= '0';
    r68_en <= '0';
    r69_en <= '0';
    r7_en <= '0';
    r70_en <= '0';
    r71_en <= '0';
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
        r10_en <= '1';
        r11_en <= '1';
        r12_en <= '1';
        r13_en <= '1';
        r14_en <= '1';
        r15_en <= '1';
        r2_en <= '1';
        r20_en <= '1';
        r21_en <= '1';
        r22_en <= '1';
        r23_en <= '1';
        r24_en <= '1';
        r25_en <= '1';
        r26_en <= '1';
        r27_en <= '1';
        r3_en <= '1';
        r39_en <= '1';
        r4_en <= '1';
        r40_en <= '1';
        r41_en <= '1';
        r42_en <= '1';
        r5_en <= '1';
        r54_en <= '1';
        r55_en <= '1';
        r67_en <= '1';
        r9_en <= '1';
      when 1 =>
        r6_en <= '1';
        r7_en <= '1';
        sel_mem_0_addr <= 0;
        sel_mem_1_addr <= 0;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 2 =>
        r16_en <= '1';
        r17_en <= '1';
        r8_en <= '1';
        sel_mem_0_addr <= 1;
        sel_mem_1_addr <= 4;
        sel_mul_0_in0 <= 0;
        sel_mul_0_in1 <= 0;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 3 =>
        r18_en <= '1';
        r28_en <= '1';
        r29_en <= '1';
        sel_mem_0_addr <= 3;
        sel_mem_1_addr <= 8;
        sel_mul_0_in0 <= 1;
        sel_mul_0_in1 <= 1;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 4 =>
        r19_en <= '1';
        r30_en <= '1';
        r32_en <= '1';
        r33_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 0;
        sel_mem_0_addr <= 2;
        sel_mem_1_addr <= 1;
        sel_mul_0_in0 <= 2;
        sel_mul_0_in1 <= 2;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 5 =>
        r31_en <= '1';
        r34_en <= '1';
        r35_en <= '1';
        r36_en <= '1';
        sel_add_0_in0 <= 1;
        sel_add_0_in1 <= 1;
        sel_mem_0_addr <= 4;
        sel_mem_1_addr <= 5;
        sel_mul_0_in0 <= 3;
        sel_mul_0_in1 <= 3;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 6 =>
        r37_en <= '1';
        r43_en <= '1';
        r44_en <= '1';
        sel_mem_0_addr <= 6;
        sel_mem_1_addr <= 9;
        sel_mem_2_addr <= 0;
        sel_mem_2_val <= 0;
        sel_mul_0_in0 <= 4;
        sel_mul_0_in1 <= 4;
        mem_0_en <= '1';
        mem_1_en <= '1';
        mem_2_en <= '1';
        mem_2_we <= '1';
      when 7 =>
        r38_en <= '1';
        r45_en <= '1';
        r47_en <= '1';
        r48_en <= '1';
        sel_add_0_in0 <= 2;
        sel_add_0_in1 <= 2;
        sel_mem_0_addr <= 5;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 5;
        sel_mul_0_in1 <= 5;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 8 =>
        r46_en <= '1';
        r49_en <= '1';
        r50_en <= '1';
        r51_en <= '1';
        sel_add_0_in0 <= 3;
        sel_add_0_in1 <= 3;
        sel_mem_0_addr <= 7;
        sel_mem_1_addr <= 6;
        sel_mul_0_in0 <= 6;
        sel_mul_0_in1 <= 6;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 9 =>
        r52_en <= '1';
        r56_en <= '1';
        r57_en <= '1';
        sel_mem_0_addr <= 9;
        sel_mem_1_addr <= 10;
        sel_mem_2_addr <= 1;
        sel_mem_2_val <= 1;
        sel_mul_0_in0 <= 7;
        sel_mul_0_in1 <= 7;
        mem_0_en <= '1';
        mem_1_en <= '1';
        mem_2_en <= '1';
        mem_2_we <= '1';
      when 10 =>
        r53_en <= '1';
        r58_en <= '1';
        r60_en <= '1';
        r61_en <= '1';
        sel_add_0_in0 <= 4;
        sel_add_0_in1 <= 4;
        sel_mem_0_addr <= 8;
        sel_mem_1_addr <= 3;
        sel_mul_0_in0 <= 8;
        sel_mul_0_in1 <= 8;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 11 =>
        r59_en <= '1';
        r62_en <= '1';
        r63_en <= '1';
        r64_en <= '1';
        sel_add_0_in0 <= 5;
        sel_add_0_in1 <= 5;
        sel_mem_0_addr <= 10;
        sel_mem_1_addr <= 7;
        sel_mul_0_in0 <= 9;
        sel_mul_0_in1 <= 9;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 12 =>
        r65_en <= '1';
        r68_en <= '1';
        r69_en <= '1';
        sel_mem_0_addr <= 11;
        sel_mem_1_addr <= 11;
        sel_mem_2_addr <= 2;
        sel_mem_2_val <= 2;
        sel_mul_0_in0 <= 10;
        sel_mul_0_in1 <= 10;
        mem_0_en <= '1';
        mem_1_en <= '1';
        mem_2_en <= '1';
        mem_2_we <= '1';
      when 13 =>
        r66_en <= '1';
        r70_en <= '1';
        sel_add_0_in0 <= 6;
        sel_add_0_in1 <= 6;
        sel_mul_0_in0 <= 11;
        sel_mul_0_in1 <= 11;
      when 14 =>
        r71_en <= '1';
        sel_add_0_in0 <= 7;
        sel_add_0_in1 <= 7;
      when 15 =>
        sel_mem_2_addr <= 3;
        sel_mem_2_val <= 3;
        mem_2_en <= '1';
        mem_2_we <= '1';
      when 16 =>
        done <= '1';
      when others => null;
    end case;
  end process;
  
end architecture;