*&---------------------------------------------------------------------*
*& Report Z_FUNCSCREENPRO_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_funcscreenpro_01.

DATA : ty_employee01 TYPE zzempprac,
       msg(40).

PARAMETERS : ip_enum  TYPE zzempprac-emplnum,
             ip_ename TYPE zzempprac-emplname,
             ip_edept TYPE zzempprac-empdept.

START-OF-SELECTION.

  CALL FUNCTION 'Z_FUNCSCREEN_01'
    EXPORTING
      ip_empnum   = ip_enum
      ip_empname  = ip_ename
      ip_empdept  = ip_edept
    IMPORTING
      ty_employee = ty_employee01.

  IF ty_employee01-emplname IS NOT INITIAL.
    msg = 'VIEW DETAILS'.
  ELSEIF ty_employee01-empsalary IS NOT INITIAL.
    msg = 'GET SALARY'.
  ELSEIF ty_employee01-empdept IS NOT INITIAL.
    msg = 'DATE OF JOINING'.
  ENDIF.

  WRITE : / msg.