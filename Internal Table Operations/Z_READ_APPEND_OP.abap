*&---------------------------------------------------------------------*
*& Report Z_READ_APPEND_OP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_read_append_op.

TABLES zzempprac.

TYPES: BEGIN OF ty_employee,
         emplnum   TYPE zzempprac-emplnum,
         emplname  TYPE zzempprac-emplname,
         empdept   TYPE zzempprac-empdept,
         empsalary TYPE zzempprac-empsalary,
         empunit   TYPE zzempprac-units,
       END OF ty_employee.

DATA: it_employee TYPE TABLE OF ty_employee,
      it_employee1 TYPE TABLE OF ty_employee,
      wa_employee TYPE ty_employee.

SELECT * FROM zzempprac INTO TABLE it_employee.
SELECT * FROM zzempprac INTO TABLE it_employee1.

wa_employee-emplnum = 8.
wa_employee-emplname = 'skyler'.
wa_employee-empdept = 4.
wa_employee-empsalary = 30.
wa_employee-empunit = 'USD'.
APPEND wa_employee TO it_employee1.

wa_employee-emplnum = 9.
wa_employee-emplname = 'Saul'.
wa_employee-empdept = 4.
wa_employee-empsalary = 3000.
wa_employee-empunit = 'USD'.
APPEND wa_employee TO it_employee1.

wa_employee-emplnum = 10.
wa_employee-emplname = 'Fring'.
wa_employee-empdept = 4.
wa_employee-empsalary = 1000.
wa_employee-empunit = 'USD'.
APPEND wa_employee TO it_employee1.

APPEND LINES OF it_employee1 TO it_employee.

LOOP AT it_employee INTO wa_employee.
  WRITE: / 'Employee Number: ',20 wa_employee-emplnum,
         / 'Employee Name: ',20 wa_employee-emplname,
         / 'Employee Department: ',20 wa_employee-empdept,
         / 'Employee Salary: ',20 wa_employee-empsalary.
ENDLOOP.

READ TABLE it_employee INTO wa_employee WITH KEY emplnum = '4'.

IF sy-subrc = 0.
  WRITE: / 'Employee Number:', wa_employee-emplnum,
         / 'Employee Name:', wa_employee-emplname,
         / 'Employee Department:', wa_employee-empdept,
         / 'Employee Salary:', wa_employee-empsalary.
ELSE.
  WRITE: / 'No employee found with the specified employee number.'.
ENDIF.