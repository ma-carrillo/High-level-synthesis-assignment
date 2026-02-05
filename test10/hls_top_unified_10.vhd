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
  
  signal sel_var_i_val : integer := 0;
  signal sel_var_j_val : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  
  
  signal sig_0_5_in : signed(31 downto 0);
  signal sig_0_6_in : signed(31 downto 0);
  signal sig_1_7_in : signed(31 downto 0);
  signal sig_2_8_in : signed(31 downto 0);
  signal sig_3_4_d : signed(31 downto 0);
  signal sig_4_5_in : signed(31 downto 0);
  signal sig_5_1_val : signed(31 downto 0);
  signal sig_6_2_val : signed(31 downto 0);
  signal sig_7_3_in0 : signed(31 downto 0);
  signal sig_8_3_in1 : signed(31 downto 0);
  
  signal var_i_en : std_logic;
  signal var_i_d  : signed(31 downto 0);
  signal var_i_q  : signed(31 downto 0);
  signal var_j_en : std_logic;
  signal var_j_d  : signed(31 downto 0);
  signal var_j_q  : signed(31 downto 0);
  
  signal add_0_y : signed(31 downto 0);
  
  signal state : integer range 0 to 3 := 0;
  
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
  
  sig_1_7_in <= var_i_q;
  sig_2_8_in <= var_j_q;
  
  U_r0: Reg32 port map(
    clk => clk,
    en  => r0_en,
    d   => sig_3_4_d,
    q   => r0_q
  );
  
  U_add_0: Adder32 port map(a => sig_7_3_in0, b => sig_8_3_in1, y => add_0_y);
  sig_3_4_d <= add_0_y;
  
  var_i_d <= sig_5_1_val;
  var_j_d <= sig_6_2_val;
  
  
  -- var_i_val mux driving sig_5_1_val
  process(all)
  begin
    case sel_var_i_val is
      when 0 => sig_5_1_val <= to_signed(4, 32);
      when 1 => sig_5_1_val <= r0_q;
      when others => sig_5_1_val <= (others => '0');
    end case;
  end process;
  
  -- var_j_val mux driving sig_6_2_val
  process(all)
  begin
    case sel_var_j_val is
      when 0 => sig_6_2_val <= to_signed(5, 32);
      when others => sig_6_2_val <= (others => '0');
    end case;
  end process;
  
  -- add_0_in0 mux driving sig_7_3_in0
  process(all)
  begin
    case sel_add_0_in0 is
      when 0 => sig_7_3_in0 <= var_i_q;
      when others => sig_7_3_in0 <= (others => '0');
    end case;
  end process;
  
  -- add_0_in1 mux driving sig_8_3_in1
  process(all)
  begin
    case sel_add_0_in1 is
      when 0 => sig_8_3_in1 <= var_j_q;
      when others => sig_8_3_in1 <= (others => '0');
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
          when 3 => state <= 3;
          when others => state <= 0;
        end case;
      end if;
    end if;
  end process;
  
  -- Control decode (combinational)
  process(all)
  begin
    r0_en <= '0';
    sel_var_i_val <= 0;
    sel_var_j_val <= 0;
    sel_add_0_in0 <= 0;
    sel_add_0_in1 <= 0;
    var_i_en <= '0';
    var_j_en <= '0';
    done <= '0';
    
    case state is
      when 0 =>
        sel_var_i_val <= 0;
        sel_var_j_val <= 0;
        var_i_en <= '1';
        var_j_en <= '1';
      when 1 =>
        r0_en <= '1';
        sel_add_0_in0 <= 0;
        sel_add_0_in1 <= 0;
      when 2 =>
        sel_var_i_val <= 1;
        var_i_en <= '1';
      when 3 =>
        done <= '1';
      when others => null;
    end case;
  end process;
  
end architecture;