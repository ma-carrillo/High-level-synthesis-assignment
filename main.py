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
# Scheduling (List Scheduling, 1-cycle ops, infinite ALU/MUL, 1 mem access per Mem per cycle)
# =========================

class Scheduler:
    """
    List scheduler for a single-basic-block DFG.

    Assumptions (per assignment):
    - All operations take 1 cycle.
    - Infinite adders and multipliers (so Add/Mul never contend).
    - Memory constraint: for each Mem, at most ONE memory access (Load or Store)
      can be scheduled in the same cycle.
    - No control flow: CFG has a single block containing a single DFG.

    Output:
      schedule: dict[dfg_node_id] = cycle_time (int)
    """

    def schedule_cfg(self, cfg):
        # Single block assumption
        bb = next(cfg.nodes())
        return self.schedule_dfg(bb.dfg)

    def schedule_dfg(self, dfg):
        # Predecessor counts (unscheduled deps)
        remaining_preds = {}
        for n in dfg.nodes():
            remaining_preds[n.id] = len(dfg.pred(n.id))

        # Ready set: nodes with no unscheduled predecessors
        ready = [n.id for n in dfg.nodes() if remaining_preds[n.id] == 0]
        ready.sort()

        # Schedule result
        time_of = {}  # nid -> cycle

        # For choosing resource queues
        def op_resource(nid):
            n = dfg.node(nid)
            if isinstance(n, DFGAdd):
                return ("add", None)
            if isinstance(n, DFGMul):
                return ("mul", None)
            if isinstance(n, (DFGLoad, DFGStore)):
                # One resource per memory instance
                return ("mem", n.mem)
            if isinstance(n, DFGCst):
                return ("cst", None)
            raise TypeError(f"Unknown DFG node type: {type(n).__name__}")

        # Simple priority: deterministic by node id
        def sort_ready(lst):
            lst.sort()

        cycle = 0
        unscheduled = set(remaining_preds.keys())

        while unscheduled:
            # Build per-resource ready lists for this cycle
            add_ready = []
            mul_ready = []
            cst_ready = []
            mem_ready = {}  # mem_obj -> [nid, nid, ...]

            for nid in ready:
                kind, mem = op_resource(nid)
                if kind == "add":
                    add_ready.append(nid)
                elif kind == "mul":
                    mul_ready.append(nid)
                elif kind == "cst":
                    cst_ready.append(nid)
                elif kind == "mem":
                    mem_ready.setdefault(mem, []).append(nid)

            sort_ready(add_ready)
            sort_ready(mul_ready)
            sort_ready(cst_ready)
            for m in mem_ready:
                sort_ready(mem_ready[m])

            scheduled_this_cycle = []

            # Infinite adders/muls/csts: schedule ALL ready nodes of those kinds
            scheduled_this_cycle.extend(cst_ready)
            scheduled_this_cycle.extend(add_ready)
            scheduled_this_cycle.extend(mul_ready)

            # Memory: for each Mem, schedule at most ONE op (Load or Store)
            for m, lst in mem_ready.items():
                if lst:
                    scheduled_this_cycle.append(lst[0])  # pick first by id

            # If nothing scheduled, we are stuck (cycle or graph issue)
            if not scheduled_this_cycle:
                raise RuntimeError(
                    "Scheduling made no progress. Graph may contain a cycle "
                    "or remaining_preds/ready is inconsistent."
                )

            # Commit scheduled nodes at 'cycle'
            for nid in scheduled_this_cycle:
                if nid not in unscheduled:
                    continue
                time_of[nid] = cycle
                unscheduled.remove(nid)

            # Update remaining_preds and ready for next cycle
            newly_ready = []
            for nid in scheduled_this_cycle:
                for (dst, _lab) in dfg.succ(nid):
                    if dst in unscheduled:
                        remaining_preds[dst] -= 1
                        if remaining_preds[dst] == 0:
                            newly_ready.append(dst)

            # Remove scheduled nodes from ready list and add newly ready nodes
            ready = [nid for nid in ready if nid not in scheduled_this_cycle]
            ready.extend(newly_ready)
            sort_ready(ready)

            cycle += 1

        return time_of


# =========================
# (Optional) quick test helper
# =========================

def print_schedule(dfg, schedule):
    # Print by time then id (deterministic)
    items = sorted(schedule.items(), key=lambda kv: (kv[1], kv[0]))
    for nid, t in items:
        print(f"t={t:>2}  node {nid:>2}: {dfg.node(nid).label()}")



# =========================
# Resource Binding
# =========================

class Resource:
    """
    Models a hardware resource (a VHDL entity instance) that can be reused over time.
    - kind: semantic type ("add", "mul", "mem")
    - name: VHDL entity/component name (e.g. "Adder", "Multiplier", "RAM")
    - instance: instance name used in VHDL (e.g. "add_0")
    - ports: dict describing ports (kept simple for now; used later in VHDL generation)
    - mem: for memory resources, which Mem object this resource corresponds to (else None)
    """
    def __init__(self, kind, name, instance, ports=None, mem=None):
        self.kind = kind
        self.name = name
        self.instance = instance
        self.ports = ports or {}
        self.mem = mem

    def __repr__(self):
        if self.kind == "mem":
            return f"Resource({self.instance}, kind=mem, mem={id(self.mem)})"
        return f"Resource({self.instance}, kind={self.kind})"


