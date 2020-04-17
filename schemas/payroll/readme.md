# Payroll

This is a sample Payroll database. It is a very simplified version of an actual payroll system, designed to help students learn relational database design best practices.

This is a dynamic data set. Every installed instance will have the same initial data set, but over time the data changes and updates will be different.

## Data Model

### Entities

1. **Employee** - someone who works at the company and will receive a paycheck. There are two classes of Employees hourly and salaried. Hourly must  log their daily hours in a Timesheet for their payroll to be processed. 
2. **Pay Period** - dates payroll is processed. Payroll is processed weekly each Friday.
3. **Paycheck** - monies issued to an employee for pay period worked. For hourly employees this is the sum of hours worked within that pay period times their rate. For salaried employees it is their pay rate. 
4. **Timecard Entries** - for hourly employees, this must be completed each day as a summary of hours worked within the pay period.

### Relationships

1. An **Employee** works for 1 and only 1 **Department**. A **Department** contains 0 or more Employees. There are Hourly and Salaried employees. 
2. **Employee** is issued 1 or more **Paychecks**. A **Paycheck** is issued to 1 and only 1 **Employee**.
3. A **Paycheck** is issued for 1 and only 1 **Pay Period**. A **Pay Period** contains 0 or more **Paychecks**
4. An hourly  **Employee** submits 1 or more daily **Timecard Entries**. A **Timecard Entry** is submitted by 1 and only 1 **Employee**.
5. A **Timecard Entry** is submitted for 1 and only 1 **Pay Period**. A **Pay Period** contains 0 or more **Timecard Entries**

## Data Updates

This data model is updatable via a script which keeps the activity current and tracks changes over time. Processes:

1. Hire employee. 
2. Terminate employee. 
3. Transfer employee to another department.
4. Add daily time card entries for all hourly employees 
5. Process payroll weekly. For hourly and salaried employees.

## Database Diagram

![Payroll Database Diagram](/static/images/payroll.png)
