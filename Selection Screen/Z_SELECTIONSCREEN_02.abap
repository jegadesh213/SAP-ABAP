*&---------------------------------------------------------------------*
*& Report Z_SELECTIONSCREEN_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_SELECTIONSCREEN_02.


type-pools : vrm.

data : gv_ID  TYPE  VRM_ID,
       GT_VALUES  TYPE VRM_VALUES,
       GS_VALUES LIKE LINE OF gt_values,

       gv_ID1  TYPE  VRM_ID,
       GT_VALUES1  TYPE VRM_VALUES,
       GS_VALUES1 LIKE LINE OF gt_values.

SELECTION-SCREEN begin of BLOCK b1.
   PARAMETERS : p_land1 type t005t-land1 as LISTBOX VISIBLE LENGTH 55 USER-COMMAND cmd,
                p_bland type t005u-bland as LISTBOX VISIBLE LENGTH 55.
SELECTION-SCREEN end of BLOCK b1.


at SELECTION-SCREEN OUTPUT.

   clear : gt_values[], gt_values1[].

 select LAND1, LANDX50 from t005t into TABLE @gt_values WHERE spras = @sy-langu.

   gv_ID = 'P_LAND1'.

   CALL FUNCTION 'VRM_SET_VALUES'
     EXPORTING
       id                    = gv_ID
       values                = gt_values
    EXCEPTIONS
      ID_ILLEGAL_NAME       = 1
      OTHERS                = 2
             .
   IF sy-subrc <> 0.
* Implement suitable error handling here
   ENDIF.


  if p_land1 is NOT INITIAL.

 select bland, bezei from t005u into TABLE @gt_values1 WHERE spras = @sy-langu
                                                         and land1 = @p_land1.


   gv_ID1 = 'P_BLAND'.

   CALL FUNCTION 'VRM_SET_VALUES'
     EXPORTING
       id                    = gv_ID1
       values                = gt_values1
    EXCEPTIONS
      ID_ILLEGAL_NAME       = 1
      OTHERS                = 2
             .
   IF sy-subrc <> 0.
* Implement suitable error handling here
   ENDIF.

    clear : p_bland.

  endif.



START-OF-SELECTION.


end-of-SELECTION.