class ResourceBinder:
    """
    Binds each scheduled DFG node to a concrete resource instance.
    Goal:
      - Reuse resources as much as possible across cycles.
      - Unlimited resources available if needed.

    Policy:
      - Add nodes share a pool of adder instances.
      - Mul nodes share a pool of multiplier instances.
      - Memory nodes are bound to the unique memory resource for their Mem (one per Mem).
      - Cst nodes typically don't require a functional unit; we bind them to a pseudo-resource.
    """

    def __init__(self,
                 adder_entity="Adder",
                 mul_entity="Multiplier",
                 mem_entity="RAM",
                 cst_entity="Const"):
        self.adder_entity = adder_entity
        self.mul_entity = mul_entity
        self.mem_entity = mem_entity
        self.cst_entity = cst_entity

    def bind(self, dfg, schedule):
        """
        Args:
          dfg: DataFlowGraph
          schedule: dict[nid] -> time

        Returns:
          binding: dict[nid] -> Resource
          resources: list[Resource] (all instantiated resources)
        """

        # Group nodes by cycle
        by_t = {}
        for nid, t in schedule.items():
            by_t.setdefault(t, []).append(nid)
        for t in by_t:
            by_t[t].sort()

        # Pools for reusable resources
        adders = []      # list[Resource]
        muls = []        # list[Resource]
        mems = {}        # Mem -> Resource (exactly one per Mem)
        cst_res = Resource("cst", self.cst_entity, "cst", ports={"out": "int"})

        binding = {}

        # Helper: classify node to a resource kind
        def kind_of(n):
            if isinstance(n, DFGAdd):
                return "add"
            if isinstance(n, DFGMul):
                return "mul"
            if isinstance(n, (DFGLoad, DFGStore)):
                return "mem"
            if isinstance(n, DFGCst):
                return "cst"
            raise TypeError(f"Unknown DFG node type: {type(n).__name__}")

        # For each cycle, allocate resources for ops that occur in parallel
        # while reusing previous instances as much as possible.
        for t in sorted(by_t.keys()):
            nids = by_t[t]

            # Track which resource instances are used at this cycle
            used_add = set()
            used_mul = set()
            # memory: already one per mem; usage constraint was enforced in scheduling

            for nid in nids:
                n = dfg.node(nid)
                k = kind_of(n)

                if k == "cst":
                    binding[nid] = cst_res
                    continue

                if k == "mem":
                    m = n.mem
                    if m not in mems:
                        idx = len(mems)
                        inst = f"mem_{idx}"
                        # Ports are placeholders; you can refine later for VHDL generation
                        ports = {"addr": "int", "din": "int", "dout": "int", "we": "bit", "clk": "bit"}
                        mems[m] = Resource("mem", self.mem_entity, inst, ports=ports, mem=m)
                    binding[nid] = mems[m]
                    continue

                if k == "add":
                    # find a free adder instance for this cycle
                    chosen = None
                    for i, r in enumerate(adders):
                        if i not in used_add:
                            chosen = (i, r)
                            break
                    if chosen is None:
                        i = len(adders)
                        inst = f"add_{i}"
                        ports = {"a": "int", "b": "int", "y": "int"}
                        r = Resource("add", self.adder_entity, inst, ports=ports)
                        adders.append(r)
                        chosen = (i, r)
                    used_add.add(chosen[0])
                    binding[nid] = chosen[1]
                    continue

                if k == "mul":
                    # find a free multiplier instance for this cycle
                    chosen = None
                    for i, r in enumerate(muls):
                        if i not in used_mul:
                            chosen = (i, r)
                            break
                    if chosen is None:
                        i = len(muls)
                        inst = f"mul_{i}"
                        ports = {"a": "int", "b": "int", "y": "int"}
                        r = Resource("mul", self.mul_entity, inst, ports=ports)
                        muls.append(r)
                        chosen = (i, r)
                    used_mul.add(chosen[0])
                    binding[nid] = chosen[1]
                    continue

        # Collect all resources that will exist in the circuit
        resources = []
        resources.extend(adders)
        resources.extend(muls)
        resources.extend(mems.values())
        resources.append(cst_res)

        return binding, resources


# =========================
# (Optional) pretty-print binding
# =========================

def print_binding(dfg, schedule, binding):
    items = sorted(schedule.items(), key=lambda kv: (kv[1], kv[0]))
    for nid, t in items:
        nlab = dfg.node(nid).label()
        r = binding[nid]
        print(f"t={t:>2}  node {nid:>2}: {nlab:<25} -> {r.instance} ({r.kind})")


# =========================
# Register Allocation
# =========================

class Register:
    """
    Models a register that will hold a value between cycles.
    For now: infinite registers, so we just create new ones as needed.
    """
    def __init__(self, name):
        self.name = name  # e.g., "r0", "r1", ...

    def __repr__(self):
        return f"Reg({self.name})"


