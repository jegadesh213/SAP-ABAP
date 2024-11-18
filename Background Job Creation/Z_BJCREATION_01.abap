*&---------------------------------------------------------------------*
*& Report Z_BJCREATION_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_bjcreation_01.

DATA: lo_send_request TYPE REF TO cl_bcs,
      lo_document     TYPE REF TO cl_document_bcs,
      lv_recipient    TYPE string, " Keeping it as TYPE string
      lt_text         TYPE TABLE OF soli,
      lv_text         TYPE soli.

lv_recipient = 'single_recipient@example.com'.

* Create the send request
lo_send_request = cl_bcs=>create_persistent( ).

* Define the message content
lv_text = 'Background job has completed successfully.'.
APPEND lv_text TO lt_text.

* Create the email document
lo_document = cl_document_bcs=>create_document(
i_type    = 'RAW'
i_subject = 'Job Report'
i_text    = lt_text
).

* Set the document in the send request
lo_send_request->set_document( lo_document ).

* Add the recipient
lo_send_request->add_recipient(
  cl_cam_address_bcs=>create_internet_address( lv_recipient )
).

* Send the email
lo_send_request->send( i_with_error_screen = 'X' ).