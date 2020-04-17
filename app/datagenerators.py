import math
import random
import os
import json 
name = "datagenerators"


class DataGenerator:

    def __init__(self,random_seed, schema_base_path):
        self.__random_seed__ = random_seed
        self.random = random
        self.random.seed(self.__random_seed__) 
        self.__schema_base_path__ = schema_base_path


    def payroll_employee_raise_pct(self,x):
        f = 2 * math.sin(0.5 * x ) + 3.5 + self.random.gauss(0,.25)
        y = round(f/100,3)
        return y

    def payroll_get_new_employee(self, employee_natural_key_list):
        employee_seed_file = os.path.join(self.__schema_base_path__, "payroll", "seeddata", "employees.json")
        with open(employee_seed_file,"r") as f:
            employees = json.load(f)
        new_employee_pool = [ e for e in employees if e['_key'] not in employee_natural_key_list]        
        new_emp = self.random.choice(new_employee_pool)
        departments = [ 'Clothing', 'Customer Service', 'Electronics', 'Hardware', 'Housewares', 'Sporting Goods', 'Toys' ]
        department_weights = [ 1, 1.5, 1.33, 1, 1, 1.33, 1.33]
        new_emp['department'] = self.random.choices(departments, weights = department_weights,k=1)[0]
        return new_emp



if __name__ == '__main__':
    
    
    print(f"Module: {name}")
    dg = DataGenerator(random_seed=0, schema_base_path="./schemas")
    print(dg.payroll_employee_raise_pct(0))
    print(dg.payroll_get_new_employee([]))
