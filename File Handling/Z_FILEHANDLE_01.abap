*&---------------------------------------------------------------------*
*& Report Z_FILEHANDLE_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_filehandle_01.

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
SELECTION-SCREEN END OF BLOCK 1.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM download_data.

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