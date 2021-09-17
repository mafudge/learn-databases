#!/bin/bash
SAPW=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)
docker-compose -f docker-compose-aws.yaml up -d
echo  "SQL Server sa password is ${SAPW}"
