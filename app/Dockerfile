FROM python:alpine3.15

WORKDIR /app

RUN apk update && apk add curl gcc libc-dev g++ libffi-dev libxml2 unixodbc-dev mariadb-dev postgresql-dev openssl musl
RUN curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.5.2.1-1_amd64.apk
RUN curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.5.2.1-1_amd64.apk
RUN apk add --allow-untrusted msodbcsql17_17.5.2.1-1_amd64.apk
RUN apk add --allow-untrusted mssql-tools_17.5.2.1-1_amd64.apk

COPY ./requirements.txt /app/requirements.txt

RUN pip install -r requirements.txt 

ENV FLASK_APP=app.py

COPY ./*.py /app/

RUN chmod +x -R /app

EXPOSE 8000

ENTRYPOINT [ "python" ]

#CMD [ "-m",  "flask", "run", "--host=0.0.0.0" , "--port=5000"]
CMD [ "app.py" ]
