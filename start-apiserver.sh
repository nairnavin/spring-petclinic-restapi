#!/bin/bash
set -e
cd /home/ubuntu/spring-petclinic-restapi
if [ -f /home/ubuntu/spring-petclinic-restapi/.env ]; then
  source /home/ubuntu/spring-petclinic-restapi/.env
fi
echo "Received ${DB_IP} and ${DB_PORT}"
./mvnw spring-boot:run
