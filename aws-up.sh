#!/bin/bash
FILE=.sapasswd
if test -f "${FILE}"; then
    echo "Getting SA Password"
    export SAPW=$(cat ${FILE})
else 
    echo "Creating SA Password"
    export SAPW=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c20)
    echo  $SAPW > $FILE
fi
docker-compose -f docker-compose-aws.yaml up -d
echo  "SQL Server sa password is ${SAPW}"
