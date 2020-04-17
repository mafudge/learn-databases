name = 'payroll'

class Payroll:
    '''
        This generates SQL statements based on the business processes for the payroll database.
        It does not execute these statements nor does it determine when they should be run.
        It merely generates a valid statement given the conditions. 
    '''

    def __init__(self):
        pass

    def issue_paychecks(self, employee_id_list, payperiod_id):
        sql = ""
        for empid in employee_id_list:
            sql += f"execute p_issue_paycheck @employee_id={empid}, @payperiod_id={payperiod_id} \n"
        return sql 

    def add_time_entry(self, employee_id, entry_date, hours_worked):
        sql = f"execute p_add_time_entry @employee_id={employee_id}, @entry_date='{entry_date}', @hours_worked={hours_worked}"
        return sql

if __name__ == '__main__':
    print(f"Module : {name}")
    p = Payroll()
    print( p.issue_paychecks([1,2,3], 20200101) )
    print( p.add_time_entry(1, '2020-01-01', 5))
