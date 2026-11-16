# ARMv8 Assembly & C Hardware Routines (Raspberry Pi)

This repository contains low-level hardware routines written in C and ARMv8 Assembly, developed and tested on a Raspberry Pi 3 Model B as part of the Computer Technology Laboratory at RWU Ravensburg-Weingarten.

---

## 📂 Included Projects

### 1. Memory Addressing: STR & LDR (`strldr_asm.asm`)
* **Description:** Demonstrates ARM Cortex-A53 load-store memory access and addressing modes for 64-bit signed integers, verified step-by-step using GDB.
* **Key Implementation Details:**
  * Implements base register (`STR X6, [X7]`), immediate offset (`ADD X7, X7, #8`), and register offset (`LDR X8, [X1, X9]`) addressing modes.
  * Transfers values cleanly across registers and main memory pointers (`X0 -> X6 -> Memory[X7] -> X8 -> Memory[X1]`).

### 2. Condition Flags & Overflow Detection (`flags.c` & `flags_asm.asm`)
* **Description:** Evaluates 64-bit signed arithmetic states (positive/negative sign and signed integer overflow) directly via the ARM Cortex-A53 `PSTATE` (`NZCV`) register.
* **Key Implementation Details:**
  * Uses `ADDS` to trigger flag updates and `MRS` to snapshot `NZCV` into general-purpose registers (`X14`, `X15`) before subsequent instructions overwrite them.
  * Extracts bit 31 (`N` flag) and bit 28 (`V` flag) using `LSR` and `AND` bitmasking to return distinct status codes (`42`, `43`, `52`, `53`) to the C caller.

### 3. Bit Manipulation: Set & Shift (`sshift.c` & `setshift_asm.asm`)
* **Description:** Implements a runtime single-bit set operation (`*res = a | (1 << mask)`) in ARMv8 assembly and compares 64-bit register behavior against standard 32-bit C integer shifts.
* **Key Implementation Details:**
  * Enforces input bounds checking (`0 <= mask <= 31`) using `CMP` with conditional branches (`BLT`, `BGT`), returning `-1` on out-of-range inputs.
  * Dynamically builds single-bit masks via Logical Shift Left (`LSL`) and applies them non-destructively to registers via `ORR`.

### 4. Matrix Addition (`matrixAdd.c` & `matrixAdd_asm.asm`)
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
