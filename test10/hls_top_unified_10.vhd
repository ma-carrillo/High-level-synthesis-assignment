library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hls_top_unified_10 is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    done  : out std_logic
  );
end entity;

architecture rtl of hls_top_unified_10 is
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
  
  signal sel_var_i_val : integer := 0;
  signal sel_var_j_val : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  
  
  signal sig_0_4 : signed(31 downto 0);
  signal sig_0_5 : signed(31 downto 0);
  signal sig_1_6 : signed(31 downto 0);
  signal sig_2_7 : signed(31 downto 0);
  signal sig_3_8 : signed(31 downto 0);
  signal sig_4_9 : signed(31 downto 0);
  signal sig_5_10 : signed(31 downto 0);
  signal sig_6_11 : signed(31 downto 0);
  signal sig_7_12 : signed(31 downto 0);
  signal sig_8_9 : signed(31 downto 0);
  signal sig_9_1 : signed(31 downto 0);
  signal sig_10_2 : signed(31 downto 0);
  signal sig_11_3 : signed(31 downto 0);
  signal sig_12_3 : signed(31 downto 0);
  
  signal var_i_en : std_logic;
  signal var_i_d  : signed(31 downto 0);
  signal var_i_q  : signed(31 downto 0);
  signal var_j_en : std_logic;
  signal var_j_d  : signed(31 downto 0);
  signal var_j_q  : signed(31 downto 0);
  
  signal add_0_y : signed(31 downto 0);
  
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
  U_var_i: Reg32 port map(
    clk => clk,
    en  => var_i_en,
    d   => var_i_d,
    q   => var_i_q
  );
  U_var_j: Reg32 port map(
    clk => clk,
    en  => var_j_en,
    d   => var_j_d,
    q   => var_j_q
  );
  
  sig_1_6 <= var_i_q;
  sig_2_7 <= var_j_q;
  
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
    d   => sig_2_7,
    q   => r3_q
  );
  U_r4: Reg32 port map(
    clk => clk,
    en  => r4_en,
    d   => sig_3_8,
    q   => r4_q
  );
  
  U_add_0: Adder32 port map(a => sig_11_3, b => sig_12_3, y => add_0_y);
  sig_3_8 <= add_0_y;
  
  var_i_d <= sig_9_1;
  var_j_d <= sig_10_2;
  sig_0_4 <= to_signed(0, 32);
  sig_0_5 <= to_signed(1, 32);
  
  
  -- var_i_val mux driving sig_9_1
  process(all)
  begin
    case sel_var_i_val is
      when 0 => sig_9_1 <= r0_q;
      when 1 => sig_9_1 <= r4_q;
      when others => sig_9_1 <= (others => '0');
    end case;
  end process;
  
  -- var_j_val mux driving sig_10_2
  process(all)
  begin
    case sel_var_j_val is
      when 0 => sig_10_2 <= r1_q;
      when others => sig_10_2 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in0 mux driving sig_11_3
  process(all)
  begin
    case sel_add_0_in0 is
      when 0 => sig_11_3 <= r2_q;
      when others => sig_11_3 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in1 mux driving sig_12_3
  process(all)
  begin
    case sel_add_0_in1 is
      when 0 => sig_12_3 <= r3_q;
      when others => sig_12_3 <= (others => '0');
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
    sel_var_i_val <= 0;
    sel_var_j_val <= 0;
    sel_add_0_in0 <= 0;
    sel_add_0_in1 <= 0;
    var_i_en <= '0';
    var_j_en <= '0';
    done <= '0';
    
    case state is
      when 0 =>
        r0_en <= '1';
        r1_en <= '1';
      when 1 =>
        sel_var_i_val <= 0;
        sel_var_j_val <= 0;
        var_i_en <= '1';
        var_j_en <= '1';
      when 2 =>
        r2_en <= '1';
        r3_en <= '1';
      when 3 =>
        r4_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 0;
      when 4 =>
        sel_var_i_val <= 1;
        var_i_en <= '1';
      when 5 =>
        done <= '1';
      when others => null;
    end case;
  end process;
  
end architecture;