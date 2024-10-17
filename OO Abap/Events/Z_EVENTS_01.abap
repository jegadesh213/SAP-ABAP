*&---------------------------------------------------------------------*
*& Report Z_EVENTS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_events_01.

CLASS chef DEFINITION.
  PUBLIC SECTION.
    METHODS : call_service.

    EVENTS : call_waiter.

ENDCLASS.

CLASS customer DEFINITION.
  PUBLIC SECTION.
    METHODS : constructor IMPORTING VALUE(i_tablenumber) TYPE i,
      call_assistance.

    EVENTS : call_waiter EXPORTING VALUE(e_tablenumber) TYPE i.

  PROTECTED SECTION.
    DATA : tablenumber TYPE i.
ENDCLASS.

CLASS waiter DEFINITION.
  PUBLIC SECTION.
    METHODS : constructor IMPORTING VALUE(i_who) TYPE string,
      go_for_chef FOR EVENT call_waiter OF chef,
      go_for_customer FOR EVENT call_waiter OF customer IMPORTING e_tablenumber.

  PROTECTED SECTION.
    DATA : who TYPE string.
ENDCLASS.

CLASS chef IMPLEMENTATION.

  METHOD call_service.
    WRITE : / 'CHEF CALLING FOR SERVICE .....'.
    RAISE EVENT call_waiter.
    WRITE : / 'CHEF CALLED FOR WAITER'.
    ULINE.
  ENDMETHOD.

ENDCLASS.

CLASS customer IMPLEMENTATION.

  METHOD constructor.
    tablenumber = i_tablenumber.
  ENDMETHOD.

  METHOD call_assistance.
    WRITE : / 'CUSTOMER CALLING FOR WAITER .....'.
    RAISE EVENT call_waiter EXPORTING e_tablenumber = tablenumber.
    WRITE : / 'CUSTOMER CALLED FOR WAITER'.
    ULINE.
  ENDMETHOD.

ENDCLASS.

CLASS waiter IMPLEMENTATION.

  METHOD constructor .
    who = i_who.
  ENDMETHOD.

  METHOD go_for_chef.
    WRITE : / who , 'Going to the chef ...'.
  ENDMETHOD.

  METHOD go_for_customer.
    WRITE :/ who , 'Going to the customer at the table : ', e_tablenumber LEFT-JUSTIFIED.
  ENDMETHOD.

ENDCLASS.

DATA : chef_01     TYPE REF TO chef,
       customer_01 TYPE REF TO customer,
       customer_02 TYPE REF TO customer,
       waiter_01   TYPE REF TO waiter,
       waiter_02   TYPE REF TO waiter.

START-OF-SELECTION.

  CREATE OBJECT chef_01.
  CREATE OBJECT customer_01 EXPORTING i_tablenumber = 2.
  CREATE OBJECT customer_02 EXPORTING i_tablenumber = 6.
  CREATE OBJECT waiter_01 EXPORTING i_who = 'SARAH'.
  CREATE OBJECT waiter_02 EXPORTING i_who = 'BOB'.

  SET HANDLER : waiter_01->go_for_chef  FOR chef_01,
                waiter_02->go_for_customer FOR ALL INSTANCES.

  chef_01->call_service( ).
  customer_01->call_assistance( ).
  customer_02->call_assistance( ).