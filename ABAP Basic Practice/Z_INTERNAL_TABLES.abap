*&---------------------------------------------------------------------*
*& Report Z_INTERNAL_TABLES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_internal_tables_.

TABLES Zemployees.

*Declaring internal table
DATA it_employee TYPE TABLE OF Zemployees.

*Declaring the work area to access
DATA wa_employee TYPE Zemployees.

*Entering all the datas available at Zemployee Table to Internal Table we Created.
SELECT * FROM Zemployees INTO TABLE it_employee.

*Now loop and display the entries we shifted into the internal table using the WA we declare here.
  LOOP AT it_employee INTO wa_employee.
    WRITE wa_employee.
  ENDLOOP.