class RegisterAllocator:
    """
    Assigns registers to DFG edges (producer -> consumer).
    Rule (per assignment):
      - One register per edge that carries a produced value.
      - Store nodes do not produce a value, so edges *out of Store* don't exist anyway.
      - We allocate registers for edges out of:
          Cst, Add, Mul, Load
        and into:
          Add, Mul, Load (addr), Store (addr/val)
    Why edge-based:
      - A node's output may feed multiple consumers => different edges may need different regs.
    """

    def __init__(self):
        self._next_reg = 0

    def _new_reg(self):
        r = Register(f"r{self._next_reg}")
        self._next_reg += 1
        return r

    def allocate(self, dfg):
        """
        Returns:
          edge_regs: dict[(src_id, dst_id, label)] -> Register
        """
        edge_regs = {}

        for src in dfg.nodes():
            src_node = dfg.node(src.id)

            # Store produces no result; skip allocating regs for its outgoing edges (normally none)
            if isinstance(src_node, DFGStore):
                continue

            for (dst_id, lab) in dfg.succ(src.id):
                key = (src.id, dst_id, lab)
                edge_regs[key] = self._new_reg()

        return edge_regs


# =========================
# (Optional) pretty-print edge registers
# =========================

def print_edge_registers(dfg, edge_regs):
    """
    edge_regs keys are (src_id, dst_id, label)
    """
    items = sorted(edge_regs.items(), key=lambda kv: (kv[0][0], kv[0][1], str(kv[0][2])))
    for (src, dst, lab), reg in items:
        s_lab = dfg.node(src).label()
        d_lab = dfg.node(dst).label()
        print(f"  ({src} -> {dst}, {lab})  {s_lab} -> {d_lab}   => {reg.name}")


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

    # 1) Lower AST -> CDFG
    cfg = ASTToCDFG().lower_program(prog)
    bb = next(cfg.nodes())  # single block

    # 2) Scheduling
    sched = Scheduler()
    schedule = sched.schedule_cfg(cfg)

    print("\n=== Schedule ===")
    print_schedule(bb.dfg, schedule)

    # 3) Resource Binding
    binder = ResourceBinder(
        adder_entity="Adder",
        mul_entity="Multiplier",
        mem_entity="RAM",
        cst_entity="Const"
    )
    binding, resources = binder.bind(bb.dfg, schedule)

    print("\n=== Resource Binding ===")
    print_binding(bb.dfg, schedule, binding)

    print("\nResources instantiated:")
    print(f"  Adders: {[r.instance for r in resources if r.kind == 'add']}")
    print(f"  Muls:   {[r.instance for r in resources if r.kind == 'mul']}")
    print(f"  Mems:   {[r.instance for r in resources if r.kind == 'mem']}")

    # 4) Register Allocation (NEW)
    reg_alloc = RegisterAllocator()
    edge_regs = reg_alloc.allocate(bb.dfg)

    print("\n=== Register Allocation (edge -> register) ===")
    print_edge_registers(bb.dfg, edge_regs)


# =========================
# Datapath Graph + Naive Datapath Generation
# =========================

class DatapathNode(Node):
    """Base node in the datapath graph."""
    def label(self):
        return self.__class__.__name__


class DPResource(DatapathNode):
    """Wraps a bound Resource as a datapath node."""
    def __init__(self, nid, resource):
        super().__init__(nid)
        self.resource = resource  # Resource instance

    def label(self):
        return f"{self.resource.instance}:{self.resource.kind}"


class DPRegister(DatapathNode):
    """A register node (one per allocated Register object)."""
    def __init__(self, nid, reg):
        super().__init__(nid)
        self.reg = reg  # Register instance

    def label(self):
        return self.reg.name


class DPMux(DatapathNode):
    """
    Naive multiplexer placed in front of each resource input.
    - sel_width: not computed now; we just track number of inputs.
    """
    def __init__(self, nid, name):
        super().__init__(nid)
        self.name = name
        self.inputs = []  # list of (src_dp_node_id, src_signal_name)

    def label(self):
        return f"MUX({self.name})"


class DatapathGraph(DiGraph):
    """
    Directed datapath graph.
    Nodes: DPResource, DPRegister, DPMux
    Edges: represent wires/signals between components.
    Edge labels will represent port names on the destination side (e.g. "a", "b", "addr", "val").
    """
    def __init__(self):
        super().__init__()


