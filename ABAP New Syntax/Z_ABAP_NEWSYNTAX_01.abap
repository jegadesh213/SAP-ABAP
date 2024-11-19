*&---------------------------------------------------------------------*
*& Report Z_ABAP_NEWSYNTAX_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_newsyntax_01.

TABLES : zzempprac.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : s_num FOR zzempprac-emplnum.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  PERFORM fetch-data.

*&---------------------------------------------------------------------*
*& Form fetch-data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM fetch-data .
  SELECT * FROM zzempprac INTO  TABLE @DATA(it_employee) WHERE emplnum IN @s_num.

  SORT it_employee BY emplnum.

  LOOP AT it_employee INTO DATA(wa_employee).
    WRITE : wa_employee-emplnum.
  ENDLOOP.
ENDFORM.