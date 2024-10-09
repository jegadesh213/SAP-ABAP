*&---------------------------------------------------------------------*
*& Include          Z_PERFORMDECL
*&---------------------------------------------------------------------*
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