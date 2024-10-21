FUNCTION-POOL z_funcgrp.                    "MESSAGE-ID ..

* INCLUDE LZ_FUNCGRPD...                     " Local class definition

DATA : it_employee TYPE
       zzempprac.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS 'PF1'.
  SET TITLEBAR 'T1'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  SET SCREEN 0.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE sy-ucomm.
    WHEN 'EXIT' OR 'BACK' OR 'CANCEL'.
      SET SCREEN 0.
    WHEN 'SAVE'.
      MODIFY zzempprac FROM it_employee.
      SET SCREEN 0.
  ENDCASE.

  CLEAR sy-ucomm.
ENDMODULE.