class DatapathBuilder:
    """
    Builds a naive datapath graph from:
      - DFG
      - schedule (nid -> time) [not used heavily here, but kept for future]
      - resource binding (nid -> Resource)
      - register allocation (edge (src,dst,label) -> Register)

    Naive strategy:
      - Create a DPResource node for each unique Resource instance.
      - Create a DPRegister node for each Register instance.
      - For each DFG edge (src -> dst, lab):
          src produces a value that will be stored in the edge's Register.
          So connect: src_resource -> reg -> (mux for dst input) -> dst_resource
      - Insert one mux per *resource input port* (even if only one possible driver).
        (You can optimize them away later.)
    """

    def __init__(self):
        self._dp = DatapathGraph()

        # Maps to avoid duplicating nodes
        self._res_to_dpnid = {}   # Resource -> dp_node_id
        self._reg_to_dpnid = {}   # Register -> dp_node_id
        self._mux_to_dpnid = {}   # (dst_resource, port_label) -> dp_node_id

    def build(self, dfg, schedule, binding, edge_regs):
        """
        Returns:
          dp: DatapathGraph
          dp_info: dict with useful mappings for later FSM/VHDL generation
            - res_node: Resource -> dp_node_id
            - reg_node: Register -> dp_node_id
            - mux_node: (Resource, port_label) -> dp_node_id
            - edge_wire_name: (src_dp, dst_dp, label) -> wire_name (placeholder)
        """
        # 1) Create DPResource nodes for each instantiated resource used in binding
        for nid in sorted(binding.keys()):
            r = binding[nid]
            self._ensure_resource(r)

        # 2) Create DPRegister nodes for each allocated register
        for (_src, _dst, _lab), reg in edge_regs.items():
            self._ensure_register(reg)

        # 3) For each DFG edge, route through its register into a mux of the consumer input
        for src in dfg.nodes():
            src_id = src.id
            for (dst_id, lab) in dfg.succ(src_id):
                # Which register holds this edge value?
                edge_key = (src_id, dst_id, lab)
                if edge_key not in edge_regs:
                    # Should not happen for our current reg allocator (except Store outputs, which don't exist)
                    continue
                reg = edge_regs[edge_key]

                # Find producer and consumer resources
                src_res = binding[src_id]
                dst_res = binding[dst_id]

                # Get datapath node ids
                src_dp = self._ensure_resource(src_res)
                reg_dp = self._ensure_register(reg)

                # Connect producer resource -> register (register "d" input)
                # label is destination port name on the reg; keep simple as "d"
                self._dp.connect(src_dp, reg_dp, label="d")

                # Now for consumer input port, insert/get mux
                mux_dp = self._ensure_mux(dst_res, port_label=lab)

                # Connect register -> mux (mux input)
                self._dp.connect(reg_dp, mux_dp, label="in")

                # Finally mux -> consumer resource (port lab)
                dst_dp = self._ensure_resource(dst_res)
                self._dp.connect(mux_dp, dst_dp, label=lab)

        dp_info = {
            "res_node": dict(self._res_to_dpnid),
            "reg_node": dict(self._reg_to_dpnid),
            "mux_node": dict(self._mux_to_dpnid),
        }
        return self._dp, dp_info

    # ---------- internals ----------

    def _ensure_resource(self, r):
        if r in self._res_to_dpnid:
            return self._res_to_dpnid[r]
        nid = self._dp.new_id()
        n = DPResource(nid, r)
        self._dp.add_node(n)
        self._res_to_dpnid[r] = nid
        return nid

    def _ensure_register(self, reg):
        if reg in self._reg_to_dpnid:
            return self._reg_to_dpnid[reg]
        nid = self._dp.new_id()
        n = DPRegister(nid, reg)
        self._dp.add_node(n)
        self._reg_to_dpnid[reg] = nid
        return nid

    def _ensure_mux(self, dst_res, port_label):
        key = (dst_res, port_label)
        if key in self._mux_to_dpnid:
            return self._mux_to_dpnid[key]
        nid = self._dp.new_id()
        mux_name = f"{dst_res.instance}_{port_label}"
        n = DPMux(nid, mux_name)
        self._dp.add_node(n)
        self._mux_to_dpnid[key] = nid
        return nid


# =========================
# (Optional) DOT printer for datapath graph
# =========================

class DatapathDotPrinter(DotPrinter):
    """Reuse DotPrinter but provide a convenience name."""
    def to_dot_datapath(self, dp, name="DATAPATH"):
        return self.to_dot_digraph(dp, name=name)


# =========================
# (Optional) quick demo helper
# =========================

def print_datapath(dp):
    print("\nDatapath nodes:")
    for n in dp.nodes():
        if hasattr(n, "label"):
            print(f"  {n.id}: {n.label()}")
        else:
            print(f"  {n.id}: {repr(n)}")

    print("\nDatapath edges (src -> dst, label):")
    for n in dp.nodes():
        for (dst, lab) in dp.succ(n.id):
            print(f"  {n.id} -> {dst} [{lab}]")

class VHDLWriter:
    def __init__(self):
        self.lines = []
        self.ind = 0

    def writeln(self, s=""):
        self.lines.append("  " * self.ind + s)

    def indent(self):
        self.ind += 1

    def dedent(self):
        self.ind = max(0, self.ind - 1)

    def text(self):
        return "\n".join(self.lines)


