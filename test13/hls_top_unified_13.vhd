library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hls_top_unified_13 is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    done  : out std_logic
  );
end entity;

architecture rtl of hls_top_unified_13 is
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
  
  signal sel_var_s_val : integer := 0;
  signal sel_mem_0_addr : integer := 0;
  signal sel_mem_1_addr : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  signal sel_mul_0_in0 : integer := 0;
  signal sel_mul_0_in1 : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  
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
  
  signal sig_0_6 : signed(31 downto 0);
  signal sig_0_7 : signed(31 downto 0);
  signal sig_0_8 : signed(31 downto 0);
  signal sig_0_15 : signed(31 downto 0);
  signal sig_0_16 : signed(31 downto 0);
  signal sig_0_22 : signed(31 downto 0);
  signal sig_0_23 : signed(31 downto 0);
  signal sig_0_29 : signed(31 downto 0);
  signal sig_0_30 : signed(31 downto 0);
  signal sig_1_9 : signed(31 downto 0);
  signal sig_1_14 : signed(31 downto 0);
  signal sig_1_21 : signed(31 downto 0);
  signal sig_1_28 : signed(31 downto 0);
  signal sig_2_10 : signed(31 downto 0);
  signal sig_2_17 : signed(31 downto 0);
  signal sig_2_24 : signed(31 downto 0);
  signal sig_2_31 : signed(31 downto 0);
  signal sig_3_11 : signed(31 downto 0);
  signal sig_3_18 : signed(31 downto 0);
  signal sig_3_25 : signed(31 downto 0);
  signal sig_3_32 : signed(31 downto 0);
  signal sig_4_12 : signed(31 downto 0);
  signal sig_4_19 : signed(31 downto 0);
  signal sig_4_26 : signed(31 downto 0);
  signal sig_4_33 : signed(31 downto 0);
  signal sig_5_13 : signed(31 downto 0);
  signal sig_5_20 : signed(31 downto 0);
  signal sig_5_27 : signed(31 downto 0);
  signal sig_5_34 : signed(31 downto 0);
  signal sig_6_35 : signed(31 downto 0);
  signal sig_7_36 : signed(31 downto 0);
  signal sig_8_37 : signed(31 downto 0);
  signal sig_9_38 : signed(31 downto 0);
  signal sig_10_39 : signed(31 downto 0);
  signal sig_11_40 : signed(31 downto 0);
  signal sig_12_41 : signed(31 downto 0);
  signal sig_13_35 : signed(31 downto 0);
  signal sig_14_38 : signed(31 downto 0);
  signal sig_15_36 : signed(31 downto 0);
  signal sig_16_37 : signed(31 downto 0);
  signal sig_17_39 : signed(31 downto 0);
  signal sig_18_40 : signed(31 downto 0);
  signal sig_19_41 : signed(31 downto 0);
  signal sig_20_35 : signed(31 downto 0);
  signal sig_21_38 : signed(31 downto 0);
  signal sig_22_36 : signed(31 downto 0);
  signal sig_23_37 : signed(31 downto 0);
  signal sig_24_39 : signed(31 downto 0);
  signal sig_25_40 : signed(31 downto 0);
  signal sig_26_41 : signed(31 downto 0);
  signal sig_27_35 : signed(31 downto 0);
  signal sig_28_38 : signed(31 downto 0);
  signal sig_29_36 : signed(31 downto 0);
  signal sig_30_37 : signed(31 downto 0);
  signal sig_31_39 : signed(31 downto 0);
  signal sig_32_40 : signed(31 downto 0);
  signal sig_33_41 : signed(31 downto 0);
  signal sig_34_35 : signed(31 downto 0);
  signal sig_35_1 : signed(31 downto 0);
  signal sig_36_2 : signed(31 downto 0);
  signal sig_37_3 : signed(31 downto 0);
  signal sig_38_5 : signed(31 downto 0);
  signal sig_39_4 : signed(31 downto 0);
  signal sig_40_4 : signed(31 downto 0);
  signal sig_41_5 : signed(31 downto 0);
  
  signal var_s_en : std_logic;
  signal var_s_d  : signed(31 downto 0);
  signal var_s_q  : signed(31 downto 0);
  
  signal mul_0_y : signed(31 downto 0);
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
  
  sig_1_9 <= var_s_q;
  sig_1_14 <= var_s_q;
  sig_1_21 <= var_s_q;
  sig_1_28 <= var_s_q;
  
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
    d   => sig_1_9,
    q   => r3_q
  );
  U_r4: Reg32 port map(
    clk => clk,
    en  => r4_en,
    d   => sig_2_10,
    q   => r4_q
  );
  U_r5: Reg32 port map(
    clk => clk,
    en  => r5_en,
    d   => sig_3_11,
    q   => r5_q
  );
  U_r6: Reg32 port map(
    clk => clk,
    en  => r6_en,
    d   => sig_4_12,
    q   => r6_q
  );
  U_r7: Reg32 port map(
    clk => clk,
    en  => r7_en,
    d   => sig_5_13,
    q   => r7_q
  );
  U_r8: Reg32 port map(
    clk => clk,
    en  => r8_en,
    d   => sig_1_14,
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
    d   => sig_2_17,
    q   => r11_q
  );
  U_r12: Reg32 port map(
    clk => clk,
    en  => r12_en,
    d   => sig_3_18,
    q   => r12_q
  );
  U_r13: Reg32 port map(
    clk => clk,
    en  => r13_en,
    d   => sig_4_19,
    q   => r13_q
  );
  U_r14: Reg32 port map(
    clk => clk,
    en  => r14_en,
    d   => sig_5_20,
    q   => r14_q
  );
  U_r15: Reg32 port map(
    clk => clk,
    en  => r15_en,
    d   => sig_1_21,
    q   => r15_q
  );
  U_r16: Reg32 port map(
    clk => clk,
    en  => r16_en,
    d   => sig_0_22,
    q   => r16_q
  );
  U_r17: Reg32 port map(
    clk => clk,
    en  => r17_en,
    d   => sig_0_23,
    q   => r17_q
  );
  U_r18: Reg32 port map(
    clk => clk,
    en  => r18_en,
    d   => sig_2_24,
    q   => r18_q
  );
  U_r19: Reg32 port map(
    clk => clk,
    en  => r19_en,
    d   => sig_3_25,
    q   => r19_q
  );
  U_r20: Reg32 port map(
    clk => clk,
    en  => r20_en,
    d   => sig_4_26,
    q   => r20_q
  );
  U_r21: Reg32 port map(
    clk => clk,
    en  => r21_en,
    d   => sig_5_27,
    q   => r21_q
  );
  U_r22: Reg32 port map(
    clk => clk,
    en  => r22_en,
    d   => sig_1_28,
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
    d   => sig_2_31,
    q   => r25_q
  );
  U_r26: Reg32 port map(
    clk => clk,
    en  => r26_en,
    d   => sig_3_32,
    q   => r26_q
  );
  U_r27: Reg32 port map(
    clk => clk,
    en  => r27_en,
    d   => sig_4_33,
    q   => r27_q
  );
  U_r28: Reg32 port map(
    clk => clk,
    en  => r28_en,
    d   => sig_5_34,
    q   => r28_q
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
  
  U_mul_0: Mul32 port map(a => sig_39_4, b => sig_40_4, y => mul_0_y);
  sig_4_12 <= mul_0_y;
  sig_4_19 <= mul_0_y;
  sig_4_26 <= mul_0_y;
  sig_4_33 <= mul_0_y;
  U_add_0: Adder32 port map(a => sig_38_5, b => sig_41_5, y => add_0_y);
  sig_5_13 <= add_0_y;
  sig_5_20 <= add_0_y;
  sig_5_27 <= add_0_y;
  sig_5_34 <= add_0_y;
  
  var_s_d <= sig_35_1;
  sig_0_6 <= to_signed(0, 32);
  sig_0_7 <= to_signed(0, 32);
  sig_0_8 <= to_signed(0, 32);
  sig_0_15 <= to_signed(1, 32);
  sig_0_16 <= to_signed(1, 32);
  sig_0_22 <= to_signed(2, 32);
  sig_0_23 <= to_signed(2, 32);
  sig_0_29 <= to_signed(3, 32);
  sig_0_30 <= to_signed(3, 32);
  
  sig_2_10 <= mem_0_dout;
  sig_2_17 <= mem_0_dout;
  sig_2_24 <= mem_0_dout;
  sig_2_31 <= mem_0_dout;
  sig_3_11 <= mem_1_dout;
  sig_3_18 <= mem_1_dout;
  sig_3_25 <= mem_1_dout;
  sig_3_32 <= mem_1_dout;
  
  -- var_s_val mux driving sig_35_1
  process(all)
  begin
    case sel_var_s_val is
      when 0 => sig_35_1 <= r0_q;
      when 1 => sig_35_1 <= r7_q;
      when 2 => sig_35_1 <= r14_q;
      when 3 => sig_35_1 <= r21_q;
      when 4 => sig_35_1 <= r28_q;
      when others => sig_35_1 <= (others => '0');
    end case;
  end process;
  
  -- mem_0_addr mux driving sig_36_2
  process(all)
  begin
    case sel_mem_0_addr is
      when 0 => sig_36_2 <= r1_q;
      when 1 => sig_36_2 <= r9_q;
      when 2 => sig_36_2 <= r16_q;
      when 3 => sig_36_2 <= r23_q;
      when others => sig_36_2 <= (others => '0');
    end case;
  end process;
  
  -- mem_1_addr mux driving sig_37_3
  process(all)
  begin
    case sel_mem_1_addr is
      when 0 => sig_37_3 <= r2_q;
      when 1 => sig_37_3 <= r10_q;
      when 2 => sig_37_3 <= r17_q;
      when 3 => sig_37_3 <= r24_q;
      when others => sig_37_3 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in0 mux driving sig_38_5
  process(all)
  begin
    case sel_add_0_in0 is
      when 0 => sig_38_5 <= r3_q;
      when 1 => sig_38_5 <= r8_q;
      when 2 => sig_38_5 <= r15_q;
      when 3 => sig_38_5 <= r22_q;
      when others => sig_38_5 <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in0 mux driving sig_39_4
  process(all)
  begin
    case sel_mul_0_in0 is
      when 0 => sig_39_4 <= r4_q;
      when 1 => sig_39_4 <= r11_q;
      when 2 => sig_39_4 <= r18_q;
      when 3 => sig_39_4 <= r25_q;
      when others => sig_39_4 <= (others => '0');
    end case;
  end process;
  
  -- mul_0_in1 mux driving sig_40_4
  process(all)
  begin
    case sel_mul_0_in1 is
      when 0 => sig_40_4 <= r5_q;
      when 1 => sig_40_4 <= r12_q;
      when 2 => sig_40_4 <= r19_q;
      when 3 => sig_40_4 <= r26_q;
      when others => sig_40_4 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in1 mux driving sig_41_5
  process(all)
  begin
    case sel_add_0_in1 is
      when 0 => sig_41_5 <= r6_q;
      when 1 => sig_41_5 <= r13_q;
      when 2 => sig_41_5 <= r20_q;
      when 3 => sig_41_5 <= r27_q;
      when others => sig_41_5 <= (others => '0');
    end case;
  end process;
  
  mem_0_addr <= sig_36_2;
  mem_1_addr <= sig_37_3;
  
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
    r3_en <= '0';
    r4_en <= '0';
    r5_en <= '0';
    r6_en <= '0';
    r7_en <= '0';
    r8_en <= '0';
    r9_en <= '0';
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
        r10_en <= '1';
        r16_en <= '1';
        r17_en <= '1';
        r2_en <= '1';
        r23_en <= '1';
        r24_en <= '1';
        r9_en <= '1';
      when 1 =>
        r4_en <= '1';
        r5_en <= '1';
        sel_mem_0_addr <= 0;
        sel_mem_1_addr <= 0;
        sel_var_s_val <= 0;
        mem_0_en <= '1';
        mem_1_en <= '1';
        var_s_en <= '1';
      when 2 =>
        r11_en <= '1';
        r12_en <= '1';
        r3_en <= '1';
        r6_en <= '1';
        sel_mem_0_addr <= 1;
        sel_mem_1_addr <= 1;
        sel_mul_0_in0 <= 0;
        sel_mul_0_in1 <= 0;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 3 =>
        r13_en <= '1';
        r18_en <= '1';
        r19_en <= '1';
        r7_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 0;
        sel_mem_0_addr <= 2;
        sel_mem_1_addr <= 2;
        sel_mul_0_in0 <= 1;
        sel_mul_0_in1 <= 1;
        mem_0_en <= '1';
        mem_1_en <= '1';
      when 4 =>
        r20_en <= '1';
        r25_en <= '1';
        r26_en <= '1';
        sel_mem_0_addr <= 3;
        sel_mem_1_addr <= 3;
        sel_mul_0_in0 <= 2;
        sel_mul_0_in1 <= 2;
        sel_var_s_val <= 1;
        mem_0_en <= '1';
        mem_1_en <= '1';
        var_s_en <= '1';
      when 5 =>
        r27_en <= '1';
        r8_en <= '1';
        sel_mul_0_in0 <= 3;
        sel_mul_0_in1 <= 3;
      when 6 =>
        r14_en <= '1';
        sel_add_0_in0 <= 1;
        sel_add_0_in1 <= 1;
      when 7 =>
        sel_var_s_val <= 2;
        var_s_en <= '1';
      when 8 =>
        r15_en <= '1';
      when 9 =>
        r21_en <= '1';
        sel_add_0_in0 <= 2;
        sel_add_0_in1 <= 2;
      when 10 =>
        sel_var_s_val <= 3;
        var_s_en <= '1';
      when 11 =>
        r22_en <= '1';
      when 12 =>
        r28_en <= '1';
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