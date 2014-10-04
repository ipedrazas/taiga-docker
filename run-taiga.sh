#! /bin/bash

sudo docker postgres stop
sudo docker stop rabbitmq
sudo docker stop redis
sudo docker start taiga-back