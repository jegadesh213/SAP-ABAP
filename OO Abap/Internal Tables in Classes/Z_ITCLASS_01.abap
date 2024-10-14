*&---------------------------------------------------------------------*
*& Report Z_ITCLASS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_itclass_01.

CLASS flights DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.

    METHODS showAllData.

    METHODS showConnidData
      IMPORTING cid TYPE s_conn_id.

    METHODS numFlightsTo
      IMPORTING city             TYPE s_to_city
      RETURNING VALUE(numflight) TYPE i.

    METHODS getConnid
      IMPORTING cityfrom      TYPE s_from_cit
                cityto        TYPE s_to_city
      RETURNING VALUE(connid) TYPE s_conn_id..

    METHODS: getFlightTime
      IMPORTING cid            TYPE s_conn_id
      RETURNING VALUE(minutes) TYPE i.

    METHODS: getAllConnectionFacts
      IMPORTING cid         TYPE s_conn_id
      RETURNING VALUE(conn) TYPE spfli.

  PRIVATE SECTION.
    TYPES : ty_flight TYPE TABLE OF spfli.
    DATA : flight_table TYPE ty_flight.

ENDCLASS.

CLASS flights IMPLEMENTATION.
  METHOD constructor.
    SELECT * FROM spfli INTO TABLE flight_table.
    IF sy-subrc <> 0.
      WRITE 'Data Transfered Successfully'.
    ENDIF.
  ENDMETHOD.

  METHOD showAllData.
    DATA : wa TYPE spfli.

    LOOP AT flight_table INTO wa.
      WRITE: / wa-carrid, 5 wa-connid, 10 wa-countryfr, 14 wa-cityfrom, 36 wa-airpfrom, 40 wa-countryto,
      44 wa-cityto, 66 wa-airpto, 69 wa-fltime, 77 wa-deptime, 87 wa-arrtime, 97 wa-distance, 107 wa-distid,
      110 wa-fltype, 115 wa-period.
    ENDLOOP.

  ENDMETHOD.

  METHOD showConnidData.
    DATA : wa TYPE spfli.

    READ TABLE flight_table INTO wa WITH KEY connid = cid.
    IF sy-subrc = 0.
      WRITE: / wa-cityfrom, 22 wa-airpfrom, 27 wa-countryto, 49 wa-fltime, 54 wa-distance.
    ELSE.
      WRITE: 'No record found matching connid: ', cid.
    ENDIF.

  ENDMETHOD.

  METHOD numFlightsTo.

    LOOP AT flight_table TRANSPORTING NO FIELDS WHERE airpto = city.
      numflight += 1.
    ENDLOOP.

  ENDMETHOD.


  METHOD getConnid.
    DATA: wa TYPE spfli.

    connid = 0.
    READ TABLE flight_table INTO wa WITH KEY airpfrom = cityfrom
                                             airpto   = cityto.
    connid = wa-connid.

  ENDMETHOD.

  METHOD getFlightTime.
    DATA: wa TYPE spfli.

    minutes = 0.
    READ TABLE flight_table INTO wa WITH KEY connid = cid.
    minutes = wa-fltime.

  ENDMETHOD.

  METHOD getAllConnectionFacts.

    CLEAR conn.
    READ TABLE flight_table INTO conn WITH KEY connid = cid.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.


  DATA flight_01 TYPE REF TO flights.
  CREATE OBJECT flight_01.

  flight_01->showAllData( ).
  ULINE.

  flight_01->showConnidData( 1984 ).
  ULINE.

  WRITE / flight_01->numFlightsTo( 'NRT' ).
  ULINE.

  WRITE : / flight_01->getConnid( cityfrom = 'JFK' cityto = 'FRA').
  ULINE.

  WRITE : / flight_01->getFlightTime( 3504 ).
  ULINE.

  DATA : wa TYPE SPFLI.

  wa = flight_01->getAllConnectionFacts( 3504 ).
  WRITE: / wa-carrid, 5 wa-connid, 10 wa-countryfr, 14 wa-cityfrom, 36 wa-airpfrom, 40 wa-countryto,
  44 wa-cityto, 66 wa-airpto, 69 wa-fltime, 77 wa-deptime, 87 wa-arrtime, 97 wa-distance, 107 wa-distid,
  110 wa-fltype, 115 wa-period.

  Uline.