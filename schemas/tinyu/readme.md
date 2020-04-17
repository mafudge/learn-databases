# TinyU

TinyU is a very simple student information system (SIS). It is one of the first examples used.

## Data Model

These are the business requirements for TinyU.

### Entities 

1. **Student** - people who take classes at tiny U. 
2. **Major** - the various majors offered by tiny U such as Information Management or Accounting.
3. **Academic Year** -- academic years for a student. eg. freshman, sohpomore, etc...

### Relationships


1. A **Student**  enrolls in 0 or 1 **Major**. A **Major** can have 0 or More **Students** enrolled in it.
2. A **Student**  is of 1 and only 1 **Academic Year**. An **Academci Year** can have 1 or More **Students** in it.
