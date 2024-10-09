*&---------------------------------------------------------------------*
*& Include          Z_FORMDECLARATION
*&---------------------------------------------------------------------*

FORM addition
  USING p_num1
        p_num2
  CHANGING result.

  result = p_num1 + p_num2.
ENDFORM.

FORM sub
  USING p_num1
        p_num2
  CHANGING result.

  result = p_num1 - p_num2.
ENDFORM.

FORM product
  USING p_num1
        p_num2
  CHANGING result.

  result = p_num1 * p_num2.
ENDFORM.

FORM division
  USING p_num1
        p_num2
  CHANGING result.

  result = p_num1 / p_num2.
ENDFORM.