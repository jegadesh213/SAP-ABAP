*&---------------------------------------------------------------------*
*& Report Z_ABAP_NEWSYNTAX_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_newsyntax_02.

TABLES : zzempprac.

DATA : string1(200).

DATA : lv_num    TYPE String,
       lv_name   TYPE String,
       lv_dept   TYPE String,
       lv_salary TYPE String,
       lv_units  TYPE String.


SELECT SINGLE * FROM  zzempprac INTO @DATA(it_employee).

lv_num = it_employee-emplnum.
lv_name = it_employee-emplname.
lv_dept = it_employee-empdept.
lv_salary = it_employee-empsalary.
lv_units = it_employee-units.

"Old Method
CONCATENATE 'The Details : ' lv_num lv_name lv_dept lv_salary lv_units INTO string1 SEPARATED BY space.
WRITE : string1.

"New Method
DATA(string2) = | The Details : { lv_num } { lv_name } { lv_dept } { lv_salary } { lv_units } |.
WRITE : string2.

DATA(nstring) = | The Details : | && lv_num && lv_name &&  lv_dept && lv_salary && lv_units && | Created Successfully |.
WRITE : / nstring.