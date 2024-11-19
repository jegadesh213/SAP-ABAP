*&---------------------------------------------------------------------*
*& Report Z_ABAP_NEWSYNTAX_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_newsyntax_07.

TABLES : zzempprac.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : s_num FOR zzempprac-emplnum.
  PARAMETERS : p_num TYPE zzempprac-emplnum.
SELECTION-SCREEN END OF BLOCK b1.

DATA :it_employee TYPE TABLE OF zzempprac WITH NON-UNIQUE SORTED KEY empdept COMPONENTS empdept,
      it_tab01    TYPE TABLE OF zzempprac,
      it_tab02    TYPE TABLE OF zzempprac.


SELECT * FROM zzempprac INTO TABLE it_employee WHERE emplnum IN s_num.

it_tab01 = FILTER #( it_employee USING KEY empdept WHERE empdept = p_num ).

it_tab02 = FILTER #( it_employee EXCEPT USING KEY empdept WHERE empdept = p_num ).

cl_demo_output=>write( it_employee ).
cl_demo_output=>write( it_tab01 ).
cl_demo_output=>display( it_tab02 ).