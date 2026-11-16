/* flags_asm.asm 23.8.2023 */
/* 0x7fffffffffffffff = 9223372036854775807 */
/* 0xffffffffffffffff = -1 */
/* 0x8000000000000000 = -9223372036854775808 */

.global flags_asm
flags_asm:
    MOV X6, X0          /* first argument */
    MOV X7, X1          /* second argument */

    /* Check sign of first argument */
    ADDS X6, X6, #0     /* set N flag based on first argument */
    MRS X14, NZCV       /* save flags to X14 */

    /* Check overflow in addition */
    ADDS X8, X6, X7     /* X6 + X7, sets V flag on overflow */
    MRS X15, NZCV       /* save flags after addition */

    /* Extract N flag from first check (bit 31) */
    LSR X16, X14, #31   /* X16 = N flag (1 = negative) */
    AND X16, X16, #1

    /* Extract V flag from addition (bit 28) */
    LSR X17, X15, #28   /* X17 = V flag (1 = overflow) */
    AND X17, X17, #1

    /* Determine status code */
    /* Base code: positive + no overflow = 42 */
    MOV X8, #42

    /* If negative (N=1): add 1 -> 43 */
    ADD X8, X8, X16     /* 42 + N */

    /* If overflow (V=1): add 10 -> 52 or 53 */
    MOV X9, #10
    MUL X9, X9, X17     /* 10 * V */
    ADD X8, X8, X9      /* final: 42, 43, 52, or 53 */

    /* Store result and return */
    STR X8, [X2]        /* write status to result pointer */
    MOV X0, #0          /* return 0 = success */
    BR LR
