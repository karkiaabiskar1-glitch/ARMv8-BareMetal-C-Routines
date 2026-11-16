/* smask_asm.c 14.2.2024 */
/* Set a single bit by means of a bit-mask. */
/* The prototype of the function looks like: */
/* extern int setshift_asm(int a, int mask, int *res) */

.global setshift_asm
setshift_asm:
    MOV X8, X0          /* take the argument */
    MOV X9, X1          /* get the shift amount mask */

    /* Do the work here */
    CMP W9, #0          /* check lower valid bit position */
    BLT error           /* jump if bit position is negative */
    CMP W9, #31         /* check upper valid bit position */
    BGT error           /* jump if bit position is greater than 31 */

    MOV X10, #1         /* start with binary 1 */
    LSL X10, X10, X9    /* shift left: 1 << mask */
    ORR X10, X8, X10    /* result = a | (1 << mask) */

    STR X10, [X2]       /* return the result to the argument pointer */
    MOV X0, #0          /* status return */
    BR LR

error:
    MOV X0, #-1         /* error exception */
    BR LR
