FROM ubuntu:22.04
WORKDIR /app

# RUN apt-get update 
#     && apt-get install curl gcc libc-dev g++ libffi-dev libxml2 unixodbc-dev mariadb-dev postgresql-dev openssl musl
# RUN curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.5.2.1-1_amd64.apk
# RUN curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.5.2.1-1_amd64.apk
# RUN apk add --allow-untrusted msodbcsql17_17.5.2.1-1_amd64.apk
# RUN apk add --allow-untrusted mssql-tools_17.5.2.1-1_amd64.apk

RUN apt-get update && apt-get install -y curl python3 python3-dev python3-pip 


RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc

RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | tee /etc/apt/sources.list.d/mssql-release.list

RUN  apt-get update

RUN ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev dotnet-sdk-8.0

RUN dotnet tool install -g microsoft.sqlpackage

COPY ./requirements.txt /app/requirements.txt

RUN pip install -r requirements.txt 

ENV FLASK_APP=app.py

COPY *.py /app/

COPY ./templates /app/templates

COPY ./static /app/static

RUN chmod +x -R /app

EXPOSE 8000

ENTRYPOINT [ "python3" ]

#CMD [ "-m",  "flask", "run", "--host=0.0.0.0" , "--port=5000"]
CMD [ "app.py" ]
