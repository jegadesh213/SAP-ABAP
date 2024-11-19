*&---------------------------------------------------------------------*
*& Report Z_ABAP_NEWSYNTAX_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_newsyntax_05.

TABLES : zzempprac.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : s_num FOR zzempprac-emplnum.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  SELECT emplnum, emplname, empdept, empsalary, units, CASE empdept WHEN 1 THEN ( empsalary * -1 ) ELSE empsalary END AS amount FROM zzempprac INTO
  TABLE @DATA(it_employee) WHERE emplnum IN @s_num.

  cl_demo_output=>display( it_employee ).