*&---------------------------------------------------------------------*
*& Report Z_SELECTIONSCREEN_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_selectionscreen_01.

TABLES : zzempprac.

DATA : it_employee TYPE TABLE OF zzempprac,
       wa_employee TYPE zzempprac.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : s_empnum FOR zzempprac-emplnum.

  PARAMETERS : p_empnam TYPE zzempprac-emplname.

  SELECT-OPTIONS : s_dept FOR zzempprac-empdept.
SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN .

  SELECT * FROM zzempprac INTO TABLE it_employee WHERE emplnum IN s_empnum.

START-OF-SELECTION.
  LOOP AT it_employee INTO wa_employee.
    WRITE : / 'NUMBER : ' , wa_employee-emplnum,
            / 'NAME : ' , wa_employee-emplname,
            / 'DEPARTMENT : ',wa_employee-empdept.
  ENDLOOP.