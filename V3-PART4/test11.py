from pathlib import Path

from hls_core_part4 import (
    Mem, Cst, Add, Mul, Load, Store, Block,
    Interpreter,
    ASTToCDFG, Scheduler, ResourceBinder, RegisterAllocator,
    DatapathBuilder, UnifiedVHDLGenerator, DotPrinter,
    print_schedule, print_binding, print_edge_registers,
    print_datapath, DatapathDotPrinter, Assign, Var, For
)

# =========================
# Global output folder
# =========================
OUT_DIR = Path("test11") 


def out_path(filename: str) -> Path:
    """
    Return a path inside OUT_DIR and ensure OUT_DIR exists.
    """
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    return OUT_DIR / filename


def write_text(filename: str, text: str) -> None:
    """
    Convenience: write a text file into OUT_DIR.
    """
    p = out_path(filename)
    p.write_text(text, encoding="utf-8")


# =========================
# Demo: DOT + FULL unified VHDL + print_datapath(dp)
# =========================

if __name__ == "__main__":

    # One RAM
    ram = Mem(4, init=[7, 5, 11, 0])

    # ----------------------------------------------------------
    # Simple loop test
    #
    # s = new Register;
    # s = 0;
    # for (i=0..3) { // 4 iterations
    #     s = s + i;
    # }
    # ----------------------------------------------------------
    prog = Block([
        Assign("s", Cst(0)),
        For(Var("i"), 4,
            Assign("s", Add(Var("s"), Var("i")))
        ),
    ])



    print("\n=== INTERPRETER TEST ===")

    interp = Interpreter()
    interp.run(prog)

    print("Full RAM state =", interp.dump_mem(ram))
    print("s =", interp.load_var("s"))


    print("\n\n\n")

    # 1) Lower AST -> CDFG
    cfg = ASTToCDFG().lower_program(prog)
    bb = next(cfg.nodes())  # single block
    dfg = bb.dfg

    # 2) DOT output for DFG / CFG (include DFG inside CFG)
    printer = DotPrinter()

    dfg_dot = printer.to_dot_dfg(dfg, name="dfg")
    write_text("dfg.dot", dfg_dot)

    cfg_dot = printer.to_dot_cfg(cfg, name="cfg", include_dfg=True)
    write_text("cfg_with_dfg.dot", cfg_dot)

    print(f"Wrote: {out_path('dfg.dot')} and {out_path('cfg_with_dfg.dot')}")
    print("Render with:")
    print(f"  dot -Tpdf {out_path('dfg.dot')} -o {out_path('dfg.pdf')}")
    print(f"  dot -Tpdf {out_path('cfg_with_dfg.dot')} -o {out_path('cfg_with_dfg.pdf')}")

    # 3) Scheduling
    schedule = Scheduler().schedule_cfg(cfg)
    print("\n=== Schedule ===")
    print_schedule(dfg, schedule)

    # 4) Resource binding
    binder = ResourceBinder(
        adder_entity="Adder32",
        mul_entity="Mul32",
        mem_entity="RamSimple",
        cst_entity="Const"
    )
    binding, resources = binder.bind(dfg, schedule)

    print("\n=== Resource Binding ===")
    print_binding(dfg, schedule, binding)

    print("\nResources instantiated in the circuit:")
    adders = [r for r in resources if r.kind == "add"]
    muls   = [r for r in resources if r.kind == "mul"]
    mems   = [r for r in resources if r.kind == "mem"]
    csts   = [r for r in resources if r.kind == "cst"]
    print(f"  Adders:       {len(adders)}  {[r.instance for r in adders]}")
    print(f"  Multipliers:  {len(muls)}  {[r.instance for r in muls]}")
    print(f"  Memories:     {len(mems)}  {[r.instance for r in mems]}")
    print(f"  Const units:  {len(csts)}  {[r.instance for r in csts]}")

    # 5) Register allocation (edge -> register)
    edge_regs = RegisterAllocator().allocate(dfg)
    print("\n=== Register Allocation (edge -> register) ===")
    print_edge_registers(dfg, edge_regs)

    # 6) Datapath build (UPDATED builder that records mux_inputs)
    dp_builder = DatapathBuilder()
    dp, dp_info = dp_builder.build(dfg, schedule, binding, edge_regs)

    print("\n=== DATAPATH GRAPH (VERIFY) ===")
    print_datapath(dp)

    # 7) DOT output for datapath graph
    dp_printer = DatapathDotPrinter()
    dp_dot = dp_printer.to_dot_datapath(dp, name="datapath")
    write_text("datapath.dot", dp_dot)

    print(f"\nWrote: {out_path('datapath.dot')}")
    print("Render with:")
    print(f"  dot -Tpdf {out_path('datapath.dot')} -o {out_path('datapath.pdf')}")

    # Sanity: mux_inputs must exist for unified control generation
    if "mux_inputs" not in dp_info or not dp_info["mux_inputs"]:
        raise RuntimeError(
            "dp_info['mux_inputs'] is missing/empty. "
            "Make sure your DatapathBuilder records mux input ordering."
        )

    print("\n=== MUX INPUT ORDERING (dp_info['mux_inputs']) ===")
    for (res, portlab), reg_list in dp_info["mux_inputs"].items():
        print(f"  mux for {res.instance}.{portlab}: {reg_list}")

    # 8) Generate FULL unified VHDL (datapath + muxes + FSM control)
    gen = UnifiedVHDLGenerator(top_name="hls_top_unified_11")
    vhdl = gen.generate_full(dfg, dp, schedule, binding, edge_regs, dp_info)

    write_text("hls_top_unified_11.vhd", vhdl)

    print(f"\nWrote: {out_path('hls_top_unified_11.vhd')}")
    print("This file includes:")
    print("  - datapath structural instantiations (regs/RAM/add/mul)")
    print("  - mux combinational logic")
    print("  - FSM control (reg enables, mux selects, mem ctrl)")


