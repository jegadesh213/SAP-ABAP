*&---------------------------------------------------------------------*
*& Report Z_JOINTABLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_jointable.

TYPES: BEGIN OF ty_result,
         matnr TYPE mara-matnr,    " Material number from MARA
         werks TYPE marc-werks,    " Plant from MARC
         lgort TYPE mard-lgort,    " Storage location from MARD
         maktx TYPE makt-maktx,    " Material description from MAKT
       END OF ty_result.

DATA: it_result TYPE TABLE OF ty_result,
      wa_result TYPE ty_result.

SELECT mara~matnr marc~werks mard~lgort makt~maktx
  INTO TABLE it_result
  FROM mara
  INNER JOIN marc ON mara~matnr = marc~matnr
  INNER JOIN mard ON marc~matnr = mard~matnr AND marc~werks = mard~werks
  INNER JOIN makt ON mara~matnr = makt~matnr
  WHERE mara~matnr = '100000'  " Filter by material number (example)
    AND makt~spras = 'E'.      " Filter by language (English)

LOOP AT it_result INTO wa_result.
  WRITE: / 'Material:', wa_result-matnr,
         / 'Plant:', wa_result-werks,
         / 'Storage Location:', wa_result-lgort,
         / 'Description:', wa_result-maktx.
ENDLOOP.