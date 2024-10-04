*&---------------------------------------------------------------------*
*& Report Z_EMPLOYEE_LIST_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_employee_list_ LINE-SIZE 132  .

TABLES zemployees.

SELECT * FROM Zemployees.
  WRITE :/ Zemployees-Surname,
           Zemployees-Firstname,
           Zemployees-DOB.
ENDSELECT.