*&---------------------------------------------------------------------*
*& Report Z_FILEHANDLE_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_filehandle_02.

TABLES : zzempprac , zzempracdep.

TYPES : BEGIN OF ty_employee,
          emplnum   TYPE zzempprac-emplnum,
          emplname  TYPE zzempprac-emplname,
          empdept   TYPE zzempprac-empdept,
          empsalary TYPE zzempprac-empsalary,
          units     TYPE zzempprac-units,

          doj       TYPE zzempracdep-doj,
          role      TYPE zzempracdep-role,
        END OF ty_employee.

DATA : it_employee   TYPE TABLE OF ty_employee,
       wa_employee   TYPE ty_employee,
       filepath(100) VALUE 'C:\Users\20506\Downloads\ABAP Source Codes\ABAP Basic Practice\File Handling\Files\',
       file          TYPE string.

SELECTION-SCREEN BEGIN OF BLOCK 1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : s_num FOR zzempprac-emplnum.

  PARAMETERS:     p_role TYPE zzempracdep-role.
  SELECTION-SCREEN SKIP.

  PARAMETERS : p_file TYPE localfile.
  SELECTION-SCREEN SKIP.

  PARAMETERS : rr_01 RADIOBUTTON GROUP grp,
               rr_02 RADIOBUTTON GROUP grp.
SELECTION-SCREEN END OF BLOCK 1.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      program_name  = syst-cprog
      dynpro_number = syst-dynnr
*     FIELD_NAME    = ' '
    IMPORTING
      file_name     = p_file.



START-OF-SELECTION.

  IF rr_01 IS NOT INITIAL.
    PERFORM get_data.
    PERFORM download_data.
  ELSEIF rr_02 IS NOT INITIAL.
    PERFORM upload_file.
  ENDIF.


END-OF-SELECTION.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT a~emplnum a~emplname a~empdept a~empsalary a~units
         b~doj b~role FROM zzempprac AS a INNER JOIN zzempracdep AS b ON a~emplnum = b~emplnum
         INTO CORRESPONDING FIELDS OF TABLE it_employee
         WHERE a~emplnum IN s_num OR
               b~role = p_role.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form download_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM download_data .

  CONCATENATE filepath 'INVOICE' sy-datum sy-uzeit '.txt' INTO file SEPARATED BY '_'.

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
*     BIN_FILESIZE            =
      filename                = file
      filetype                = 'ASC'
*     APPEND                  = ' '
      write_field_separator   = 'X'
*     HEADER                  = '00'
*     TRUNC_TRAILING_BLANKS   = ' '
*     WRITE_LF                = 'X'
*     COL_SELECT              = ' '
*     COL_SELECT_MASK         = ' '
*     DAT_MODE                = ' '
*     CONFIRM_OVERWRITE       = ' '
*     NO_AUTH_CHECK           = ' '
*     CODEPAGE                = ' '
*     IGNORE_CERR             = ABAP_TRUE
*     REPLACEMENT             = '#'
*     WRITE_BOM               = ' '
*     TRUNC_TRAILING_BLANKS_EOL       = 'X'
*     WK1_N_FORMAT            = ' '
*     WK1_N_SIZE              = ' '
*     WK1_T_FORMAT            = ' '
*     WK1_T_SIZE              = ' '
*     WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
*     SHOW_TRANSFER_STATUS    = ABAP_TRUE
*     VIRUS_SCAN_PROFILE      = '/SCET/GUI_DOWNLOAD'
*   IMPORTING
*     FILELENGTH              =
    TABLES
      data_tab                = it_employee
*     FIELDNAMES              =
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
*     OTHERS                  = 22
    .
  IF sy-subrc <> 0.
    MESSAGE i000(8i) WITH |Error while downlaoding the file|.
  ELSE.
    MESSAGE i000(8i) WITH |File saved successfully|.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form upload_file
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM upload_file .

  IF p_file IS NOT INITIAL.
    file = p_file.

    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename                = file
        filetype                = 'ASC'
        has_field_separator     = 'X'
*       HEADER_LENGTH           = 0
*       READ_BY_LINE            = 'X'
*       DAT_MODE                = ' '
*       CODEPAGE                = ' '
*       IGNORE_CERR             = ABAP_TRUE
*       REPLACEMENT             = '#'
*       CHECK_BOM               = ' '
*       VIRUS_SCAN_PROFILE      =
*       NO_AUTH_CHECK           = ' '
*     IMPORTING
*       FILELENGTH              =
*       HEADER                  =
      TABLES
        data_tab                = it_employee
*     CHANGING
*       ISSCANPERFORMED         = ' '
      EXCEPTIONS
        file_open_error         = 1
        file_read_error         = 2
        no_batch                = 3
        gui_refuse_filetransfer = 4
        invalid_type            = 5
        no_authority            = 6
        unknown_error           = 7
        bad_data_format         = 8
        header_not_allowed      = 9
        separator_not_allowed   = 10
        header_too_long         = 11
        unknown_dp_error        = 12
        access_denied           = 13
        dp_out_of_memory        = 14
        disk_full               = 15
        dp_timeout              = 16
        OTHERS                  = 17.

    cl_demo_output=>display( it_employee ) .

  ELSE.
    MESSAGE i000(8i) WITH |Select the file for upload|.
  ENDIF.
ENDFORM.