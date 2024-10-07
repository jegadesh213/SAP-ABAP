*&---------------------------------------------------------------------*
*& Report Z_JAPANESE_MATERIAL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_JAPANESE_MATERIAL_.

TYPES : BEGIN OF ty_mara,
          matnr TYPE matnr,
          matkl TYPE matkl,
          spras TYPE spras,
          maktx TYPE maktx,
        END OF ty_mara.

DATA : it_mara TYPE TABLE OF ty_mara,
       wa_mara TYPE ty_mara.

PARAMETERS : p_matnr TYPE matnr,
             p_spras TYPE spras.

SELECT mara~matnr mara~matkl makt~spras makt~maktx FROM mara as mara
                  INNER JOIN makt as makt on mara~matnr = makt~matnr
                  INTO TABLE it_mara.

LOOP AT it_mara INTO wa_mara.
  WRITE : / wa_mara-matnr , wa_mara-matkl , wa_mara-spras , wa_mara-maktx.
ENDLOOP.