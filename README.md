taiga-docker
============

Docker scripts to run your own  [Taiga](https://Taiga.io/).


External Dependencies:

# Postgresql
# https://github.com/orchardup/docker-postgresql
# https://registry.hub.docker.com/u/orchardup/postgresql/

docker run -d -p 5432:5432 -e POSTGRESQL_USER=taiga -e POSTGRESQL_PASS=oe9jaacZLbR9pN -e POSTGRESQL_DB=taiga orchardup/postgresql

# RabbitMQ
# https://registry.hub.docker.com/u/dockerfile/rabbitmq/
# https://github.com/dockerfile/rabbitmq

docker run -d -p 5672:5672 -p 15672:15672 -v /data/rabbitmq:/data/log -v /data/rabbitmq:/data/mnesia dockerfile/rabbitmq

# Redis
# https://registry.hub.docker.com/u/dockerfile/redis/
# https://github.com/dockerfile/redis
docker run -d -p 6379:6379 -v /data/redis:/data --name redis dockerfile/redis
