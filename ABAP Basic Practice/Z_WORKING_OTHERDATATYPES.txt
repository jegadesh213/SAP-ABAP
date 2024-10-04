*&---------------------------------------------------------------------*
*& Report Z_WORKING_OTHERDATATYPES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_working_otherdatatypes_.

*Date Declaration
DATA : Date1 TYPE d VALUE '08122002',
       Date2 LIKE sy-datum.

*Time declaration
DATA : Time1 TYPE t VALUE '152707',
       Time2 LIKE sy-uzeit.

WRITE: / Date1,
       /  Date2,
       /  Time1,
       /  Time2.

*DATE and TIME Fields in calculations
*LOS Calculator

DATA emplo_date type d VALUE '08122002'.
DATA resDate type d.

resDate = Date2 - emplo_date.

WRITE resDate.