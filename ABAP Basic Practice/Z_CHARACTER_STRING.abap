*&---------------------------------------------------------------------*
*& Report Z_CHARACTER_STRING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_character_string_.

TABLES Zemployees.

*Declaring C and N Fields
DATA : s_fname LIKE Zemployees-Firstname,
       s_lname LIKE Zemployees-Surname.

s_fname = 'Jegan'.
s_lname = 'B'.

WRITE : s_fname && '.' && s_lname.
ULINE.

*Character Length Calculation
DATA leng_int TYPE i.
leng_int = strlen( s_fname ).

WRITE / 'Length of the surname is : ' &&  leng_int LEFT-JUSTIFIED.
ULINE.

*Character String and Concatenate
DATA : title(4)     TYPE c VALUE 'Mr',
       firstName(3) TYPE c VALUE 'Joe',
       lastName(5)  TYPE c VALUE 'Smith',
       sep,
       final(20)    TYPE c.

CONCATENATE title firstName lastName INTO final SEPARATED BY sep.
WRITE final.
ULINE.

*Character condense
CONDENSE final NO-GAPS.
WRITE final.

CONCATENATE title firstName lastName INTO final SEPARATED BY sep.
WRITE / final.
ULINE.

*Replacing Character Strings
DATA replaceName(10) TYPE c VALUE 'Jegan.B'.
WRITE replaceName.
WRITE / 'After Replacement'.

WHILE sy-subrc = 0.
  REPLACE '.' WITH '/' INTO replaceName.
ENDWHILE.

WRITE / replaceName.
ULINE.

*Searching Characters
DATA searchEle(20) TYPE c VALUE 'Mr. Joe Smith'.
WRITE searchEle.

*search without space
SEARCH searchEle FOR 'Joe '.
WRITE : / 'sy-subrc : ' , sy-subrc , 'sy-fdpos : ' , sy-fdpos.

*Search including the space
SEARCH searchEle FOR '.Joe .'.
WRITE : / 'sy-subrc : ' , sy-subrc , 'sy-fdpos : ' , sy-fdpos.
ULINE.

*Search with an wildCard
SEARCH searchEle FOR '*ith'.
WRITE : / 'sy-subrc : ' , sy-subrc , 'sy-fdpos : ' , sy-fdpos.

SEARCH searchEle FOR 'smi*'.
WRITE : / 'sy-subrc : ' , sy-subrc , 'sy-fdpos : ' , sy-fdpos.
ULINE.

*shifting Characters
DATA : numShifting TYPE c LENGTH 30 VALUE '0000123456'.

SHIFT numShifting.
WRITE / numShifting.

SHIFT numShifting CIRCULAR.
WRITE / numShifting.

SHIFT numShifting LEFT DELETING LEADING '0'.
WRITE / numShifting.
ULINE.

*Sub-fields
DATA : telePhoneNumber(20) TYPE c VALUE '+91-9361951163',
       countryCode(20)     TYPE c,
       sepPhoneNumber(20)  TYPE c.

write : /'Whole Number : ', telePhoneNumber.

countryCode = telePhoneNumber(3).
sepPhoneNumber = telephoneNumber+4(10).

WRITE : / 'Country Code : ' , countryCode.
WRITE : / 'Telephone Number : ', sepPhoneNumber.

telePhoneNumber(3) = '+80'.

WRITE :/ 'Changed Country Code : ',telePhoneNumber(3).
ULINE.