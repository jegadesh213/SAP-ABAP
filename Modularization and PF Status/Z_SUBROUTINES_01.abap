*&---------------------------------------------------------------------*
*& Report Z_SUBROUTINES_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_subroutines_01.

DATA : name(60) TYPE c.

PARAMETERS : p_fname(30) TYPE c,
             p_sname(30) TYPE c.

PERFORM concate_name.

WRITE name.

FORM concate_name.
  CONCATENATE p_fname p_sname INTO name SEPARATED BY space.
ENDFORM.