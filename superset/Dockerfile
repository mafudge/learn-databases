FROM amancevice/superset:latest

USER root

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update 

RUN env ACCEPT_EULA=Y apt-get install -y msodbcsql17

RUN env ACCEPT_EULA=Y apt-get install -y mssql-tools

RUN apt-get install -y unixodbc-dev

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc 

RUN pip install mssql pyodbc pyhive

#RUN /usr/local/bin/superset-init --username admin --password SU2orange! --firstname admin --lastname admin --email admin@admin.org
