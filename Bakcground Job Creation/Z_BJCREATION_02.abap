*&---------------------------------------------------------------------*
*& Report Z_BJCREATION_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_bjcreation_02.

DATA: lt_recipients   TYPE TABLE OF string,
      lo_send_request TYPE REF TO cl_bcs,
      lo_document     TYPE REF TO cl_document_bcs,
      lv_email        TYPE string.


lt_recipients = VALUE #( ( 'user1@example.com' ) ( 'user2@example.com' ) ).

lo_send_request = cl_bcs=>create_persistent( ).

lo_document = cl_document_bcs=>create_document(
  i_type    = 'RAW'
  i_subject = 'Job Report'
  i_text    = 'Background job has completed successfully.'
).
lo_send_request->set_document( lo_document ).

LOOP AT lt_recipients INTO lv_email.
  lo_send_request->add_recipient(
    cl_cam_address_bcs=>create_internet_address( lv_email )
  ).
ENDLOOP.

lo_send_request->send( i_with_error_screen = 'X' ).