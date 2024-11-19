*&---------------------------------------------------------------------*
*& Report Z_ABAP_NEWSYNTAX_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_newsyntax_04.

DATA : amountwords(200).

PARAMETERS : p_amount TYPE i.

START-OF-SELECTION.

  CALL FUNCTION 'HR_IN_CHG_INR_WRDS'
    EXPORTING
      amt_in_num         = CONV maxbt( p_amount )
*     P_FLAG             =
    IMPORTING
      amt_in_words       = amountwords
    EXCEPTIONS
      data_type_mismatch = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  WRITE : amountwords.