# =========================
# AST: Nodes + Interpreter
# =========================

class ASTNode:
    """Base class for all AST nodes."""
    pass


class Expr(ASTNode):
    """Expression: produces a runtime value."""
    def eval(self, interp):
        raise NotImplementedError


class Stmt(ASTNode):
    """Statement: changes machine state."""
    def exec(self, interp):
        raise NotImplementedError


class Mem(ASTNode):
    """
    Memory allocation node.
    - size: in bytes (we won't enforce types/widths)
    - init: optional initial content (list of ints)
    """
    def __init__(self, size, init=None):
        self.size = size
        self.init = list(init) if init is not None else []

    def __repr__(self):
        return f"Mem(size={self.size})"


class Cst(Expr):
    """Constant integer."""
    def __init__(self, value):
        self.value = value

    def eval(self, interp):
        return self.value

    def __repr__(self):
        return f"Cst({self.value})"


class Add(Expr):
    def __init__(self, l, r):
        self.l = l
        self.r = r

    def eval(self, interp):
        return self.l.eval(interp) + self.r.eval(interp)

    def __repr__(self):
        return f"Add({self.l}, {self.r})"


class Mul(Expr):
    def __init__(self, l, r):
        self.l = l
        self.r = r

    def eval(self, interp):
        return self.l.eval(interp) * self.r.eval(interp)

    def __repr__(self):
        return f"Mul({self.l}, {self.r})"


class Load(Expr):
    def __init__(self, mem, addr):
        # mem : Mem
        #   Reference to the memory object being accessed (e.g., RAM)
        self.mem = mem
        # addr : Expr
        #   Expression that computes the memory address (index)
        #   Example: Cst(3), Add(Cst(1), Cst(2))
        self.addr = addr

    def eval(self, interp):
        # a : int
        #   Concrete address obtained by evaluating the address expression
        a = self.addr.eval(interp)

        # Read from memory "mem" at address "a"
        return interp.load(self.mem, a)

    def __repr__(self):
        return f"Load({self.mem}, {self.addr})"


class Store(Stmt):
    def __init__(self, mem, addr, val):
        # mem : Mem
        #   Reference to the memory object being written to
        self.mem = mem
        # addr : Expr
        #   Expression that computes the memory address (index)
        #   Determines *where* the value will be stored
        self.addr = addr
        # val : Expr
        #   Expression that computes the value to be written
        #   Determines *what* will be stored
        self.val = val

    def exec(self, interp):
        a = self.addr.eval(interp)
        v = self.val.eval(interp)
        # Perform the side effect:
        #   store value v into memory mem at address a
        interp.store(self.mem, a, v)

    def __repr__(self):
        return f"Store({self.mem}, {self.addr}, {self.val})"


# =========================
# Interpreter
# =========================

class Interpreter:
    """
    Interprets a program AST.

    Memory model:
    - Each Mem corresponds to a Python list (word-addressed for simplicity).
    - addr is treated as an index into that list.
    - We ignore byte addressing 
    """
    def __init__(self):
        self._mem_map = {}  # Mem -> list[int]

    def _ensure_mem(self, mem):
        if mem not in self._mem_map:
            # Initialize with mem.init, and allow dynamic growth
            self._mem_map[mem] = list(mem.init)

    def load(self, mem, addr):
        self._ensure_mem(mem)
        arr = self._mem_map[mem]
        if addr < 0:
            raise IndexError(f"Negative address: {addr}")
        if addr >= len(arr):
            # Out of bounds -> treat as 0 (common simplification for debugging)
            return 0
        return arr[addr]

    def store(self, mem, addr, value):
        self._ensure_mem(mem)
        arr = self._mem_map[mem]
        if addr < 0:
            raise IndexError(f"Negative address: {addr}")
        # Grow memory as needed
        while addr >= len(arr):
            arr.append(0)
        arr[addr] = value

    def run(self, program):
        """
        program can be:
        - a single Stmt
        - a list/tuple of Stmt
        """
        if isinstance(program, (list, tuple)):
            for s in program:
                s.exec(self)
        else:
            program.exec(self)

    def dump_mem(self, mem, upto=None):
        self._ensure_mem(mem)
        arr = self._mem_map[mem]
        if upto is None:
            return list(arr)
        return list(arr[:upto])


