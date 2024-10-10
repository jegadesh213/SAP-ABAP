*&---------------------------------------------------------------------*
*& Report Z_FM_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_fm_02.

TABLES : zzempprac.

TYPES : BEGIN OF ty_employee,
          emplnum   TYPE zzempprac-emplnum,
          emplname  TYPE zzempprac-emplname,
          empdept   TYPE zzempprac-empdept,
          empsalary TYPE zzempprac-empsalary,
          units     TYPE zzempprac-units,
        END OF ty_employee.

DATA : it_employee TYPE TABLE OF ty_employee,
       wa_employee TYPE ty_employee.

SELECT * FROM zzempprac INTO TABLE it_employee.

SET PF-STATUS 'STATUS'.

LOOP AT it_employee INTO wa_employee.
  WRITE : / wa_employee-emplnum , wa_employee-emplname , wa_employee-empdept , wa_employee-empsalary , wa_employee-units.
ENDLOOP.

AT USER-COMMAND.
  CASE sy-ucomm.
    WHEN 'TEXT'.
      CALL FUNCTION 'GUI_DOWNLOAD'
        EXPORTING
*         BIN_FILESIZE                    =
          filename = 'C:\Users\20506\Downloads\ABAP Basic Practice\Modularization and PF Status\FM Module Export Files\file.txt'
          filetype = 'ASC'
*       IMPORTING
*         FILELENGTH                      =
        TABLES
          data_tab = it_employee
*         FIELDNAMES                      =
        .
      IF sy-subrc <> 0.
*       Implement suitable error handling here
      ENDIF.

    WHEN 'EXCEL'.
      CALL FUNCTION 'GUI_DOWNLOAD'
        EXPORTING
*         BIN_FILESIZE                    =
          filename = 'C:\Users\20506\Downloads\ABAP Basic Practice\Modularization and PF Status\FM Module Export Files\file.xls'
          filetype = 'ASC'
*       IMPORTING
*         FILELENGTH                      =
        TABLES
          data_tab = it_employee
*         FIELDNAMES                      =
        .
      IF sy-subrc <> 0.
*       Implement suitable error handling here
      ENDIF.

    WHEN 'DOWNLOAD'.
      CALL FUNCTION 'GUI_DOWNLOAD'
        EXPORTING
*         BIN_FILESIZE                    =
          filename = 'C:\Users\20506\Downloads\ABAP Basic Practice\Modularization and PF Status\FM Module Export Files\file.xls'
          filetype = 'ASC'
*         IMPORTING
*         FILELENGTH                      =
        TABLES
          data_tab = it_employee
*         FIELDNAMES                      =
        .
      IF sy-subrc <> 0.
*         Implement suitable error handling here
      ENDIF.
  ENDCASE.