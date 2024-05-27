# Cheep Web Hosting

A Data Modeling Case Study.

## Overview

You are employed as a project analyst at the famous IT consulting firm FudgeyCo Consulting. Your (now former) co-worker, Dudley Doitwrong has messed up another client’s database. It is up to you to fix Dudley’s mistakes and make the client happy once again. Your company’s requirements team as gathered a very accurate set of requirements, so that’s not the issue. The problem is with Dudley’s implementation of those requirements. Being the lazy guy that he is, he skipped the conceptual and logical modeling and went straight to the SQL implementation! Yikes!

## What You Must Do

Your objective is to improve upon Dudley’s original design by using the data modeling tools and techniques we learned in class. You will take two separate approaches to correct this problem. In the first approach you will build a logical model from the conceptual model of the requirements.  In the second approach you will normalize Dudley’s implementation to produce a logical model in 3NF. 

### Steps

1.	Build a conceptual data design based on the requirements collected information and sample data given. This design should be independent of Dudley’s work. Use the given requirements!
2.	Convert your conceptual data design into a logical data design by following the mapping rules we learned in class. Again do this independently of Dudley’s existing design.
3.	Review Dudley’s implementation (on last page and as a spreadsheet). Perform a quick normalization on his database.
4.	Normalize Dudly’s database implementation to 3NF as a logical model.
5.	Compare your Logical model in step 2 to the normalized logical model in step 4. 
    a.	How are they similar? Does this surprise you? Explain.
    b.	How are they different? Does this surprise you? Explain.
    c.	Come up with a final logical model which you will use for data migration. 
    d.	Make sure your final logical model includes appropriate keys, data types and table constraints as you will implement it in the next step.
6.	Implement new SQL tables based on the final logical model in step 5. 
    a.	Write a single SQL script which will drop and re-create the schema each time the script runs. 
    b.	Make sure to include appropriate selections for keys, data types and table constraints.
7.	Write SQL scripts to clean up any data then, migrate from Dudley’s implementation to your new implementation and make this customer happy again!

## Client Information 

CheepWebHosting.com is a new addition to the FudgeyCo Consulting family and right now because of what has been deemed the “Dudley situation” they’re not happy customers. CheepWebHosting.com is a new internet startup which provides web hosting services only to birds (yeah I know, but everyone needs an angle nowadays…haha).
CheepWebHosting.com (CWH) has contracted with FudgeyCo Consulting to build a system to manage hosted web accounts for their customers. The data requirements of this system are outlined in the requirements section below.

### Data Requirements

The business model CWH is quite simple:

* Customers sign up for accounts which allow them to create / host websites.
* Customers must provide basic contact information such as name, email and credit card billing information before they can create an account.
* Each account is associated with a plan which governs the monthly storage and bandwidth limits as well as monthly fee billed to the credit card. The plans are outlined in table below.
* Each account resides on a server. There are two servers CWH offers each with their own distinct feature set: Windows and Linux. The servers are outlined in the table below
* Each account supports one or more domains. For example a user’s account might resolve to foo.com and foo.org.


Entities and attributes:

* Account:  account name (unique, required); account expiration (required); account domains (required, multi-valued)
* Plan:  plan name (unique, required); plan monthly fee (required); plan bandwidth limit in GB (required); plan disk limit in GB (required);
* Customer: customer name (required, composite (last/first)); customer email (required, unique); customer credit card (required, composite(card no, card type));
* Server: server name (required, unique); server ip address (required, unique); server operating system(required)

Relationships:

* A Customer is associated with 0 or more Accounts. An Account is associated with 1 and only 1 Customer.
* An Account resides on 1 and only 1 Server. A Server hosts 0 or more Accounts.
* An Account is signed up for 1 and only 1 Plan. A Plan is assigned to 1 or more Accounts.

Plans:

The company offers 3 basic plans:

1. The Basic plan is $9.95 /month. Limits are 1GB disk space and 1GB network traffic.
2. The Standard plan is $14.95 /month. Limits are 10GB disk space and 10GB network traffic.
3. The Premuim plan is $19.95 /month. Limits are 100GB disk space and 10GB network traffic.

Servers:

The company hosts customer websites on two servers:

1. The Bilbo server runs the Windows operating system and has IP address 10.128.232.41
2. The Frodo server run the Linux operating system and has the IP addeess 10.128.232.42

### Dudley's Implementation

Dudley's implementation with loaded customer data in it can be found in the database. It has several problems. Here are the more obvious ones:

1. You cannot add a server or plan with out a customer.
2. To change the pricing on a plan, you must update several customers.
3. If a customer hosts more than one site their customer information is present more than once. 
4. To add or remove a domain from a website, you must updatee a user account. 
5. The company purchased a new server as does not know how to add it to the database.