# =========================
# Convenience builders
# =========================

def c(x):
    """Wrap python int -> Cst, pass-through Expr unchanged."""
    if isinstance(x, Expr):
        return x
    return Cst(x)

def add(a, b):
    return Add(c(a), c(b))

def mul(a, b):
    return Mul(c(a), c(b))

def load(mem, addr):
    return Load(mem, c(addr))

def store(mem, addr, val):
    return Store(mem, c(addr), c(val))







# =========================
# Directed Graph Primitives
# =========================

class Node:
    """Base graph node with a stable integer id."""
    def __init__(self, nid):
        self.id = nid

    def __repr__(self):
        return f"{self.__class__.__name__}#{self.id}"


class DiGraph:
    """
    Minimal directed graph.
    - Nodes are stored by id.
    - Edges are stored as adjacency lists: src_id -> list[(dst_id, label)]
    """
    def __init__(self):
        self._next_id = 0
        self._nodes = {}         # int -> Node
        self._succ = {}          # int -> list[(int, str|None)]
        self._pred = {}          # int -> list[(int, str|None)]

    def add_node(self, node):
        self._nodes[node.id] = node
        self._succ.setdefault(node.id, [])
        self._pred.setdefault(node.id, [])
        return node.id

    def new_id(self):
        nid = self._next_id
        self._next_id += 1
        return nid

    def connect(self, src_id, dst_id, label=None):
        self._succ[src_id].append((dst_id, label))
        self._pred[dst_id].append((src_id, label))

    def node(self, nid):
        return self._nodes[nid]

    def nodes(self):
        # deterministic order
        for nid in sorted(self._nodes.keys()):
            yield self._nodes[nid]

    def succ(self, nid):
        return list(self._succ.get(nid, []))

    def pred(self, nid):
        return list(self._pred.get(nid, []))


# =========================
# DFG (Data Flow Graph)
# =========================

class DFGNode(Node):
    """Base class for dataflow nodes."""
    def label(self):
        return self.__class__.__name__


class DFGAdd(DFGNode):
    pass


class DFGMul(DFGNode):
    pass


class DFGCst(DFGNode):
    def __init__(self, nid, value):
        super().__init__(nid)
        self.value = value

    def label(self):
        return f"Cst({self.value})"


class DFGLoad(DFGNode):
    def __init__(self, nid, mem):
        super().__init__(nid)
        self.mem = mem  # reference to AST Mem object

    def label(self):
        return f"Load(mem={id(self.mem)})"


class DFGStore(DFGNode):
    def __init__(self, nid, mem):
        super().__init__(nid)
        self.mem = mem  # reference to AST Mem object

    def label(self):
        return f"Store(mem={id(self.mem)})"


class DataFlowGraph(DiGraph):
    """
    DFG edges represent data dependencies.
    Convention:
      connect(producer, consumer, label="in0"/"in1"/"addr"/"val")
    The node itself stores no input references.
    """
    def __init__(self):
        super().__init__()


# =========================
# CFG (Control Flow Graph)
# =========================

class BasicBlock(Node):
    """
    A CFG node containing a DFG.
    For now: a single block per program.
    """
    def __init__(self, nid, name=None):
        super().__init__(nid)
        self.name = name or f"bb{nid}"
        self.dfg = DataFlowGraph()

    def label(self):
        return self.name


class ControlFlowGraph(DiGraph):
    """
    Directed control-flow graph.
    For now: will contain a single BasicBlock node.
    """
    def __init__(self):
        super().__init__()

    def new_block(self, name=None):
        bb = BasicBlock(self.new_id(), name=name)
        self.add_node(bb)
        return bb


# =========================
# Small DFG construction helpers (optional)
# =========================

class DFGBuilder:
    """
    Helper to allocate DFG nodes with fresh IDs and add them to a DFG.
    """
    def __init__(self, dfg):
        self.dfg = dfg

    def cst(self, value):
        n = DFGCst(self.dfg.new_id(), value)
        self.dfg.add_node(n)
        return n.id

    def add(self):
        n = DFGAdd(self.dfg.new_id())
        self.dfg.add_node(n)
        return n.id

    def mul(self):
        n = DFGMul(self.dfg.new_id())
        self.dfg.add_node(n)
        return n.id

    def load(self, mem):
        n = DFGLoad(self.dfg.new_id(), mem)
        self.dfg.add_node(n)
        return n.id

    def store(self, mem):
        n = DFGStore(self.dfg.new_id(), mem)
        self.dfg.add_node(n)
        return n.id


