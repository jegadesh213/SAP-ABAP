FUNCTION z_showtabdetail.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(P_EMPNUM) TYPE  ZZEMPPRAC-EMPLNUM
*"  EXPORTING
*"     REFERENCE(F_NAME) TYPE  ZZEMPPRAC-EMPLNAME
*"     REFERENCE(F_DEPT) TYPE  ZZEMPPRAC-EMPDEPT
*"     REFERENCE(F_SALARY) TYPE  ZZEMPPRAC-EMPSALARY
*"     REFERENCE(F_UNITS) TYPE  ZZEMPPRAC-UNITS
*"----------------------------------------------------------------------

  DATA : gs_employee TYPE zzempprac.  " Declare a work area for the employee record

  " Fetch the employee record from zzempprac table
  SELECT SINGLE * FROM zzempprac INTO gs_employee WHERE emplnum = p_empnum.

  IF sy-subrc = 0.
    " Populate the output parameters from the fetched employee record
    f_name   = gs_employee-emplname.
    f_dept   = gs_employee-empdept.
    f_salary = gs_employee-empsalary.
    f_units  = gs_employee-units.
  ELSE.
    " Handle the case where the employee record is not found
    f_name   = ''.
    f_dept   = ''.
    f_salary = 0.
    f_units  = 0.
  ENDIF.

ENDFUNCTION.