class VHDLGenerator:
    def __init__(self, top_name="hls_top"):
        self.top_name = top_name

    def generate(self, dp, schedule, binding, edge_regs):
        """
        Args:
          dp: DatapathGraph
          schedule: dict[dfg_node_id] -> cycle
          binding: dict[dfg_node_id] -> Resource
          edge_regs: dict[(src_dfg, dst_dfg, label)] -> Register

        Returns:
          vhdl_text: str
        """

        w = VHDLWriter()

        # -------------------------
        # 1) Header + entity
        # -------------------------
        w.writeln("library ieee;")
        w.writeln("use ieee.std_logic_1164.all;")
        w.writeln("use ieee.numeric_std.all;")
        w.writeln("")
        w.writeln(f"entity {self.top_name} is")
        w.indent()
        w.writeln("port (")
        w.indent()
        w.writeln("clk   : in  std_logic;")
        w.writeln("rst   : in  std_logic;")
        w.writeln("start : in  std_logic;")
        w.writeln("done  : out std_logic");
        w.dedent()
        w.writeln(");")
        w.dedent()
        w.writeln("end entity;")
        w.writeln("")

        # -------------------------
        # 2) Architecture signals
        # -------------------------
        w.writeln(f"architecture rtl of {self.top_name} is")
        w.indent()

        # Helpers to make stable names
        edge_sig = {}   # (src_dp, dst_dp, label) -> signal_name
        reg_q = {}      # reg_name -> q_signal
        reg_en = {}     # reg_name -> en_signal
        mux_sel = {}    # mux_node_id -> sel_signal
        mem_ctrl = {}   # mem_instance -> dict(en,we,addr,din,dout)

        # 2a) declare signals for each DPRegister
        for n in dp.nodes():
            if isinstance(n, DPRegister):
                rname = n.reg.name
                qn = f"{rname}_q"
                en = f"{rname}_en"
                reg_q[rname] = qn
                reg_en[rname] = en
                w.writeln(f"signal {qn}  : signed(31 downto 0);")
                w.writeln(f"signal {en}  : std_logic;")

        w.writeln("")

        # 2b) declare signals for mux selects
        for n in dp.nodes():
            if isinstance(n, DPMux):
                sel = f"sel_{n.name}"
                mux_sel[n.id] = sel
                # naive: allow up to many inputs; you can tighten later
                w.writeln(f"signal {sel} : integer := 0;")

        w.writeln("")

        # 2c) declare RAM control signals for each memory Resource
        # Find unique mem resources from DFG binding
        mem_resources = {}
        for dfg_nid, res in binding.items():
            if res.kind == "mem":
                mem_resources[res.instance] = res

        for inst, res in sorted(mem_resources.items()):
            mem_ctrl[inst] = {
                "en":   f"{inst}_en",
                "we":   f"{inst}_we",
                "addr": f"{inst}_addr",
                "din":  f"{inst}_din",
                "dout": f"{inst}_dout",
            }
            w.writeln(f"signal {inst}_en   : std_logic;")
            w.writeln(f"signal {inst}_we   : std_logic;")
            w.writeln(f"signal {inst}_addr : signed(31 downto 0);")
            w.writeln(f"signal {inst}_din  : signed(31 downto 0);")
            w.writeln(f"signal {inst}_dout : signed(31 downto 0);")

        w.writeln("")

        # 2d) declare signals for each datapath edge
        for src in dp.nodes():
            for (dst, lab) in dp.succ(src.id):
                sname = f"sig_{src.id}_{dst}"
                edge_sig[(src.id, dst, lab)] = sname
                w.writeln(f"signal {sname} : signed(31 downto 0);")

        w.writeln("")

        # FSM state signal
        max_t = max(schedule.values()) if schedule else 0
        w.writeln(f"signal state : integer range 0 to {max_t+1} := 0;")
        w.writeln("")

        # -------------------------
        # 3) Component declarations (assume external entities exist)
        # -------------------------
        w.writeln("-- Component declarations (assumed to exist)")
        w.writeln("component Reg32 is")
        w.indent()
        w.writeln("port(clk: in std_logic; en: in std_logic; d: in signed(31 downto 0); q: out signed(31 downto 0));")
        w.dedent()
        w.writeln("end component;")

        w.writeln("component Adder32 is")
        w.indent()
        w.writeln("port(a: in signed(31 downto 0); b: in signed(31 downto 0); y: out signed(31 downto 0));")
        w.dedent()
        w.writeln("end component;")

        w.writeln("component Mul32 is")
        w.indent()
        w.writeln("port(a: in signed(31 downto 0); b: in signed(31 downto 0); y: out signed(31 downto 0));")
        w.dedent()
        w.writeln("end component;")

        w.writeln("component RamSimple is")
        w.indent()
        w.writeln("port(clk: in std_logic; en: in std_logic; we: in std_logic;")
        w.writeln("     addr: in signed(31 downto 0); din: in signed(31 downto 0); dout: out signed(31 downto 0));")
        w.dedent()
        w.writeln("end component;")
        w.writeln("")

        # -------------------------
        # 4) Begin architecture body
        # -------------------------
        w.dedent()
        w.writeln("begin")
        w.indent()

        # 4a) Instantiate registers
        for n in dp.nodes():
            if isinstance(n, DPRegister):
                r = n.reg.name
                w.writeln(f"U_{r}: Reg32 port map(")
                w.indent()
                w.writeln(f"clk => clk,")
                w.writeln(f"en  => {reg_en[r]},")
                # find its input edge signal: the edge into the reg has label="d"
                d_sig = self._find_single_pred_signal(dp, edge_sig, n.id, needed_label="d")
                w.writeln(f"d   => {d_sig},")
                w.writeln(f"q   => {reg_q[r]}")
                w.dedent()
                w.writeln(");")
        w.writeln("")

        # 4b) Instantiate RAMs
        for inst in sorted(mem_ctrl.keys()):
            c = mem_ctrl[inst]
            w.writeln(f"U_{inst}: RamSimple port map(")
            w.indent()
            w.writeln(f"clk  => clk,")
            w.writeln(f"en   => {c['en']},")
            w.writeln(f"we   => {c['we']},")
            w.writeln(f"addr => {c['addr']},")
            w.writeln(f"din  => {c['din']},")
            w.writeln(f"dout => {c['dout']}")
            w.dedent()
            w.writeln(");")
        w.writeln("")

        # 4c) Instantiate adders/muls (naive: infer inputs from incoming edges labels)
        # For a resource node, we look at its preds:
        #   - for add: expects ports "in0","in1" (your DFG labels)
        #   - for mul: expects ports "in0","in1"
        #
        # NOTE: right now dp edges into resource have labels like "in0"/"in1"/"addr"/"val".
        # For add/mul, use in0/in1.
        for n in dp.nodes():
            if isinstance(n, DPResource):
                res = n.resource
                if res.kind == "add":
                    a_sig = self._find_single_pred_signal(dp, edge_sig, n.id, needed_label="in0")
                    b_sig = self._find_single_pred_signal(dp, edge_sig, n.id, needed_label="in1")
                    y_sig = self._find_single_succ_signal(dp, edge_sig, n.id, needed_label="d")  # to reg
                    w.writeln(f"U_{res.instance}: Adder32 port map(a => {a_sig}, b => {b_sig}, y => {y_sig});")

                if res.kind == "mul":
                    a_sig = self._find_single_pred_signal(dp, edge_sig, n.id, needed_label="in0")
                    b_sig = self._find_single_pred_signal(dp, edge_sig, n.id, needed_label="in1")
                    y_sig = self._find_single_succ_signal(dp, edge_sig, n.id, needed_label="d")
                    w.writeln(f"U_{res.instance}: Mul32 port map(a => {a_sig}, b => {b_sig}, y => {y_sig});")

        w.writeln("")
        w.writeln("-- Muxes are not expanded here yet (next step: generate a process/case per mux).")
        w.writeln("")

        # -------------------------
        # 5) FSM skeleton (CONTROL)
        # -------------------------
        w.writeln("process(clk)")
        w.writeln("begin")
        w.indent()
        w.writeln("if rising_edge(clk) then")
        w.indent()
        w.writeln("if rst = '1' then")
        w.indent()
        w.writeln("state <= 0;")
        w.writeln("done <= '0';")
        w.dedent()
        w.writeln("else")
        w.indent()

        # Default control each cycle (good practice)
        w.writeln("-- defaults each cycle")
        for rname in reg_en:
            w.writeln(f"{reg_en[rname]} <= '0';")
        for inst in mem_ctrl:
            w.writeln(f"{mem_ctrl[inst]['en']} <= '0';")
            w.writeln(f"{mem_ctrl[inst]['we']} <= '0';")
        w.writeln("done <= '0';")
        w.writeln("")

        w.writeln("case state is")
        w.indent()

        # Create one FSM state per cycle 0..max_t, plus final state max_t+1
        for t in range(0, max_t + 1):
            w.writeln(f"when {t} =>")
            w.indent()

            # In this state you will:
            # - enable the registers whose producing op is scheduled at time t
            # - enable RAM control signals for load/store scheduled at time t
            #
            # For now, emit comments (you fill with derived controls next).
            w.writeln(f"-- TODO: assert reg enables for ops at time {t}")
            w.writeln(f"-- TODO: set mux selects for inputs used at time {t}")
            w.writeln(f"-- TODO: set RAM en/we/addr/din for loads/stores at time {t}")
            w.writeln("state <= state + 1;")

            w.dedent()

        # done state
        w.writeln(f"when {max_t+1} =>")
        w.indent()
        w.writeln("done <= '1';")
        w.writeln("if start = '0' then")
        w.indent()
        w.writeln("state <= 0;")
        w.dedent()
        w.writeln("end if;")
        w.dedent()

        w.writeln("when others => state <= 0;")
        w.dedent()
        w.writeln("end case;")
        w.dedent()
        w.writeln("end if;")
        w.dedent()
        w.writeln("end if;")
        w.dedent()
        w.writeln("end process;")

        # -------------------------
        # end architecture
        # -------------------------
        w.dedent()
        w.writeln("end architecture;")

        return w.text()

    # -------------------------
    # internal helpers
    # -------------------------
    def _find_single_pred_signal(self, dp, edge_sig, dst_id, needed_label):
        preds = []
        for (src, lab) in dp.pred(dst_id):
            if lab == needed_label:
                # find the exact edge key for signal lookup: (src,dst,label)
                # dp.pred stores (src,label) but we need dst too:
                preds.append((src, dst_id, lab))
        if len(preds) != 1:
            raise RuntimeError(f"Expected exactly 1 pred with label={needed_label} into node {dst_id}, got {preds}")
        return edge_sig[preds[0]]

    def _find_single_succ_signal(self, dp, edge_sig, src_id, needed_label):
        succs = []
        for (dst, lab) in dp.succ(src_id):
            if lab == needed_label:
                succs.append((src_id, dst, lab))
        if len(succs) != 1:
            raise RuntimeError(f"Expected exactly 1 succ with label={needed_label} out of node {src_id}, got {succs}")
        return edge_sig[succs[0]]





