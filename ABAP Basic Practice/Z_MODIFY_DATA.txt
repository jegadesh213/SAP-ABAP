*&---------------------------------------------------------------------*
*& Report Z_MODIFY_DATA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_modify_data_.

TABLES zemployees.

DATA wa_employees LIKE zemployees.

wa_employees-Employee = 10009.
wa_employees-Surname = 'Rayvanth'.
wa_employees-Firstname = 'Raj'.
wa_employees-Title = 'Mr'.
wa_employees-dob = '10111996'.

*Inserting the entry we created .
INSERT zemployees FROM wa_employees.

*checking for the entries are being entered successfully or not
IF sy-subrc = 0.
  WRITE 'Records inserted Successfully'.
ELSE.
  WRITE 'we have the error in running'.
ENDIF.
ULINE.

*Selecting the enteries for display
SELECT * FROM zemployees.
  WRITE: / zemployees-firstname,
           zemployees-surname.
ENDSELECT.
ULINE.

*clearing the Data table Entry
*Clear wa_employees.

*Updating the entry in the Data table.
wa_employees-Employee = 10009.
wa_employees-Firstname = 'Rayvanth'.
wa_employees-Surname = 'Raj'.
wa_employees-Title = 'Mr.'.
wa_employees-dob = '10111996'.

UPDATE zemployees FROM wa_employees.

SELECT * FROM zemployees.
  WRITE: / zemployees-firstname,
           zemployees-surname.
ENDSELECT.
Uline.

*Modify the Data table entry
*Modify will modify the entry if it is Present else it will skip and create a new entry instead of that.
wa_employees-Employee = 10010.
wa_employees-Firstname = 'Babu'.
wa_employees-Surname = 'M'.
wa_employees-Title = 'Mr.'.
wa_employees-dob = '10111972'.

MODIFY zemployees from wa_employees.

SELECT * FROM zemployees.
  WRITE: / zemployees-firstname,
           zemployees-surname.
ENDSELECT.
Uline.

*deleting the data table Entry.
DELETE FROM zemployees WHERE Employee = 10009.

SELECT * FROM zemployees.
  WRITE: / zemployees-firstname,
           zemployees-surname.
ENDSELECT.
Uline.