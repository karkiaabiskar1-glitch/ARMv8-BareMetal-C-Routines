/* strldr_asm.asm */
/* X1 = address / pointer (e.g., 0x7fffffee28) */

.global strldr_asm
strldr_asm:
    MOV X6, X0          /* X6 = input value (-500 = 0xFFFFFFFFFFFFFE0C) */
    MOV X7, X1          /* Address for storing the value; take address from X1 */
    ADD X7, X7, #8      /* and add 8. (X7 = 0x7fffffee30) */
    MOV X9, #0x8        /* Could act as an address offset */

    /* Store value at address X1+8 */
    STR X6, [X7]        /* Store value at address X1+8 */

    /* Load value again using offset addressing */
    LDR X8, [X1, X9]    /* Load value using register offset (X1 + X9) */

    /* Write the stored/read value to the variable pointer */
    STR X8, [X1]        /* Write result to output pointer (val2ldr) */

    MOV X0, #0          /* Return 0 = success */
    BR LR               /* Return to C caller */
