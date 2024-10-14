*&---------------------------------------------------------------------*
*& Report Z_INHERIT_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_inherit_01.

CLASS vehicle DEFINITION.
  PUBLIC SECTION.
    METHODS : goFaster,
      writeSpeed.

  PROTECTED SECTION.
    DATA : speed TYPE i.
ENDCLASS.

CLASS car DEFINITION INHERITING FROM vehicle.
  PUBLIC SECTION.
    METHODS : refuel,
      writeSpeed REDEFINITION.

  PROTECTED SECTION.
    DATA : fuelLevel TYPE i.
ENDCLASS.

CLASS boat DEFINITION INHERITING FROM vehicle.
  PUBLIC SECTION.
    METHODS : writeSpeed REDEFINITION.
ENDCLASS.

CLASS car IMPLEMENTATION.

  METHOD refuel.
    WRITE : / 'Refeuling after the fuel level' ,fuelLevel.
  ENDMETHOD.

  METHOD writeSpeed.
    WRITE : / 'The Car Speed is ', speed.
  ENDMETHOD.

ENDCLASS.

CLASS boat IMPLEMENTATION.

  METHOD writeSpeed.
    WRITE : / 'The Boat Speed is ', speed.
    call method super->writeSpeed.
  ENDMETHOD.

ENDCLASS.

CLASS vehicle IMPLEMENTATION.

  METHOD goFaster.
    speed = speed + 1.
  ENDMETHOD.

  METHOD writeSpeed.
    WRITE : / 'The Vehicle Speed is ', speed.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA : car01  TYPE REF TO car,
         boat01 TYPE REF TO boat.

  CREATE OBJECT : car01, boat01.

  car01->goFaster( ).
  car01->writeSpeed( ).
  car01->refuel( ).

  boat01->goFaster( ).
  boat01->writeSpeed( ).