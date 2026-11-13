/* Return value = 0 -> everything all right */
/* Return value -1 -> fatal error (matrixes do not fit) */

.global matrixAdd_asm
matrixAdd_asm:
/*
/* Load dimensions from A */
/*-------------------------*/
LDR W9, [X0]       /* A->row */
LDR W10, [X0, #8]  /* A->column */
LDR W11, [X0, #4]  /* A->maxcolumn */

/*
/* Check that B has same row/column */
/*----------------------------------*/
LDR W3, [X1]       /* B->row */
CMP W9, W3
BNE Fehler

LDR W3, [X1, #8]   /* B->column */
CMP W10, W3
BNE Fehler

/*
/* Check that Sum has same row/column */
/*------------------------------------*/
LDR W3, [X2]       /* Sum->row */
CMP W9, W3
BNE Fehler

LDR W3, [X2, #8]   /* Sum->column */
CMP W10, W3
BNE Fehler

MOV W12, #0        /* i = 0 */

outer_loop:
CMP W12, W9
BGE done_outer     /* if i >= row -> finished */
MOV W13, #0        /* j = 0 */

inner_loop:
CMP W13, W10
BGE done_inner     /* if j >= column -> next row */

MUL W14, W12, W11  /* index = i * maxcolumn */
ADD W14, W14, W13  /* index = i * maxcolumn + j */
UXTW X15, W14      /* convert index to 64-bit */
LSL X15, X15, #2   /* multiply index by 4 bytes */
ADD X15, X15, #12  /* add offset of mat[0][0] */

ADD X16, X0, X15   /* address of A[i][j] */
ADD X17, X1, X15   /* address of B[i][j] */
ADD X18, X2, X15   /* address of Sum[i][j] */

LDR W19, [X16]     /* load A[i][j] */
LDR W20, [X17]     /* load B[i][j] */
ADD W19, W19, W20  /* add both elements */
STR W19, [X18]     /* store result in Sum[i][j] */

ADD W13, W13, #1   /* j++ */
B inner_loop

done_inner:
ADD W12, W12, #1   /* i++ */
B outer_loop

done_outer:
MOV X0, #0
BR LR

Fehler:
MOV X0, #-1
BR LR
.data
