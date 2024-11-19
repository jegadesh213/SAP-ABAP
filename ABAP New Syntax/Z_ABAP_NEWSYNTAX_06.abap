*&---------------------------------------------------------------------*
*& Report Z_ABAP_NEWSYNTAX_06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_newsyntax_06.

TABLES : zzempprac , zzempracdep.

TYPES : BEGIN OF ty_employee,
          number TYPE zzempprac-emplnum,
          name   TYPE zzempprac-emplname,
          role   TYPE zzempracdep-role,
        END OF ty_employee.

DATA : it_tab1 TYPE TABLE OF zzempprac,
       it_tab2 TYPE TABLE OF zzempracdep,
       it_tab3 TYPE TABLE OF ty_employee.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : s_num FOR zzempprac-emplnum.
SELECTION-SCREEN END OF BLOCK b1.

SELECT * FROM zzempprac INTO TABLE it_tab1 WHERE emplnum IN s_num.

it_tab2 = CORRESPONDING #( it_tab1 ).

SELECT * FROM zzempracdep INTO TABLE it_tab2 WHERE emplnum IN s_num.

it_tab3 = CORRESPONDING #( it_tab1 MAPPING number = emplnum
                                           name = emplname ).
it_tab3 = CORRESPONDING #( it_tab2 MAPPING role = role ).

cl_demo_output=>write( it_tab1 ).
cl_demo_output=>write( it_tab2 ).
cl_demo_output=>display( it_tab3 ).