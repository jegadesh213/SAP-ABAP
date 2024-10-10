*&---------------------------------------------------------------------*
*& Report Z_FM_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_fm_01.

DATA : name(60)   TYPE c,
       c_name(60) TYPE c.

PARAMETERS : p_fname(30) TYPE c,
             p_sname(30) TYPE c.

PERFORM concate_name.

WRITE name.
WRITE / c_name.

FORM concate_name.
  CONCATENATE p_fname p_sname INTO name SEPARATED BY space.

  CALL FUNCTION 'AIPC_CONVERT_TO_UPPERCASE'
    EXPORTING
      i_input  = name
*     I_LANGU  = SY-LANGU
    IMPORTING
      e_output = c_name.

ENDFORM.