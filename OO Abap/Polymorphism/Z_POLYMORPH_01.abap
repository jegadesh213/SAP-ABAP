*&---------------------------------------------------------------------*
*& Report Z_POLYMORPH_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_polymorph_01.

CLASS vehicle DEFINITION.
  PUBLIC SECTION.
    METHODS move.

ENDCLASS.

CLASS car DEFINITION INHERITING FROM vehicle.
  PUBLIC SECTION.
    METHODS move REDEFINITION.

ENDCLASS.

CLASS boat DEFINITION INHERITING FROM vehicle.
  PUBLIC SECTION.
    METHODS move REDEFINITION.

ENDCLASS.

CLASS vehicle IMPLEMENTATION.
  METHOD move.
    WRITE : / 'THE VEHICLE IS MOVING'.
  ENDMETHOD.
ENDCLASS.

CLASS car IMPLEMENTATION.
  METHOD move.
    WRITE : / 'THE CAR IS MOVING'.
  ENDMETHOD.
ENDCLASS.

CLASS boat IMPLEMENTATION.
  METHOD move.
    WRITE : / 'THE BOAT IS MOVING'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA : bmw  TYPE REF TO vehicle,
         pg11 TYPE REF TO vehicle,
         ford TYPE REF TO vehicle.

*Normal Declaration
  CREATE OBJECT ford.
  ford->move( ).

*Polymorphism Declaration
  bmw = NEW car( ).
  pg11 = NEW boat( ).

  bmw->move( ).
  pg11->move( ).