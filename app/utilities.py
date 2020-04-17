import operator
import hashlib
import json
import os
import math 

class Utils:

    random = None 

    def __init__(self, random):
        self.random = random 


    def hashid(self, data):
        '''
            Generate a unique hash from the data        
        '''
        if type(data) == str:
            text = data
        elif type(data) == dict:
                text = str(data)
        else:
            text = str(data)

        return hashlib.md5(text.encode('utf-8')).hexdigest()

    def load_jsondatafile(self, jsonfilespec): 
        '''
        Load json file into python object
        '''
        spec = os.path.join(os.getcwd(),jsonfilespec)
        with open(spec,'r') as f:
            data = json.load(f)
            return data

    def roll_dice(self, number_of_rolls= 6, sides_on_die=6, start_at=0):
        '''
            Simulate a normal distribution of values through a dice simulator
        '''
        total = 0
        for i in range(number_of_rolls):
            total += self.random.randint(start_at,sides_on_die-1+start_at)
        return total

    def gen_dice(self, max_buckets, widest_normal_dist=True):
        '''
            Input the number of buckets and the whether you want a wide or narrow distribution and you 
            will get back the required arguments to roll dice
        '''
        n = max_buckets - 1
        if widest_normal_dist==True:
            for i in range(int(math.sqrt(n)),1,-1):
                if n%i == 0:
                    break        
        else:
            for i in range(2,n+1):
                if n%i == 0:
                    break

        rolls = n//i
        sides = i+1
        return rolls, sides

    def rand_normal_dist(self, n, widest_normal_dist=True):
        '''
            Get a random number between 0 and n, using a standard normal distribution.
            widest_normal_dist=True will use the widest distribution possible (larger standard deviation)
        '''
        rolls,sides = self.gen_dice(n,widest_normal_dist);
        return self.roll_dice(rolls, sides,0)


    def ssn_gen(self, count):
        '''
        Generate count number of unique social-security numbers
        '''    
        prefix = list(range(1000))
        middle = list(range(100))
        suffix = list(range(10000))
        numbers = []
        self.random.shuffle(prefix)
        self.random.shuffle(middle)
        self.random.shuffle(suffix)    
        for i in range(count):
            p = self.random.choice(prefix)
            m = self.random.choice(middle)
            s = suffix.pop()
            number = f"{p:03}-{m:02}-{s:04}"
            numbers.append(number)
        return numbers
    

if __name__=='__main__':
    import random 
    random.seed(0) # same seed for testing 

    utils = Utils(random)

    assert utils.hashid('test') == '098f6bcd4621d373cade4e832627b4f6'
    assert utils.hashid(1) == 'c4ca4238a0b923820dcc509a6f75849b'
    assert utils.hashid({ 'name' : 'test', 'age' : 99 }) == 'b577e0b3efe659afbac52a5cfbb4a619'
    assert utils.roll_dice(number_of_rolls= 6, sides_on_die=6, start_at=0) == 15
    assert utils.rand_normal_dist(17, widest_normal_dist=True) == 10
    assert utils.rand_normal_dist(17, widest_normal_dist=False) == 7
    assert utils.ssn_gen(1)[0] == '861-76-1402'
