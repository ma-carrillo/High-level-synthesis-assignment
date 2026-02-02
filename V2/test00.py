from hls_core import (
    
    Mem, Cst, Add, Mul, Load, Store, Block,
    Interpreter,
    ASTToCDFG, Scheduler, ResourceBinder, RegisterAllocator,
    DatapathBuilder, UnifiedVHDLGenerator, DotPrinter, 
    print_schedule, print_binding, print_edge_registers, 
    print_datapath, DatapathDotPrinter

)


# =========================
# Demo: DOT + FULL unified VHDL + print_datapath(dp)
# (Single test case: RAM[3] = RAM[0]*RAM[1] + RAM[2])
# =========================

if __name__ == "__main__":
    # One RAM
    ram = Mem(1024, init=[7, 5, 11])

    # Test case 00
    prog = Block([Store(
        ram,
        Cst(3),
        Add(
            Mul(
                Load(ram, Cst(0)),
                Load(ram, Cst(1)),
            ),
            Load(ram, Cst(2)),
        ),
    )])

    # 1) Lower AST -> CDFG
    cfg = ASTToCDFG().lower_program(prog)
    bb = next(cfg.nodes())  # single block
    dfg = bb.dfg

    # 2) DOT output for DFG / CFG (include DFG inside CFG)
    printer = DotPrinter()

    dfg_dot = printer.to_dot_dfg(dfg, name="example_dfg")
    with open("dfg.dot", "w") as f:
        f.write(dfg_dot)

    cfg_dot = printer.to_dot_cfg(cfg, name="example_cfg", include_dfg=True)
    with open("cfg_with_dfg.dot", "w") as f:
        f.write(cfg_dot)

    print("Wrote: dfg.dot and cfg_with_dfg.dot")
    print("Render with:")
    print("  dot -Tpdf dfg.dot -o dfg.pdf")
    print("  dot -Tpdf cfg_with_dfg.dot -o cfg_with_dfg.pdf")

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
    dp_dot = dp_printer.to_dot_datapath(dp, name="example_datapath")
    with open("datapath.dot", "w") as f:
        f.write(dp_dot)

    print("\nWrote: datapath.dot")
    print("Render with:")
    print("  dot -Tpdf datapath.dot -o datapath.pdf")

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
    gen = UnifiedVHDLGenerator(top_name="hls_top_unified")
    vhdl = gen.generate_full(dfg, dp, schedule, binding, edge_regs, dp_info)

    with open("hls_top_unified.vhd", "w") as f:
        f.write(vhdl)

    print("\nWrote: hls_top_unified.vhd")
    print("This file includes:")
    print("  - datapath structural instantiations (regs/RAM/add/mul)")
    print("  - mux combinational logic")
    print("  - FSM control (reg enables, mux selects, mem ctrl)")
