*&---------------------------------------------------------------------*
*& Report Z_SELECTIONSCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_selectionscreen_.

TABLES Zemployees.

PARAMETERS emp_id LIKE Zemployees-Employee.

START-OF-SELECTION.

  DATA wa_employee LIKE Zemployees.

  SELECT SINGLE * FROM Zemployees INTO wa_employee WHERE employee = emp_id.

  IF sy-subrc = 0.
    WRITE : / wa_employee-Firstname,
              wa_employee-Surname.
  ELSE.
    WRITE 'No Employee Found'.
  ENDIF.