if __name__ == "__main__":
    # Requires: AST + ASTToCDFG + DotPrinter + Scheduler + ResourceBinder
    #          + RegisterAllocator + DatapathBuilder + DatapathDotPrinter
    #          + VHDLGenerator
    ram = Mem(1024, init=[7, 5, 11])

    # Program: RAM[3] = RAM[0] * RAM[1] + RAM[2]
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

    # 1) Lower AST -> CDFG
    cfg = ASTToCDFG().lower_program(prog)
    bb = next(cfg.nodes())  # single block

    # 2) DOT output for DFG / CFG (same as before)
    printer = DotPrinter()

    dfg_dot = printer.to_dot_dfg(bb.dfg, name="example_dfg")
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
    sched = Scheduler()
    schedule = sched.schedule_cfg(cfg)

    print("\n=== Schedule ===")
    print_schedule(bb.dfg, schedule)

    # 4) Resource binding
    binder = ResourceBinder(
        adder_entity="Adder32",       # match the VHDLGenerator component names
        mul_entity="Mul32",
        mem_entity="RamSimple",
        cst_entity="Const"            # (not used in VHDLGenerator yet)
    )
    binding, resources = binder.bind(bb.dfg, schedule)

    print("\n=== Resource Binding ===")
    print_binding(bb.dfg, schedule, binding)

    print("\nResources instantiated in the circuit:")
    adders = [r for r in resources if r.kind == "add"]
    muls = [r for r in resources if r.kind == "mul"]
    mems = [r for r in resources if r.kind == "mem"]
    csts = [r for r in resources if r.kind == "cst"]
    print(f"  Adders:       {len(adders)}  {[r.instance for r in adders]}")
    print(f"  Multipliers:  {len(muls)}  {[r.instance for r in muls]}")
    print(f"  Memories:     {len(mems)}  {[r.instance for r in mems]}")
    print(f"  Const units:  {len(csts)}  {[r.instance for r in csts]}")

    # 5) Register allocation (edge -> register)
    reg_alloc = RegisterAllocator()
    edge_regs = reg_alloc.allocate(bb.dfg)

    print("\n=== Register Allocation (edge -> register) ===")
    print_edge_registers(bb.dfg, edge_regs)

    # 6) Datapath graph generation
    dp_builder = DatapathBuilder()
    dp, dp_info = dp_builder.build(bb.dfg, schedule, binding, edge_regs)

    print("\n=== Datapath Graph ===")
    print_datapath(dp)

    # 7) DOT output for datapath graph
    dp_printer = DatapathDotPrinter()
    dp_dot = dp_printer.to_dot_datapath(dp, name="example_datapath")
    with open("datapath.dot", "w") as f:
        f.write(dp_dot)

    print("\nWrote: datapath.dot")
    print("Render with:")
    print("  dot -Tpdf datapath.dot -o datapath.pdf")

    # 8) VHDL Generation (NEW)
    vgen = VHDLGenerator(top_name="hls_top")
    vhdl_text = vgen.generate(dp, schedule, binding, edge_regs)

    with open("hls_top.vhd", "w") as f:
        f.write(vhdl_text)

    print("\nWrote: hls_top.vhd")
    print("Next:")
    print("  - Provide/compile component entities: Reg32, Adder32, Mul32, RamSimple")
    print("  - Fill the FSM 'TODO' sections (reg enables, mux sels, RAM controls)")








