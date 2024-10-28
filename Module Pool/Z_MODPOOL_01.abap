*&---------------------------------------------------------------------*
*& Report Z_MODPOOL_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_modpool_01.

TABLES : zzempprac , zzempracdep.

DATA : it_employee TYPE TABLE OF zzempprac,
       wa_employee TYPE zzempprac.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS : p_id TYPE zzempprac-emplnum.

  PARAMETERS : p_ent  RADIOBUTTON GROUP grp1,
               p_dis  RADIOBUTTON GROUP grp1,
               p_dis2 RADIOBUTTON GROUP grp1.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  SELECT SINGLE * FROM zzempprac INTO CORRESPONDING FIELDS OF wa_employee WHERE emplnum = p_id.

  wa_employee-emplnum = p_id.

  IF p_ent IS NOT INITIAL.
    CALL SCREEN 0100.
  ELSEIF p_dis IS NOT INITIAL.
    PERFORM display.
  ELSEIF p_dis2 IS NOT INITIAL.
    PERFORM display_02.
  ENDIF.



END-OF-SELECTION.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF-01'.
  SET TITLEBAR 'T-01'.
ENDMODULE.

INCLUDE z_modpool_01_exiti01.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.

    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      SET SCREEN 0.
    WHEN 'SAVE'.
      PERFORM save.
  ENDCASE.

  CLEAR sy-ucomm.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form save
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save.

  LOOP AT SCREEN.
    IF screen-name = 'ZZEMPPRAC-EMPLNUM' OR
       screen-name = 'ZZEMPPRAC-EMPLNAME' OR
       screen-name = 'ZZEMPPRAC-EMPDEPT' OR
       screen-name = 'ZZEMPPRAC-EMPSALARY' OR
       screen-name = 'ZZEMPPRAC-UNITS'.
      screen-input = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

  MODIFY zzempprac FROM wa_employee.

  IF sy-subrc = 0.
    MESSAGE 'DATA SAVED SUCCESSFULLY' TYPE 'S'.
  ELSE.
    MESSAGE 'DATA SAVED FAILED' TYPE 'E'.
  ENDIF.


ENDFORM.

*&---------------------------------------------------------------------*
*& Form display
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display .

  SELECT * FROM zzempprac INTO CORRESPONDING FIELDS OF TABLE it_employee WHERE emplnum = p_id.
  SORT it_employee BY emplnum ASCENDING.
  cl_demo_output=>display( it_employee ) .

ENDFORM.

*&---------------------------------------------------------------------*
*& Form display_02
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_02 .
  SELECT * FROM zzempprac INTO CORRESPONDING FIELDS OF TABLE it_employee.
  SORT it_employee BY emplnum ASCENDING.
  cl_demo_output=>display( it_employee ) .
ENDFORM.