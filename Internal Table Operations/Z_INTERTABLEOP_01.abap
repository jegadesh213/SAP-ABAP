*&---------------------------------------------------------------------*
*& Report Z_INTERTABLEOP_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_intertableop_01.

TABLES zzempprac.

PARAMETERS : p_dept TYPE zzempprac-empdept.

TYPES : BEGIN OF ty_employee,
          empsalary TYPE zzempprac-empsalary,
          empdept   TYPE zzempprac-empdept,
        END OF ty_employee.

DATA : it_employee TYPE TABLE OF ty_employee,
       wa_employee TYPE ty_employee.

SELECT empdept empsalary FROM zzempprac INTO TABLE it_employee WHERE empdept = p_dept.

SORT it_employee BY empdept.

LOOP AT it_employee INTO wa_employee.

  AT FIRST.
    WRITE : 'DEPARTMENT:', wa_employee-empdept, 'TOTAL SALARY:'.
  ENDAT.

  AT END OF empdept.
    SUM.
    WRITE : / wa_employee-empdept, 10 wa_employee-empsalary LEFT-JUSTIFIED.
  ENDAT.

ENDLOOP.