"""

if __name__ == "__main__":
    # Requires: AST + ASTToCDFG + DotPrinter + Scheduler + ResourceBinder
    #          + RegisterAllocator + DatapathBuilder + DatapathDotPrinter
    ram = Mem(1024, init=[7, 5, 11])

    # Program: RAM[3] = RAM[0] * RAM[1] + RAM[2]
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

    # 1) Lower AST -> CDFG
    cfg = ASTToCDFG().lower_program(prog)
    bb = next(cfg.nodes())  # single block

    # 2) DOT output for DFG / CFG (same as before)
    printer = DotPrinter()

    dfg_dot = printer.to_dot_dfg(bb.dfg, name="example_dfg")
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
    sched = Scheduler()
    schedule = sched.schedule_cfg(cfg)

    print("\n=== Schedule ===")
    print_schedule(bb.dfg, schedule)

    # 4) Resource binding
    binder = ResourceBinder(
        adder_entity="Adder",
        mul_entity="Multiplier",
        mem_entity="RAM",
        cst_entity="Const"
    )
    binding, resources = binder.bind(bb.dfg, schedule)

    print("\n=== Resource Binding ===")
    print_binding(bb.dfg, schedule, binding)

    print("\nResources instantiated in the circuit:")
    adders = [r for r in resources if r.kind == "add"]
    muls = [r for r in resources if r.kind == "mul"]
    mems = [r for r in resources if r.kind == "mem"]
    csts = [r for r in resources if r.kind == "cst"]
    print(f"  Adders:       {len(adders)}  {[r.instance for r in adders]}")
    print(f"  Multipliers:  {len(muls)}  {[r.instance for r in muls]}")
    print(f"  Memories:     {len(mems)}  {[r.instance for r in mems]}")
    print(f"  Const units:  {len(csts)}  {[r.instance for r in csts]}")

    # 5) Register allocation (edge -> register)
    reg_alloc = RegisterAllocator()
    edge_regs = reg_alloc.allocate(bb.dfg)

    print("\n=== Register Allocation (edge -> register) ===")
    print_edge_registers(bb.dfg, edge_regs)

    # 6) Datapath graph generation (NEW)
    dp_builder = DatapathBuilder()
    dp, dp_info = dp_builder.build(bb.dfg, schedule, binding, edge_regs)

    print("\n=== Datapath Graph ===")
    print_datapath(dp)

    # 7) DOT output for datapath graph (NEW)
    dp_printer = DatapathDotPrinter()
    dp_dot = dp_printer.to_dot_datapath(dp, name="example_datapath")
    with open("datapath.dot", "w") as f:
        f.write(dp_dot)

    print("\nWrote: datapath.dot")
    print("Render with:")
    print("  dot -Tpdf datapath.dot -o datapath.pdf")



"""