# =========================
# AST -> CDFG Lowering Pass
# =========================

class ASTToCDFG:
    """
    Lowers an AST program (single Stmt, no control flow) into a CDFG:
      CFG: 1 basic block ("entry")
      DFG: nodes for Cst/Add/Mul/Load/Store and edges for dependencies
    """

    def __init__(self):
        # Cache for constants is optional; keeps DFG smaller and deterministic-ish.
        self._cst_cache = {}  # value -> dfg_node_id

    def lower_program(self, program_stmt):
        cfg = ControlFlowGraph()
        bb = cfg.new_block("entry")

        self._builder = DFGBuilder(bb.dfg)
        self._dfg = bb.dfg

        self._lower_stmt(program_stmt)

        return cfg  # contains one block with its DFG

    # --------- Internal lowering helpers ---------

    def _lower_stmt(self, stmt):
        # Extend here later for sequences, etc.
        if isinstance(stmt, Store):
            self._lower_store(stmt)
        else:
            raise TypeError(f"Unsupported statement node: {type(stmt).__name__}")

    def _lower_store(self, st):
        # Build the producers first
        addr_id = self._lower_expr(st.addr)
        val_id = self._lower_expr(st.val)

        # Store node
        store_id = self._builder.store(st.mem)

        # Dependency edges into Store (inputs are edges, not fields)
        self._dfg.connect(addr_id, store_id, label="addr")
        self._dfg.connect(val_id, store_id, label="val")

        return store_id

    def _lower_expr(self, expr):
        if isinstance(expr, Cst):
            return self._lower_cst(expr)

        if isinstance(expr, Add):
            l_id = self._lower_expr(expr.l)
            r_id = self._lower_expr(expr.r)
            add_id = self._builder.add()
            self._dfg.connect(l_id, add_id, label="in0")
            self._dfg.connect(r_id, add_id, label="in1")
            return add_id

        if isinstance(expr, Mul):
            l_id = self._lower_expr(expr.l)
            r_id = self._lower_expr(expr.r)
            mul_id = self._builder.mul()
            self._dfg.connect(l_id, mul_id, label="in0")
            self._dfg.connect(r_id, mul_id, label="in1")
            return mul_id

        if isinstance(expr, Load):
            addr_id = self._lower_expr(expr.addr)
            load_id = self._builder.load(expr.mem)
            self._dfg.connect(addr_id, load_id, label="addr")
            return load_id

        raise TypeError(f"Unsupported expression node: {type(expr).__name__}")

    def _lower_cst(self, cst_node):
        v = cst_node.value
        if v in self._cst_cache:
            return self._cst_cache[v]
        nid = self._builder.cst(v)
        self._cst_cache[v] = nid
        return nid


# =========================
# Quick test
# =========================

"""
if __name__ == "__main__":
    # Build AST program:
    # RAM[3] = RAM[0] * RAM[1] + RAM[2]
    ram = Mem(1024, init=[7, 5, 11])

    prog = Store(
        ram, #Memory
        Cst(3), #Adress
        Add( #Value
            Mul(
                Load(ram, Cst(0)),
                Load(ram, Cst(1)),
            ),
            Load(ram, Cst(2)),
        ),
    )

    lowerer = ASTToCDFG()
    cfg = lowerer.lower_program(prog)

    # Print the single basic block DFG content
    bb = next(cfg.nodes())  # only block
    print("CFG block:", bb.label())

    print("\nDFG nodes:")
    for n in bb.dfg.nodes():
        print(f"  {n.id}: {n.label()}")

    print("\nDFG edges (src -> dst, label):")
    for n in bb.dfg.nodes():
        for (dst, lab) in bb.dfg.succ(n.id):
            print(f"  {n.id} -> {dst} [{lab}]")
"""




# =========================
# DOT Printer (GraphViz)
# =========================

