# ARMv8 Assembly & C Hardware Routines (Raspberry Pi)

This repository contains low-level hardware routines written in C and ARMv8 Assembly, developed and tested on a Raspberry Pi 3 Model B as part of the Computer Technology Laboratory at RWU Ravensburg-Weingarten.

---

## 📂 Included Projects

### 1. Matrix Addition (`matrixAdd.c` & `matrixAdd_asm.asm`)
* **Description:** Implements two-dimensional matrix addition at the instruction level in ARMv8 assembly, called from a C host program.
* **Key Implementation Details:**
  * Manually computes flat memory offsets in row-major order using `MUL`, `ADD`, and left-shift (`LSL #2`) instructions.
  * Handles struct header offsets (+12 bytes) to access `mat[0][0]` directly.
  * Implements runtime dimension verification (`row`, `maxcolumn`, `column`) between matrices $A$, $B$, and $Sum$ to prevent memory corruption.

---

## 🛠️ Technical Stack & Tools
* **Languages:** C, ARMv8 Assembly (GNU Assembler - GAS)
* **Hardware:** Raspberry Pi 3 Model B (ARM Cortex-A53)
* **Development Tools:** GCC Compiler, GDB Debugger, Makefiles, Linux Terminal
