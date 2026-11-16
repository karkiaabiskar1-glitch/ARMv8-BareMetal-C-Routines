/* smask.c 14.2.2024 */
/* Program to demonstrate mask operations */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int setshift_asm(int xa, int xmask, int *xresult);

int a, mask;

int main()
{
    int aa, b, status;
    int result;

    printf("Value (in hex; 0x42) = ");
    scanf("%x", &a);
    printf("Shift-Mask (in dec; 42) = ");
    scanf("%d", &mask);

    b = a | (1 << mask);
    status = setshift_asm(a, mask, &result);

    if (status == 0)
    {
        printf("Set mask operation in C: variable = 0x%08x, "
               "mask = 0x%08x, result = 0x%08x\n", a, mask, b);
        printf("Set mask operation in ASM: variable = 0x%08x, "
               "mask = 0x%08x, result = 0x%08x\n", a, mask, result);
    }
    else
    {
        printf("Some error!\n");
    }

    return status;
}
