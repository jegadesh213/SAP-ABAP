*&---------------------------------------------------------------------*
*& Report Z_SELECTION_SCREEN_NAV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_selection_screen_nav.

TABLES : zzempprac.

DATA : it_employee TYPE TABLE OF zzempprac,
       wa_employee TYPE zzempprac.

DATA :  f1 TYPE char29.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS : p_1 RADIOBUTTON GROUP grp1,
               p_2 RADIOBUTTON GROUP grp1.

SELECTION-SCREEN END OF BLOCK b1.


START-OF-SELECTION.

  IF p_1 = 'X'.
    PERFORM display_data1.
  ELSE.
    CALL SCREEN 0100.
  ENDIF.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF-01'.
  SET TITLEBAR 'T01'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.

    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      SET SCREEN 0.
    WHEN 'SUBMIT'.
      PERFORM display_data2.

  ENDCASE.

ENDMODULE.

*  &---------------------------------------------------------------------*
*  & Form display_data1
*  &---------------------------------------------------------------------*
*  & text
*  &---------------------------------------------------------------------*
*  & -->  p1        text
*  & <--  p2        text
*  &---------------------------------------------------------------------*
FORM display_data1 .
  SELECT * FROM zzempprac INTO CORRESPONDING FIELDS OF TABLE it_employee.

  SORT it_employee BY emplnum.

  WRITE : 'Employee Number' ,20 'Employee Name',40 'Department',65 'Salary',90 'Units'.
  ULINE.

  LOOP AT it_employee INTO wa_employee.
    WRITE : / wa_employee-emplnum ,20 wa_employee-emplname ,40 wa_employee-empdept ,65 wa_employee-empsalary LEFT-JUSTIFIED ,90 wa_employee-units.
  ENDLOOP.
  ULINE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form display_data2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_data2 .

  SELECT * FROM zzempprac INTO CORRESPONDING FIELDS OF TABLE it_employee WHERE emplnum = f1.
  SORT it_employee BY emplnum.

  " Check if data is available
  IF it_employee IS INITIAL.
    WRITE: / 'No data found for Employee Number:', f1.
    RETURN.
  ENDIF.

  LEAVE TO LIST-PROCESSING AND RETURN TO SCREEN 0100.

  " Display output directly using list processing
  WRITE : 'Employee Number', 20 'Employee Name', 40 'Department', 65 'Salary', 90 'Units'.
  ULINE.

  LOOP AT it_employee INTO wa_employee.
    WRITE : / wa_employee-emplnum, 20 wa_employee-emplname, 40 wa_employee-empdept,
              65 wa_employee-empsalary LEFT-JUSTIFIED, 90 wa_employee-units.
  ENDLOOP.
  ULINE.

ENDFORM.