class DotPrinter:
    """
    Minimal DOT printer for our DiGraph / CFG / DFG structures.

    Usage:
      dot = DotPrinter().to_dot_dfg(bb.dfg)
      dot = DotPrinter().to_dot_cfg(cfg, include_dfg=True)

    Then write to file:
      with open("out.dot","w") as f: f.write(dot)
    And render:
      dot -Tpdf out.dot -o out.pdf
    """

    def _escape(self, s):
        # Basic DOT string escaping
        return str(s).replace("\\", "\\\\").replace('"', '\\"')

    def _node_label(self, node):
        # Prefer node.label() if available, else repr
        if hasattr(node, "label") and callable(getattr(node, "label")):
            return node.label()
        return repr(node)

    def to_dot_digraph(self, graph, name="G"):
        """
        Generic digraph DOT (no clusters).
        """
        lines = []
        lines.append(f'digraph "{self._escape(name)}" {{')

        # Nodes
        for n in graph.nodes():
            lab = self._escape(self._node_label(n))
            lines.append(f'  n{n.id} [label="{lab}"];')

        # Edges
        for src in graph.nodes():
            for (dst, elab) in graph.succ(src.id):
                if elab is None:
                    lines.append(f"  n{src.id} -> n{dst};")
                else:
                    el = self._escape(elab)
                    lines.append(f'  n{src.id} -> n{dst} [label="{el}"];')

        lines.append("}")
        return "\n".join(lines)

    def to_dot_dfg(self, dfg, name="DFG"):
        # Right now DFG is just a DiGraph with nicer labels.
        return self.to_dot_digraph(dfg, name=name)

    def to_dot_cfg(self, cfg, name="CFG", include_dfg=False):
        """
        Prints CFG. If include_dfg=True, each basic block becomes a cluster
        containing its DFG nodes/edges. Also prints CFG edges between blocks.
        """
        lines = []
        lines.append(f'digraph "{self._escape(name)}" {{')
        lines.append("  compound=true;")  # enables edges to clusters if needed

        # --- Print each basic block ---
        for bb in cfg.nodes():
            # Cluster per block
            cluster_name = f"cluster_bb{bb.id}"
            bb_label = self._escape(bb.label() if hasattr(bb, "label") else f"bb{bb.id}")

            if include_dfg and hasattr(bb, "dfg"):
                lines.append(f'  subgraph "{cluster_name}" {{')
                lines.append(f'    label="{bb_label}";')
                lines.append("    style=rounded;")

                # DFG nodes (prefix with bb id to avoid collisions)
                for n in bb.dfg.nodes():
                    lab = self._escape(self._node_label(n))
                    lines.append(f'    bb{bb.id}_n{n.id} [label="{lab}"];')

                # DFG edges
                for src in bb.dfg.nodes():
                    for (dst, elab) in bb.dfg.succ(src.id):
                        if elab is None:
                            lines.append(f"    bb{bb.id}_n{src.id} -> bb{bb.id}_n{dst};")
                        else:
                            el = self._escape(elab)
                            lines.append(
                                f'    bb{bb.id}_n{src.id} -> bb{bb.id}_n{dst} [label="{el}"];'
                            )

                lines.append("  }")
            else:
                # CFG node only (no internal DFG)
                lines.append(f'  bb{bb.id} [label="{bb_label}", shape=box];')

        # --- CFG edges between blocks (currently none / single block) ---
        for src in cfg.nodes():
            for (dst, elab) in cfg.succ(src.id):
                if include_dfg:
                    # If clusters exist, connect cluster-to-cluster via lhead/ltail.
                    # We'll use invisible anchor nodes for simplicity.
                    # Create anchors once per block:
                    lines.append(f'  bb{src.id}_anchor [label="", shape=point, width=0.01];')
                    lines.append(f'  bb{dst}_anchor [label="", shape=point, width=0.01];')

                    if elab is None:
                        lines.append(
                            f'  bb{src.id}_anchor -> bb{dst}_anchor '
                            f'[ltail="cluster_bb{src.id}", lhead="cluster_bb{dst}"];'
                        )
                    else:
                        el = self._escape(elab)
                        lines.append(
                            f'  bb{src.id}_anchor -> bb{dst}_anchor '
                            f'[label="{el}", ltail="cluster_bb{src.id}", lhead="cluster_bb{dst}"];'
                        )
                else:
                    if elab is None:
                        lines.append(f"  bb{src.id} -> bb{dst};")
                    else:
                        el = self._escape(elab)
                        lines.append(f'  bb{src.id} -> bb{dst} [label="{el}"];')

        lines.append("}")
        return "\n".join(lines)


