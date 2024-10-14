*&---------------------------------------------------------------------*
*& Report Z_CLASS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_class_01.

CLASS car DEFINITION.
  PUBLIC SECTION.

    CLASS-DATA : numberofcars TYPE i.

    DATA: make     TYPE c LENGTH 20,
          model    TYPE c LENGTH 20,
          noofseat TYPE i,
          maxSpeed TYPE i,
          speed    TYPE i.

    METHODS constructor
      IMPORTING
        make     TYPE c
        model    TYPE c
        noofseat TYPE i
        maxSpeed TYPE i.

    METHODS viewCar.

    METHODS setNumSeats
      IMPORTING numseat TYPE i.

    METHODS: goFaster
      IMPORTING increment TYPE i
      EXPORTING result    TYPE i.

    METHODS: goSlower
      IMPORTING decrement     TYPE i
      RETURNING VALUE(result) TYPE i.

ENDCLASS.

CLASS car IMPLEMENTATION.

  METHOD setNumSeats.
    noofseat = numseat.
  ENDMETHOD.

  METHOD goFaster.
    DATA tempSpeed TYPE i.
    tempSpeed = speed + increment.
    IF tempSpeed <= maxSpeed.
      speed = speed + increment.
    ELSE.
      speed = maxspeed.
    ENDIF.
    result = speed.
  ENDMETHOD.

  METHOD goSlower.
    DATA tempSpeed TYPE i.
    tempSpeed = speed - decrement.
    IF tempSpeed <= maxSpeed.
      speed = speed - decrement.
    ENDIF.
    result = speed.
  ENDMETHOD.

  METHOD constructor.
    me->make = make.
    me->model = model.
    me->noofseat = noofseat.
    me->maxSpeed = maxSpeed.
  ENDMETHOD.

  METHOD viewcar.
    WRITE : / 'MAKE :',20 make LEFT-JUSTIFIED,
            / 'MODEL :',20 model LEFT-JUSTIFIED,
            / 'NO OF SEATS:',20 noofseat LEFT-JUSTIFIED,
            / 'MAX SPEED:',20 maxSpeed LEFT-JUSTIFIED,
            / 'SPEED:',20 speed LEFT-JUSTIFIED.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA car1 TYPE REF TO car.
  CREATE OBJECT car1
    EXPORTING
      make     = 'AUDI'
      model    = 'A4'
      noofseat = 5
      maxSpeed = 120.

  car1->viewcar( ).

  ULINE.

  car1->goFaster( 15 ).

  car1->viewcar( ).

  ULINE.

  car1->goFaster( 125 ).

  car1->viewcar( ).