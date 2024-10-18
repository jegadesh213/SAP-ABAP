*&---------------------------------------------------------------------*
*& Report Z_FUNCMOD_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_funcmod_01.

DATA : gs_word TYPE spell.

PARAMETERS : p_amount TYPE dmbtr.

START-OF-SELECTION.

  CALL FUNCTION 'SPELL_AMOUNT'
    EXPORTING
      amount    = p_amount
*     currency  = ' '
*     filler    = ' '
      language  = sy-langu
    IMPORTING
      in_words  = gs_word
    EXCEPTIONS
      not_found = 1
      too_large = 2
      OTHERS    = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  WRITE : gs_word-word.