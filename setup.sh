#! /bin/bash


sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update -y
sudo apt-get install -y lxc-docker

sudo mkdir -p /data/postgresql

sudo docker run -d --name postgres    -p 5432:5432  -v /data/postgresql:/var/lib/postgresql/data postgres
sudo docker run -d --name taiga-back  -p 8001:8001  --link postgres:postgres ipedrazas/taiga-back
sudo docker run -d --name taiga-front -p 80:80 -p 8000:8000 --link taiga-back:taiga-back ipedrazas/taiga-front


sudo docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createuser -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -d -r -s taiga'"
sudo docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createdb -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -O taiga taiga'";
sudo docker run -it --rm --link postgres:postgres ipedrazas/taiga-back bash regenerate.sh


sudo docker stop taiga-front
sudo docker stop taiga-back
sudo docker stop postgres
