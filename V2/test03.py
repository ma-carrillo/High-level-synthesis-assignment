from pathlib import Path

from hls_core import (
    Mem, Cst, Add, Mul, Load, Store, Block,
    Interpreter,
    ASTToCDFG, Scheduler, ResourceBinder, RegisterAllocator,
    DatapathBuilder, UnifiedVHDLGenerator, DotPrinter,
    print_schedule, print_binding, print_edge_registers,
    print_datapath, DatapathDotPrinter
)

# =========================
# Global output folder
# =========================
OUT_DIR = Path("test03") 


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

    # Three memories: A, W, C
    A = Mem(6, init=[1, 2, 3, 4, 5, 6])
    W = Mem(3, init=[7, 8, 9])
    C = Mem(4, init=[0, 0, 0, 0])

    # Test case 03:
    # C[0] = A0*W0 + A1*W1 + A2*W2
    # C[1] = A1*W0 + A2*W1 + A3*W2
    # C[2] = A2*W0 + A3*W1 + A4*W2
    # C[3] = A3*W0 + A4*W1 + A5*W2
    prog = Block([
        Store(C, Cst(0),
            Add(
                Add(
                    Mul(Load(A, Cst(0)), Load(W, Cst(0))),
                    Mul(Load(A, Cst(1)), Load(W, Cst(1))),
                ),
                Mul(Load(A, Cst(2)), Load(W, Cst(2))),
            )),
        Store(C, Cst(1),
            Add(
                Add(
                    Mul(Load(A, Cst(1)), Load(W, Cst(0))),
                    Mul(Load(A, Cst(2)), Load(W, Cst(1))),
                ),
                Mul(Load(A, Cst(3)), Load(W, Cst(2))),
            )),
        Store(C, Cst(2),
            Add(
                Add(
                    Mul(Load(A, Cst(2)), Load(W, Cst(0))),
                    Mul(Load(A, Cst(3)), Load(W, Cst(1))),
                ),
                Mul(Load(A, Cst(4)), Load(W, Cst(2))),
            )),
        Store(C, Cst(3),
            Add(
                Add(
                    Mul(Load(A, Cst(3)), Load(W, Cst(0))),
                    Mul(Load(A, Cst(4)), Load(W, Cst(1))),
                ),
                Mul(Load(A, Cst(5)), Load(W, Cst(2))),
            )),
    ])


    print("\n=== INTERPRETER TEST ===")

    interp = Interpreter()
    interp.run(prog)

    print("Full RAM A state =", interp.dump_mem(A))
    print("Full RAM W state =", interp.dump_mem(W))
    print("Full RAM C state =", interp.dump_mem(C))

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
    gen = UnifiedVHDLGenerator(top_name="hls_top_unified_03")
    vhdl = gen.generate_full(dfg, dp, schedule, binding, edge_regs, dp_info)

    write_text("hls_top_unified_03.vhd", vhdl)

    print(f"\nWrote: {out_path('hls_top_unified_03.vhd')}")
    print("This file includes:")
    print("  - datapath structural instantiations (regs/RAM/add/mul)")
    print("  - mux combinational logic")
    print("  - FSM control (reg enables, mux selects, mem ctrl)")