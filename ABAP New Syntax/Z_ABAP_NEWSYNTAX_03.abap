*&---------------------------------------------------------------------*
*& Report Z_ABAP_NEWSYNTAX_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_newsyntax_03.

TABLES : zzempprac.

TYPES : BEGIN OF ty_employee,
          emplnum  TYPE zzempprac-emplnum,
          emplname TYPE zzempprac-emplname,
          empdept  TYPE zzempprac-empdept,
        END OF ty_employee.

DATA : it_employee TYPE TABLE OF ty_employee.

DATA(wa_employee) = VALUE ty_employee( emplnum = 1 emplname = 'MIKE' empdept = 1 ).

cl_demo_output=>write( wa_employee ).

it_employee = VALUE #(
                       ( emplnum = 2 emplname = 'Jane' empdept = 1 )
                       ( emplnum = 3 emplname = 'Xavier' empdept = 2 )
                       ( emplnum = 4 emplname = 'Jack' empdept = 3 )
                       ).

cl_demo_output=>display( it_employee ).