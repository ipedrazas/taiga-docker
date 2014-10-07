#! /bin/bash


sudo mkdir -p /data/postgresql
sudo mkdir -p /data/rabbitmq


sudo docker run -d --name postgres    -p 5432:5432  -v /data/postgresql:/var/lib/postgresql/data postgres
sudo docker run -d --name taiga-back  -p 8000:8000  --link postgres:postgres taiga/back
sudo docker run -d --name taiga-front -p 80:80 taiga/front


sudo docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createuser -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -d -r -s taiga'"
sudo docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createdb -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -O taiga taiga'";
sudo docker run -it --rm --link postgres:postgres taiga/taiga-back bash regenerate.sh


sudo docker stop taiga-front
sudo docker stop taiga-back
sudo docker stop rabbitmq
sudo docker stop postgres
