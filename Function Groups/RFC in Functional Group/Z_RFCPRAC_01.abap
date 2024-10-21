*&---------------------------------------------------------------------*
*& Report Z_RFCPRAC_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_rfcprac_01.

TABLES : zzempprac.

DATA : it_employee01 TYPE TABLE OF zzempprac,
       msg           TYPE char100.

SELECT-OPTIONS : s_id FOR zzempprac-emplnum.

START-OF-SELECTION.
  PERFORM get_and_post_data.
  WRITE : / msg.


FORM get_and_post_data.

  SELECT * FROM zzempprac INTO CORRESPONDING FIELDS OF TABLE it_employee01 WHERE emplnum IN s_id.


  CALL FUNCTION 'Z_RFCPRAC'
    IMPORTING
      ep_item_msg  = msg
    TABLES
      it_employee  = it_employee01
    EXCEPTIONS
      insert_error = 1
      OTHERS       = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.