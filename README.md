taiga-docker
============

Docker scripts to run your own  [Taiga](https://Taiga.io/).


External Dependencies:

# Postgresql
    # https://github.com/orchardup/docker-postgresql
    # https://registry.hub.docker.com/u/orchardup/postgresql/

    docker run -d -p 5432:5432 --name postgres orchardup/postgresql

# RabbitMQ
    # https://registry.hub.docker.com/u/dockerfile/rabbitmq/
    # https://github.com/dockerfile/rabbitmq

    docker run -d -p 5672:5672 -p 15672:15672 -v /data/rabbitmq:/data/log -v /data/rabbitmq:/data/mnesia --name rabbitmq  dockerfile/rabbitmq

# Redis
    # https://registry.hub.docker.com/u/dockerfile/redis/
    # https://github.com/dockerfile/redis

    docker run -d -p 6379:6379 -v /data/redis:/data --name redis dockerfile/redis

# Taiga-Back

    docker run -d -p 8000:8000 --link postgres:postgres --link redis:redis --link rabbitmq:rabbitmq taiga/taiga-back
