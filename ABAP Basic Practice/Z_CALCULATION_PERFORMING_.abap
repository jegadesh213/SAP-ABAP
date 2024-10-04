*&---------------------------------------------------------------------*
*& Report Z_CALCULATION_PERFORMING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_CALCULATION_PERFORMING_.

DATA : int_01 TYPE i,
       int_02 Type i,
       res_int Type i.


int_01 = 10.
int_02 = 20.

*Addition
res_int = int_01 + int_02.
write : res_int.
ULINE.

*Subraction
res_int = int_02 - int_01.
write : res_int.
ULINE.

*Multiplication
res_int = int_01 * int_02.
write : res_int.
Uline.

*Division
res_int = int_01 / int_02.
write : res_int.
Uline.