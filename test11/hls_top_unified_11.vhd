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
  
  signal sel_var_s_val : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  
  
  signal sig_0_7_in : signed(31 downto 0);
  signal sig_0_8_in : signed(31 downto 0);
  signal sig_1_9_in : signed(31 downto 0);
  signal sig_2_3_d : signed(31 downto 0);
  signal sig_2_4_d : signed(31 downto 0);
  signal sig_2_5_d : signed(31 downto 0);
  signal sig_2_6_d : signed(31 downto 0);
  signal sig_3_7_in : signed(31 downto 0);
  signal sig_4_7_in : signed(31 downto 0);
  signal sig_5_7_in : signed(31 downto 0);
  signal sig_6_7_in : signed(31 downto 0);
  signal sig_7_1_val : signed(31 downto 0);
  signal sig_8_2_in1 : signed(31 downto 0);
  signal sig_9_2_in0 : signed(31 downto 0);
  
  signal var_s_en : std_logic;
  signal var_s_d  : signed(31 downto 0);
  signal var_s_q  : signed(31 downto 0);
  
  signal add_0_y : signed(31 downto 0);
  
  signal state : integer range 0 to 9 := 0;
  
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
  
  sig_1_9_in <= var_s_q;
  
  U_r0: Reg32 port map(
    clk => clk,
    en  => r0_en,
    d   => sig_2_3_d,
    q   => r0_q
  );
  U_r1: Reg32 port map(
    clk => clk,
    en  => r1_en,
    d   => sig_2_4_d,
    q   => r1_q
  );
  U_r2: Reg32 port map(
    clk => clk,
    en  => r2_en,
    d   => sig_2_5_d,
    q   => r2_q
  );
  U_r3: Reg32 port map(
    clk => clk,
    en  => r3_en,
    d   => sig_2_6_d,
    q   => r3_q
  );
  
  U_add_0: Adder32 port map(a => sig_9_2_in0, b => sig_8_2_in1, y => add_0_y);
  sig_2_3_d <= add_0_y;
  sig_2_4_d <= add_0_y;
  sig_2_5_d <= add_0_y;
  sig_2_6_d <= add_0_y;
  
  var_s_d <= sig_7_1_val;
  
  
  -- var_s_val mux driving sig_7_1_val
  process(all)
  begin
    case sel_var_s_val is
      when 0 => sig_7_1_val <= to_signed(0, 32);
      when 1 => sig_7_1_val <= r0_q;
      when 2 => sig_7_1_val <= r1_q;
      when 3 => sig_7_1_val <= r2_q;
      when 4 => sig_7_1_val <= r3_q;
      when others => sig_7_1_val <= (others => '0');
    end case;
  end process;
  
  -- add_0_in1 mux driving sig_8_2_in1
  process(all)
  begin
    case sel_add_0_in1 is
      when 0 => sig_8_2_in1 <= to_signed(0, 32);
      when 1 => sig_8_2_in1 <= to_signed(1, 32);
      when 2 => sig_8_2_in1 <= to_signed(2, 32);
      when 3 => sig_8_2_in1 <= to_signed(3, 32);
      when others => sig_8_2_in1 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in0 mux driving sig_9_2_in0
  process(all)
  begin
    case sel_add_0_in0 is
      when 0 => sig_9_2_in0 <= var_s_q;
      when 1 => sig_9_2_in0 <= var_s_q;
      when 2 => sig_9_2_in0 <= var_s_q;
      when 3 => sig_9_2_in0 <= var_s_q;
      when others => sig_9_2_in0 <= (others => '0');
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
          when 9 => state <= 9;
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
    sel_var_s_val <= 0;
    sel_add_0_in1 <= 0;
    sel_add_0_in0 <= 0;
    var_s_en <= '0';
    done <= '0';
    
    case state is
      when 0 =>
        sel_var_s_val <= 0;
        var_s_en <= '1';
      when 1 =>
        r0_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 0;
      when 2 =>
        sel_var_s_val <= 1;
        var_s_en <= '1';
      when 3 =>
        r1_en <= '1';
        sel_add_0_in0 <= 1;
        sel_add_0_in1 <= 1;
      when 4 =>
        sel_var_s_val <= 2;
        var_s_en <= '1';
      when 5 =>
        r2_en <= '1';
        sel_add_0_in0 <= 2;
        sel_add_0_in1 <= 2;
      when 6 =>
        sel_var_s_val <= 3;
        var_s_en <= '1';
      when 7 =>
        r3_en <= '1';
        sel_add_0_in0 <= 3;
        sel_add_0_in1 <= 3;
      when 8 =>
        sel_var_s_val <= 4;
        var_s_en <= '1';
      when 9 =>
        done <= '1';
      when others => null;
    end case;
  end process;
  
end architecture;