"""



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

    # 1) Lower AST -> CDFG (CFG with one basic block containing one DFG)
    cfg = ASTToCDFG().lower_program(prog)

    # 2) DOT output (same as before)
    printer = DotPrinter()

    bb = next(cfg.nodes())  # single block
    dfg_dot = printer.to_dot_dfg(bb.dfg, name="example_dfg")
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
    sched = Scheduler()
    schedule = sched.schedule_cfg(cfg)

    print("\nSchedule (node_id -> time):")
    for nid in sorted(schedule.keys()):
        print(f"  {nid} -> {schedule[nid]}")

    print("\nPretty schedule:")
    print_schedule(bb.dfg, schedule)

    # 4) Resource binding (NEW)
    binder = ResourceBinder(
        adder_entity="Adder",
        mul_entity="Multiplier",
        mem_entity="RAM",
        cst_entity="Const"
    )
    binding, resources = binder.bind(bb.dfg, schedule)

    print("\nBinding (node_id -> resource instance):")
    for nid in sorted(binding.keys()):
        r = binding[nid]
        print(f"  {nid} -> {r.instance} ({r.kind})")

    print("\nPretty binding (time-ordered):")
    print_binding(bb.dfg, schedule, binding)

    print("\nResources instantiated in the circuit:")
    # Show counts and list
    adders = [r for r in resources if r.kind == "add"]
    muls = [r for r in resources if r.kind == "mul"]
    mems = [r for r in resources if r.kind == "mem"]
    csts = [r for r in resources if r.kind == "cst"]

    print(f"  Adders:       {len(adders)}  {[r.instance for r in adders]}")
    print(f"  Multipliers:  {len(muls)}  {[r.instance for r in muls]}")
    print(f"  Memories:     {len(mems)}  {[r.instance for r in mems]}")
    print(f"  Const units:  {len(csts)}  {[r.instance for r in csts]}")


"""









"""
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

    # 1) Lower AST -> CDFG (CFG with one basic block containing one DFG)
    cfg = ASTToCDFG().lower_program(prog)

    # 2) DOT output (same as before)
    printer = DotPrinter()

    bb = next(cfg.nodes())  # single block
    dfg_dot = printer.to_dot_dfg(bb.dfg, name="example_dfg")
    with open("dfg.dot", "w") as f:
        f.write(dfg_dot)

    cfg_dot = printer.to_dot_cfg(cfg, name="example_cfg", include_dfg=True)
    with open("cfg_with_dfg.dot", "w") as f:
        f.write(cfg_dot)

    print("Wrote: dfg.dot and cfg_with_dfg.dot")
    print("Render with:")
    print("  dot -Tpdf dfg.dot -o dfg.pdf")
    print("  dot -Tpdf cfg_with_dfg.dot -o cfg_with_dfg.pdf")

    # 3) Scheduling demo (NEW)
    sched = Scheduler()
    schedule = sched.schedule_cfg(cfg)

    print("\nSchedule (node_id -> time):")
    for nid in sorted(schedule.keys()):
        print(f"  {nid} -> {schedule[nid]}")

    print("\nSchedule (grouped by cycle):")
    by_t = {}
    for nid, t in schedule.items():
        by_t.setdefault(t, []).append(nid)

    for t in sorted(by_t.keys()):
        by_t[t].sort()
        labels = [bb.dfg.node(nid).label() for nid in by_t[t]]
        print(f"  t={t}: " + ", ".join(f"{nid}:{lab}" for nid, lab in zip(by_t[t], labels)))

    # Optional: pretty helper
    print("\nPretty schedule:")
    print_schedule(bb.dfg, schedule)


"""






"""
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
"""


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
