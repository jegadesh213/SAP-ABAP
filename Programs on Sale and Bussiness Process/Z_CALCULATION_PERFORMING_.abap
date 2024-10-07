REPORT Z_MARA_PRAC_.

TABLES MARA.

TYPES : BEGIN OF ty_mara,
          matnr TYPE matnr,
          ersda TYPE ersda,
          matkl TYPE matkl,
        END OF ty_mara.

DATA : it_mara TYPE TABLE OF ty_mara,
       wa_mara TYPE ty_mara.

PARAMETERS : py_matkl TYPE matkl.

SELECT matnr, ersda, matkl FROM mara INTO TABLE @it_mara WHERE matkl = @py_matkl.

LOOP AT it_mara INTO wa_mara.
  WRITE : / wa_mara-matnr, wa_mara-ersda, wa_mara-matkl.
ENDLOOP.