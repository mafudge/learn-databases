# Let's Learn Databases!

*All the joy of a database environment without the pain of setup and configuration.* -mf

This repository contains docker configurations and base scripts necessary to provide a complete database management system with sample data and web-based tooling.

Use this software to accompany the [Applied Database Management](https://mafudge.github.io/applied-database-management/) textbook, the [Introduction to Database Management Systems](https://github.com/mafudge/ist659) course, or to just explore databases on your own! 

## What's included?

1. **Microsoft SQL Server 2019** database management system. [https://www.microsoft.com/en-us/sql-server](https://www.microsoft.com/en-us/sql-server) | [https://db-engines.com/en/ranking](https://db-engines.com/en/ranking)
2. **Database Provisioner** a Python Flask Web Application for creating sample databases and populating data.
3. **SQL Pad** a web-based query tool. [https://sqlpad.io/](https://sqlpad.io/)
4. **Adminer** a web-based database admin tool. [https://www.adminer.org/](https://www.adminer.org/)

## Hardware Requirements

1. A computer with one of these Operating Systems:

   - Mac OSX  
   - Windows 10 or higher  
   - Any Linux (Ubuntu, Fedora, etc. ) or  
   - Chrome OS w/Linux support enabled   
 [https://support.google.com/chromebook/answer/9145439?hl=en](https://support.google.com/chromebook/answer/9145439?hl=en) 
2. At least 8 GB RAM.
3. At least 8 GB free disk space. 

## Software Requirements

1. **Git** is required to clone this code repository. [https://git-scm.com/downloads](https://git-scm.com/downloads)
2. **Docker** is used to manage the containers. On Windows and Mac, download Docker Desktop 4.30 or higher. Installation instructions are here: [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)   
  **Mac Notes**: After you install, go to Settings and make sure "Use Rosetta for x86/amd64 emulation on Apple Silicon" and "Use Virtualization Framework" are enabled. 
3. **Azure Data Studio.** This is a Database Client application, allowing you write and analyze code against the database management systems.
[https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio](https://docs.microsoft.
com/en-us/sql/azure-data-studio/download-azure-data-studio)  
**NOTE:** while you can use adminer and SQL Pad for these purposes, Azure Data Studio is a more complete tool.

## Installing Learn Databases

With the requirements met, its time to install learn databases!  Simply clone or download this repository to your computer. 

If you have `git` installed on your computer and wish to clone the repository:

1. Open a terminal window. Make sure you are in a folder where you wish to store the code repository.
2. Type `git clone https://github.com/mafudge/learn-databases.git`  
The code will download from github to your computer.

If you do not have `git` installed or you do not wish to clone the repository:

1.  Click [https://github.com/mafudge/learn-databases/archive/master.zip](https://github.com/mafudge/learn-databases/archive/master.zip) to download this repository. 
2. After it downloads, unzip the file to a folder where you wish to store the code repository.

# Walkthrough 

Here's a video of the walkthrough:   

[![Watch the video of the walkthrough](https://img.youtube.com/vi/CxCUrQ6knRo/hqdefault.jpg)](https://youtu.be/CxCUrQ6knRo) 

[https://youtu.be/CxCUrQ6knRo](https://youtu.be/CxCUrQ6knRo)

## Running the containers

1. Open a terminal window inside the `learn-databases` folder. This is where you cloned or unzipped the code repository.
2. Type : `docker-compose up -d` to start everything. This might take some time as images are downloaded and/or built.
3. Type : `docker-compose ps` to see the `mssql`,  `provisioner`, `sqlpad`, `adminer` containers in a running **Up** state.

## Creating the Sample Databases

The **Database Provisioner** webapp can be used to create the sample databases. It will also display the database login information. 

1. To launch the **Database Provisioner* application, open a web browser and connect to:  
 [http://localhost:5001](http://localhost:5001)
 Database Connection information appears in the upper right, and a list of databases you can provision appears in the application window.  
   - Click the icon in the **Info** section to learn about each  database.
   - Click the **Create** button to generate the database schema and initial data for a database. 
   - If the database is updatable, Click the **Update** button to bring the data current.
   - You can click **Drop** at any time to remove the database, or **Recreate** to place the database back in its initial state. 

**Note:** These  commands can take time depending on the size or complexity of the database. Please be patient!

## Connecting to Microsoft SQL Server using the clients

What you need to know about the SQL Server configuration:

- The Server is configured to use Database Logins. The default login is `sa`
- When connecting from adminer / sql pad the database hostname is `mssql`. from azure data studio use `localhost`
- If asked, set encryption to `Optional`
- Always trust the server certificate.

### Connecting with Azure Data Studio Client

1. Open `Azure Data Studio`
2. Under `Servers` select `Add New Connection`
3. Fill in the connection information based on the information displayed in the Database Provisioner application. The exception here is we should use `localhost` for the server.
    - Server: `localhost`
    - Authentication Type: `SQL Login`
    - User name: `sa`
    - Password: Get this from the database provisioner app
    - Encrypt: `Optional`
    - Trust Server Certificate: `True`

4. Here's a quick tutorial you can follow to learn Azure Data Studio.   
[https://docs.microsoft.com/en-us/sql/azure-data-studio/quickstart-sql-server](https://docs.microsoft.com/en-us/sql/azure-data-studio/quickstart-sql-server)

### Connecting with the SQL Pad Web client

[SQL Pad](https://rickbergfalk.github.io/sqlpad/#/) is a browser-based query tool. You can connect to the SQL Server database and execute any query in the SQL language.

1. Open a web browser and connect to:   
[http://localhost:5002](http://localhost:5002) to launch the SQL Pad web application.
2. Click on **Connections**
3. Click **Add Connection**
4. Enter a connection name and choose `SQL Server` for the driver. Enter the connection information from the Database Provisioner application. 

### Connecting with the Adminer Web Client

[Adminer](https://www.adminer.org/) is a browser-based database admin tool. You can create database objects and edit data without using the SQL language. 

1. Open a web browser and connect to:  
[http://localhost:5003](http://localhost:5003) to launch the Adminer web application.
2. From the login screen, choose `MS SQL` as the system and then enter the connection information from the Database Provisioner application.


## More Docker Advice: Stopping the containers

When you are finished using the database, you might want to stop the docker containers to save the CPU and Memory resources on your host computer. The containers will remain up, even between reboots, until you tell docker to stop them.

To stop all containers, type: `docker-compose down`.

If you want to just stop one of the containers  you can use the `stop` option. For example to stop the Adminer service container, type:  
`docker-compose stop adminer`

To start an individual service, you can use the `start` option:  
`docker-compose start sqlpad`  

Or to start all containers, you can use:  
`docker-compose up -d`

## All the resources for IST659 / Applied Database Management

Learn Databases is part of the [Applied Database Management](https://mafudge.github.io/applied-database-management/) family of resoruces for teaching Databases and SQL. This is used in IST659, a graduate level introduction to relational databases and SQL.

- Content: [https://github.com/mafudge/ist659](https://github.com/mafudge/ist659)
- Lab Environment: [https://github.com/mafudge/learn-databases](https://github.com/mafudge/learn-databases)
- Textbook: [https://www.greatriverlearning.com/product-details/1947](https://www.greatriverlearning.com/product-details/1947)
- Videos From Textbook: [https://www.youtube.com/watch?v=96uKeHSQMkg&list=PLyRiRUsTyUXghCQTvsCeMjOCVjIIPsopR](https://www.youtube.com/watch?v=96uKeHSQMkg&list=PLyRiRUsTyUXghCQTvsCeMjOCVjIIPsopR)
- Lecture Videos: [https://www.youtube.com/watch?v=WCNLH9CFN6o&list=PLyRiRUsTyUXjzOociFB7jak16OrpntUZk](https://www.youtube.com/watch?v=WCNLH9CFN6o&list=PLyRiRUsTyUXjzOociFB7jak16OrpntUZk)