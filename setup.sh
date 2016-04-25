#! /usr/bin/env bash

if [[ -z "$API_NAME" ]]; then
    API_NAME="localhost";
fi

echo API_NAME: $API_NAME

mkdir -p /data/postgres

#docker pull ipedrazas/taiga-back
#docker pull ipedrazas/taiga-front


docker run -d --name postgres  -v /data/postgres:/var/lib/postgresql/data postgres
# postgres needs some time to startup
sleep 5
docker run -d --name taiga-back  -p 8000:8000 -e API_NAME=$API_NAME  --link postgres:postgres ipedrazas/taiga-back
docker run -d --name taiga-front -p 80:80 -e API_NAME=$API_NAME --link taiga-back:taiga-back --volumes-from taiga-back ipedrazas/taiga-front

docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createuser -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -d -r -s taiga'"
docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createdb -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -O taiga taiga'";
docker run -it --rm --link postgres:postgres ipedrazas/taiga-back bash regenerate.sh