# =========================
# Quick end-to-end demo
# =========================

if __name__ == "__main__":
    # Requires AST + ASTToCDFG + Graph classes to be available in scope.
    ram = Mem(1024, init=[7, 5, 11])

    prog = Store(
        ram,
        Cst(3),
        Add(
            Mul(
                Load(ram, Cst(0)),
                Load(ram, Cst(1)),
            ),
            Load(ram, Cst(2)),
        ),
    )

    cfg = ASTToCDFG().lower_program(prog)

    printer = DotPrinter()

    # 1) Print only the DFG of the single block
    bb = next(cfg.nodes())
    dfg_dot = printer.to_dot_dfg(bb.dfg, name="example_dfg")
    with open("dfg.dot", "w") as f:
        f.write(dfg_dot)

    # 2) Print CFG with embedded DFG (cluster)
    cfg_dot = printer.to_dot_cfg(cfg, name="example_cfg", include_dfg=True)
    with open("cfg_with_dfg.dot", "w") as f:
        f.write(cfg_dot)

    print("Wrote: dfg.dot and cfg_with_dfg.dot")
    print("Render with:")
    print("  dot -Tpdf dfg.dot -o dfg.pdf")
    print("  dot -Tpdf cfg_with_dfg.dot -o cfg_with_dfg.pdf")



# =========================
# Quick sanity test: build a DFG manually
# =========================

"""
if __name__ == "__main__":
    # Suppose we want a DFG for: Store(ram, 3, Add(Mul(Load(ram,0),Load(ram,1)), Load(ram,2)))
    # (This is manual just to validate the data structures.)
    try:
        ram = Mem(1024, init=[7, 5, 11])  # uses your AST Mem class from previous step
    except NameError:
        # If you run this file standalone without AST definitions, just mock:
        class Mem:
            def __init__(self, size, init=None):
                self.size = size
                self.init = init or []
        ram = Mem(1024, init=[7, 5, 11])

    cfg = ControlFlowGraph()
    bb = cfg.new_block("entry")

    b = DFGBuilder(bb.dfg)

    n_addr0 = b.cst(0)
    n_addr1 = b.cst(1)
    n_addr2 = b.cst(2)
    n_addr3 = b.cst(3)

    n_ld0 = b.load(ram)
    n_ld1 = b.load(ram)
    n_ld2 = b.load(ram)

    # addr edges into loads
    bb.dfg.connect(n_addr0, n_ld0, label="addr")
    bb.dfg.connect(n_addr1, n_ld1, label="addr")
    bb.dfg.connect(n_addr2, n_ld2, label="addr")

    n_mul = b.mul()
    bb.dfg.connect(n_ld0, n_mul, label="in0")
    bb.dfg.connect(n_ld1, n_mul, label="in1")

    n_add = b.add()
    bb.dfg.connect(n_mul, n_add, label="in0")
    bb.dfg.connect(n_ld2, n_add, label="in1")

    n_st = b.store(ram)
    bb.dfg.connect(n_addr3, n_st, label="addr")
    bb.dfg.connect(n_add, n_st, label="val")

    # Print nodes + edges
    print("CFG blocks:")
    for n in cfg.nodes():
        print(" ", n, n.label())

    print("\nDFG nodes:")
    for n in bb.dfg.nodes():
        print(" ", n, n.label())

    print("\nDFG edges (src -> dst, label):")
    for n in bb.dfg.nodes():
        for (dst, lab) in bb.dfg.succ(n.id):
            print(f"  {n.id} -> {dst} [{lab}]")
"""


# =========================
# Example / Quick test
# =========================
"""
if __name__ == "__main__":
    # RAM = malloc(1024);
    # RAM[3] = RAM[0] * RAM[1] + RAM[2]
    ram = Mem(1024, init=[7, 5, 11])  # RAM[0]=7, RAM[1]=5, RAM[2]=11

    prog = store(
        ram,
        3,
        add(
            mul(load(ram, 0), load(ram, 1)),
            load(ram, 2)
        )
    )

    interp = Interpreter()
    interp.run(prog)

    print("RAM[3] =", interp.load(ram, 3))      # expects 7*5 + 11 = 46
    print("RAM[0..5] =", interp.dump_mem(ram, 6))
"""
