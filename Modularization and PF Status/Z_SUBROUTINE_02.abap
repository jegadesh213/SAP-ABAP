*&---------------------------------------------------------------------*
*& Report Z_SUBROUTINE_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_subroutine_02_.

PARAMETERS : p_num1 TYPE i,
             p_num2 TYPE i,
             p_add  AS CHECKBOX,
             p_sub  AS CHECKBOX,
             p_mul  AS CHECKBOX,
             p_div  AS CHECKBOX.

DATA : result TYPE i.

IF p_add = 'X'.
  PERFORM addition USING p_num1
                         p_num2
                   CHANGING result.
ELSEIF p_sub = 'X'.
  PERFORM sub USING      p_num1
                         p_num2
                   CHANGING result.
ELSEIF p_mul = 'X'.
  PERFORM product USING p_num1
                         p_num2
                   CHANGING result.
ELSEIF p_div = 'X'.
  PERFORM division USING p_num1
                         p_num2
                   CHANGING result.
ENDIF.

WRITE result.

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