*&---------------------------------------------------------------------*
*& Report Z_FLOWCONTROLANDLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_flowcontrolandle_.

TABLES zemployees.

DATA : int_01 TYPE i VALUE 10,
       int_02 TYPE i VALUE 20.


*Using If statements
IF int_01 = int_02 .
  WRITE 'Equal'.
ELSE.
  WRITE 'Not Equal'.
ENDIF.
ULINE.

*Linking Logical expression together.
IF int_01 = int_02.
  WRITE 'Equal'.
ELSEIF int_01 < int_02 AND int_01 <> int_02.
  WRITE : int_01 , ' Less than and not equal to ' , int_02 LEFT-JUSTIFIED.
ELSEIF int_01 > int_02 AND int_01 <> int_02.
  WRITE : int_01 , ' Greater than and not equal to ' , int_02 LEFT-JUSTIFIED.
ENDIF.
ULINE.

*Case statement in ABAP
CASE int_01.
  WHEN '1'.
    WRITE 'ONE'.
  WHEN '2'.
    WRITE 'TWO'.
  WHEN '3'.
    WRITE 'THREE'.
  WHEN '4'.
    WRITE 'FOUR'.
  WHEN '5'.
    WRITE 'FIVE'.
  WHEN '6'.
    WRITE 'SIX'.
  WHEN '7'.
    WRITE 'SEVEN'.
  WHEN '8'.
    WRITE 'EIGHT'.
  WHEN '9'.
    WRITE 'NINE'.
  WHEN '10'.
    WRITE 'TEN'.
ENDCASE.
ULINE.

*Select loop in ABAP
SELECT * FROM Zemployees.
  WRITE :/ zemployees-title,
           zemployees-surname,
           zemployees-firstname.
ENDSELECT.
ULINE.

DATA: a TYPE i VALUE 0,
      b TYPE i VALUE 1.

*Do statements
DO 15 TIMES.
  a += 1.
  WRITE a.
ENDDO.
ULINE.

*Nested Do
*DO 15 TIMES.
*  a += 1.
*  WRITE a LEFT-JUSTIFIED.
*  DO 10 TIMES.
*    b += 1.
*    write / b.
*  ENDDO.
*ENDDO.
*ULINE.

*While Loop
WHILE b <> 15.
  WRITE b.
  b += 1.
ENDWHILE.
ULINE.

a = 0.
*Continue statement.
*Printing only the odd numbers.
WHILE a <> 15.
  IF a MOD 2 = 0.
    a += 1.
    CONTINUE.
  ENDIF.
  WRITE a.
  a += 1.
ENDWHILE.
ULINE.

a = 0.
*Check termiation Loop in ABAP
*This will skip 2 just like the Break Statement in JAVA.
DO 15 TIMES.
  a += 1.
  CHECK sy-index <> 2.
  WRITE a.
ENDDO.
ULINE.

a = 0.
*Exit Statement in ABAP
DO 15 TIMES.
  a += 1.
  IF a = 10.
    EXIT.
  ENDIF.
  WRITE a.
ENDDO.
ULINE.