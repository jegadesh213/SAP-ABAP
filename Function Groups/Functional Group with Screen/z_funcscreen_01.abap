FUNCTION z_funcscreen_01.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IP_EMPNUM) TYPE  ZZEMPPRAC-EMPLNUM OPTIONAL
*"     VALUE(IP_EMPNAME) TYPE  ZZEMPPRAC-EMPLNAME OPTIONAL
*"     VALUE(IP_EMPDEPT) TYPE  ZZEMPPRAC-EMPDEPT OPTIONAL
*"  EXPORTING
*"     REFERENCE(TY_EMPLOYEE) TYPE  ZZEMPPRAC
*"----------------------------------------------------------------------


  IF ip_empnum IS NOT INITIAL AND
     ip_empname IS NOT INITIAL AND
     ip_empdept IS NOT INITIAL.


    SELECT SINGLE * FROM zzempprac INTO it_employee WHERE emplnum = ip_empnum AND
                                                          emplname = ip_empname AND
                                                          empdept = ip_empdept.

     call SCREEN 0200 STARTING AT 10 2.

     ty_employee = it_employee.

    endif.


  ENDFUNCTION.