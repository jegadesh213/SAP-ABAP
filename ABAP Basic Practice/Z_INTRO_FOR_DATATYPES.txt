*&---------------------------------------------------------------------*
*& Report Z_INTRO_FOR_DATATYPES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_intro_for_datatypes_.

TABLES Zemployees.

DATA : integer_01 TYPE i VALUE 18,
       char_01    TYPE c LENGTH 10 VALUE 'Jegan',
       dob_01     LIKE Zemployees-dob.

*char_01 = 'Hello'.

dob_01 = '20021208'.

WRITE : /'Name' LEFT-JUSTIFIED,
         10 'Age' LEFT-JUSTIFIED,
         20  'DOB' LEFT-JUSTIFIED.

ULINE.

WRITE : / char_01 LEFT-JUSTIFIED,
         10 integer_01 LEFT-JUSTIFIED,
         20  dob_01 LEFT-JUSTIFIED.

ULINE.

*CONSTANTS

CONSTANTS constInt_01 TYPE i VALUE 22.


WRITE constInt_01.