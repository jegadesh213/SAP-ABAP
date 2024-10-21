FUNCTION z_rfcprac.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(EP_ITEM_MSG) TYPE  CHAR100
*"  TABLES
*"      IT_EMPLOYEE STRUCTURE  ZZEMPPRAC
*"  EXCEPTIONS
*"      INSERT_ERROR
*"----------------------------------------------------------------------

  IF it_employee[] IS NOT INITIAL.

    TRY.
        INSERT zzempprac FROM TABLE it_employee.
        ep_item_msg = 'DATA ENTERED SUCCESSFULLY'.
      CATCH cx_root.
        RAISE insert_error.
    ENDTRY.

  ENDIF.
  WAIT UP TO 5 SECONDS.
ENDFUNCTION.