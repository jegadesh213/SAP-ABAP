*&---------------------------------------------------------------------*
*& Report Z_FUNCMOD_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT : z_funcmod_02.

DATA : lv_emplnum   TYPE zzempprac-emplnum,
       wa_emplname  TYPE zzempprac-emplname,
       wa_empdept   TYPE zzempprac-empdept,
       wa_empsalary TYPE zzempprac-empsalary,
       wa_units     TYPE zzempprac-units.

" Assuming employee number is passed
PARAMETERS : p_empnum TYPE zzempprac-emplnum.

START-OF-SELECTION.

  " Call the function module to retrieve employee data
  CALL FUNCTION 'Z_SHOWTABDETAIL'
    EXPORTING
      p_empnum = p_empnum
    IMPORTING
      f_name   = wa_emplname
      f_dept   = wa_empdept
      f_salary = wa_empsalary
      f_units  = wa_units.


  WRITE : / 'Name : ',10 wa_emplname ,
          / 'Department : ',10 wa_empdept ,
          / 'Salary : ',10 wa_empsalary ,
          / 'Units : ',10 wa_units .