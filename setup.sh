#! /bin/bash

if [[ $OSTYPE != darwin* ]]; then
  SUDO=sudo
fi

sudo mkdir -p /data/postgresql

$SUDO docker run -d --name postgres    -p 5432:5432  -v /data/postgresql:/var/lib/postgresql/data postgres
$SUDO docker run -d --name taiga-back  -p 8001:8001  --link postgres:postgres ipedrazas/taiga-back
$SUDO docker run -d --name taiga-front -p 80:80 -p 8000:8000 --link taiga-back:taiga-back ipedrazas/taiga-front


$SUDO docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createuser -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -d -r -s taiga'"
$SUDO docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createdb -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -O taiga taiga'";
$SUDO docker run -it --rm --link postgres:postgres ipedrazas/taiga-back bash regenerate.sh


$SUDO docker stop taiga-front
$SUDO docker stop taiga-back
$SUDO docker stop postgres
