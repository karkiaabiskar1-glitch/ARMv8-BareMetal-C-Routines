#include <stdio.h>
#include <stdlib.h>

struct Matrix {
    int row;
    int maxcolumn;
    int column;
    int mat[10][10];
};

extern int matrixAdd_asm(struct Matrix *A, struct Matrix *B, struct Matrix *Sum);

struct Matrix Matrix_A, Matrix_B, Matrix_Sum;

int main()
{
    int status, i, j, row, column;

    printf("Anzahl von Zeilen? --> ");
    scanf("%d", &row);
    if (row > 10) row = 10;

    printf("Anzahl von Spalten? --> ");
    scanf("%d", &column);
    if (column > 10) column = 10;

    Matrix_A.row = Matrix_B.row = Matrix_Sum.row = row;
    Matrix_A.maxcolumn = Matrix_B.maxcolumn = Matrix_Sum.maxcolumn = 10;
    Matrix_A.column = Matrix_B.column = Matrix_Sum.column = column;

    for (i = 0; i < row; i++)
        for (j = 0; j < column; j++) {
            printf("Matrix_A[%d], [%d] ", i, j);
            scanf("%d", &Matrix_A.mat[i][j]);
        }

    for (i = 0; i < row; i++)
        for (j = 0; j < column; j++) {
            printf("Matrix_B[%d], [%d] ", i, j);
            scanf("%d", &Matrix_B.mat[i][j]);
        }

    status = matrixAdd_asm(&Matrix_A, &Matrix_B, &Matrix_Sum);

    if (status != 0) {
        printf("Assembler routine returned error: %d\n", status);
        return status;
    }

    printf("Die Summe ist:\n");
    for (i = 0; i < row; i++) {
        for (j = 0; j < column; j++) {
            printf("Matrix_Sum [%d], [%d] %d ", i, j, Matrix_Sum.mat[i][j]);
        }
        printf("\n");
    }

    return 0;
}
