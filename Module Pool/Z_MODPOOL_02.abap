*&---------------------------------------------------------------------*
*& Report Z_MODPOOL_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_modpool_02.

TABLES : zzempprac.

DATA : editor_container TYPE REF TO cl_gui_custom_container,
       text_editor      TYPE REF TO cl_gui_textedit.

CONSTANTS : line_length TYPE i VALUE 132.

DATA : gt_elines(line_length) TYPE c OCCURS 0,
       gv_line(line_length)   TYPE c,

       gt_line                TYPE STANDARD TABLE OF tline,
       gs_line                TYPE tline,
       gv_name                TYPE tdobname.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS : p_num TYPE zzempprac-emplnum.
SELECTION-SCREEN END OF BLOCK b1.



START-OF-SELECTION.
  CALL SCREEN 0200.

END-OF-SELECTION.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS 'PF1'.
  SET TITLEBAR 'T1'.


  IF text_editor IS INITIAL.

    CREATE OBJECT editor_container
      EXPORTING
*       PARENT                      =     " Parent container
        container_name              = 'TEXTEDITOR'  " Name of the Screen CustCtrl Name to Link Container To
*       STYLE                       =     " Windows Style Attributes Applied to this Container
*       LIFETIME                    = LIFETIME_DEFAULT    " Lifetime
*       REPID                       =     " Screen to Which this Container is Linked
*       DYNNR                       =     " Report To Which this Container is Linked
*       NO_AUTODEF_PROGID_DYNNR     =     " Don't Autodefined Progid and Dynnr?
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.


    CREATE OBJECT text_editor
      EXPORTING
*       MAX_NUMBER_CHARS           =     " maximum number of characters insertable into editor control
*       STYLE                      = 0    " control style, if initial a defined value is choosen
        wordwrap_mode              = cl_gui_textedit=>wordwrap_at_fixed_position
        wordwrap_position          = line_length    " position of wordwrap, only makes sense with wordwrap_mode=2
        wordwrap_to_linebreak_mode = cl_gui_textedit=>true
*       FILEDROP_MODE              = DROPFILE_EVENT_OFF    " event mode to handle drop of files on control
        parent                     = editor_container   " Parent Container
*       LIFETIME                   =     " for life time management
*       NAME                       =     " name for the control
      EXCEPTIONS
        error_cntl_create          = 1
        error_cntl_init            = 2
        error_cntl_link            = 3
        error_dp_create            = 4
        gui_type_not_supported     = 5
        OTHERS                     = 6.
    IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.


    gv_name = p_num.
    CONDENSE gv_name.

    CLEAR : gt_line[].

    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        client                  = sy-mandt
        id                      = 'Z002'
        language                = sy-langu
        name                    = gv_name
        object                  = 'ZEMPOO'
*       ARCHIVE_HANDLE          = 0
*       LOCAL_CAT               = ' '
*   IMPORTING
*       HEADER                  =
*       OLD_LINE_COUNTER        =
      TABLES
        lines                   = gt_line
      EXCEPTIONS
        id                      = 1
        language                = 2
        name                    = 3
        not_found               = 4
        object                  = 5
        reference_check         = 6
        wrong_access_to_archive = 7
        OTHERS                  = 8.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


    IF gt_line[] IS NOT INITIAL.

      CLEAR : gt_elines.

      LOOP AT gt_line INTO gs_line.

        APPEND gs_line-tdline  TO gt_elines.

        CLEAR : gs_line.
      ENDLOOP.

      CALL METHOD text_editor->set_text_as_r3table
        EXPORTING
          table           = gt_elines    " table with text
        EXCEPTIONS
          error_dp        = 1
          error_dp_create = 2
          OTHERS          = 3.
      IF sy-subrc <> 0.
*  MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*             WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.



    ENDIF.

  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  SET SCREEN 0.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE sy-ucomm.

    WHEN 'BACK'  OR 'EXIT' OR 'CANCEL'.
      SET SCREEN 0.

    WHEN 'SAVE'.
      PERFORM save.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  SAVE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM save .

  CALL METHOD text_editor->get_text_as_r3table
*      EXPORTING
*        ONLY_WHEN_MODIFIED     = FALSE    " get text only when modified
    IMPORTING
      table                  = gt_elines   " text as R/3 table
*     IS_MODIFIED            =     " modify status of text
    EXCEPTIONS
      error_dp               = 1
      error_cntl_call_method = 2
      error_dp_create        = 3
      potential_data_loss    = 4
      OTHERS                 = 5.
  IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CLEAR : gt_line[], gs_line, gv_line.


  LOOP AT gt_elines INTO gv_line.

    gs_line-tdformat = '*'.
    gs_line-tdline   = gv_line.
    APPEND gs_line TO gt_line.


    CLEAR : gs_line,  gv_line.
  ENDLOOP.

  "call the create text FM

  gv_name  = p_num.
  CONDENSE gv_name.


  CALL FUNCTION 'CREATE_TEXT'
    EXPORTING
      fid       = 'Z002'
      flanguage = sy-langu
      fname     = gv_name
      fobject   = 'ZEMPOO'
*     SAVE_DIRECT       = 'X'
*     FFORMAT   = '*'
    TABLES
      flines    = gt_line
    EXCEPTIONS
      no_init   = 1
      no_save   = 2
      OTHERS    = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here

    MESSAGE 'Error while saving the text' TYPE 'I'.


  ELSE.
    MESSAGE 'Text saved successfully' TYPE 'I'.
    SET SCREEN 0.


  ENDIF.








ENDFORM.