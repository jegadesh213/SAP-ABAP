*&---------------------------------------------------------------------*
*& Report Z_INTERFACES_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_interfaces_01.

INTERFACE intf_speed.
  METHODS : writeSpeed.
ENDINTERFACE.

CLASS train DEFINITION.

  PUBLIC SECTION.
    INTERFACES : intf_speed.
    ALIASES writespeed for intf_speed~writeSpeed.
    METHODS : goFast.
  PROTECTED SECTION.
    DATA: speed TYPE i.

ENDCLASS.

CLASS train IMPLEMENTATION.

  METHOD goFast.
    speed = speed + 50.
  ENDMETHOD.

  METHOD intf_speed~writeSpeed.
    WRITE : |The Train speed is { speed } |.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

DATA train_01 TYPE REF TO train.
CREATE OBJECT train_01.

train_01->goFast( ).
train_01->writeSpeed( ).