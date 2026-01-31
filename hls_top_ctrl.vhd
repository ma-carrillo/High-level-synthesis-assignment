library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hls_top_ctrl is
  port(
    clk   : in  std_logic;
    rst   : in  std_logic;
    start : in  std_logic;
    done  : out std_logic
  );
end entity;

architecture rtl of hls_top_ctrl is
  signal r0_q  : signed(31 downto 0);
  signal r0_en : std_logic;
  signal r1_q  : signed(31 downto 0);
  signal r1_en : std_logic;
  signal r2_q  : signed(31 downto 0);
  signal r2_en : std_logic;
  signal r3_q  : signed(31 downto 0);
  signal r3_en : std_logic;
  signal r4_q  : signed(31 downto 0);
  signal r4_en : std_logic;
  signal r5_q  : signed(31 downto 0);
  signal r5_en : std_logic;
  signal r6_q  : signed(31 downto 0);
  signal r6_en : std_logic;
  signal r7_q  : signed(31 downto 0);
  signal r7_en : std_logic;
  signal r8_q  : signed(31 downto 0);
  signal r8_en : std_logic;
  
  signal sel_mem_0_addr : integer := 0;
  signal sel_mul_0_in0 : integer := 0;
  signal sel_mul_0_in1 : integer := 0;
  signal sel_add_0_in0 : integer := 0;
  signal sel_add_0_in1 : integer := 0;
  signal sel_mem_0_val : integer := 0;
  
  signal mem_0_en   : std_logic;
  signal mem_0_we   : std_logic;
  signal mem_0_addr : signed(31 downto 0);
  signal mem_0_din  : signed(31 downto 0);
  signal mem_0_dout : signed(31 downto 0);
  
  signal state : integer range 0 to 6 := 0;
  
  -- Components assumed to exist
  component Reg32 is
    port(clk: in std_logic; en: in std_logic; d: in signed(31 downto 0); q: out signed(31 downto 0));
  end component;
  
  component RamSimple is
    port(clk: in std_logic; en: in std_logic; we: in std_logic;
         addr: in signed(31 downto 0); din: in signed(31 downto 0); dout: out signed(31 downto 0));
  end component;
  
  component Adder32 is
    port(a: in signed(31 downto 0); b: in signed(31 downto 0); y: out signed(31 downto 0));
  end component;
  
  component Mul32 is
    port(a: in signed(31 downto 0); b: in signed(31 downto 0); y: out signed(31 downto 0));
  end component;
  
begin
  -- TODO: instantiate datapath components and mux combinational logic
  -- (you can keep your structural generator and plug it here)
  
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        state <= 0;
        done <= '0';
      else
        -- defaults each cycle
        r0_en <= '0';
        r1_en <= '0';
        r2_en <= '0';
        r3_en <= '0';
        r4_en <= '0';
        r5_en <= '0';
        r6_en <= '0';
        r7_en <= '0';
        r8_en <= '0';
        mem_0_en <= '0';
        mem_0_we <= '0';
        done <= '0';
        
        case state is
          when 0 =>
            r0_en <= '1';
            r1_en <= '1';
            r3_en <= '1';
            r6_en <= '1';
            state <= state + 1;
          when 1 =>
            r2_en <= '1';
            sel_mem_0_addr <= 1;
            mem_0_en <= '1';
            mem_0_addr <= r1_q;
            state <= state + 1;
          when 2 =>
            r4_en <= '1';
            sel_mem_0_addr <= 2;
            mem_0_en <= '1';
            mem_0_addr <= r3_q;
            state <= state + 1;
          when 3 =>
            r5_en <= '1';
            r7_en <= '1';
            sel_mem_0_addr <= 3;
            sel_mul_0_in0 <= 0;
            sel_mul_0_in1 <= 0;
            mem_0_en <= '1';
            mem_0_addr <= r6_q;
            state <= state + 1;
          when 4 =>
            r8_en <= '1';
            sel_add_0_in0 <= 0;
            sel_add_0_in1 <= 0;
            state <= state + 1;
          when 5 =>
            sel_mem_0_addr <= 0;
            sel_mem_0_val <= 0;
            mem_0_en <= '1';
            mem_0_we <= '1';
            mem_0_addr <= r0_q;
            mem_0_din <= r8_q;
            state <= state + 1;
          when 6 =>
            done <= '1';
            if start = '0' then
              state <= 0;
            end if;
          when others => state <= 0;
        end case;
      end if;
    end if;
  end process;
end architecture;