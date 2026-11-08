\# 16-bit Multiplier – Datapath (Verilog)



A 16-bit multiplier based on \*\*repeated addition\*\*, designed in Verilog with a separated datapath and control path structure, implemented in Xilinx Vivado.



\## How it works



The product is computed by adding the multiplicand \*\*A\*\* to the accumulated product \*\*P\*\* repeatedly, while a counter holding the multiplier \*\*B\*\* decrements by one each cycle. When the counter reaches zero, the comparator signals that the multiplication is complete.



\## Datapath modules



| Module | File | Function |

|---|---|---|

| PIPO register A | `pipo\_A.v` | Stores the multiplicand A |

| PIPO register P | `pipo\_P.v` | Stores the running product P |

| Adder | `add.v` | 16-bit adder computing P + A |

| Counter | `cntr.v` | Loads multiplier B and decrements each cycle |

| Zero detector | `eqz\_0.v` | Signals when the counter reaches zero |

| Datapath (top) | `data\_path.v` | Connects all the modules above |



\## Repository structure



\- `multiplier\_control\_data\_path.srcs/sources\_1/new/` → design files

\- `multiplier\_control\_data\_path.xpr` → Vivado project file



\## Tools



\- Verilog HDL

\- Xilinx Vivado

