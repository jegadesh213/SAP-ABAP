*&---------------------------------------------------------------------*
*& Report Z_EMPPRAC_
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_empprac_.

TABLES zzempprac.

TYPES : BEGIN OF ty_employee,
          emplnum   TYPE zzempprac-emplnum,
          emplname  TYPE zzempprac-emplname,
          empsalary TYPE zzempprac-empsalary,
          units     TYPE zzempprac-units,
        END OF ty_employee.

DATA : it_employee TYPE TABLE OF ty_employee,
       wa_employee TYPE ty_employee.

*SELECT emplnum emplname empsalary units FROM zzempprac INTO TABLE it_employee.

wa_employee-emplnum     = 1.
wa_employee-emplname    = 'MIKE'.
wa_employee-empsalary   = 500.
wa_employee-units       = 'USD'.
APPEND wa_employee TO it_employee.

wa_employee-emplnum     = 2.
wa_employee-emplname    = 'JANE'.
wa_employee-empsalary   = 100.
wa_employee-units       = 'USD'.
APPEND wa_employee TO it_employee.

wa_employee-emplnum     = 3.
wa_employee-emplname    = 'WALTER'.
wa_employee-empsalary   = 750.
wa_employee-units       = 'USD'.
APPEND wa_employee TO it_employee.

LOOP AT it_employee INTO wa_employee.
  INSERT INTO zzempprac VALUES wa_employee.
ENDLOOP.

FORMAT COLOR 2.
WRITE : 'EMPLOYEE NUMBER ' , 20 'EMPLOYEE NAME ', 40 'EMPLOYEE SALARY ', 60 'SALARY UNITS '.
FORMAT COLOR OFF.

Uline.

SELECT * FROM zzempprac.
  WRITE :/ zzempprac-emplnum,20 zzempprac-emplname ,40 zzempprac-empsalary LEFT-JUSTIFIED,60 zzempprac-units.
ENDSELECT.