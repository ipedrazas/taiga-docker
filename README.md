taiga-docker
============

Docker scripts to run your own  [Taiga](https://Taiga.io/).


External Dependencies:

# Postgresql
    # https://registry.hub.docker.com/_/postgres/
    docker run --name postgres -d postgres

If you want to access the database, run the following container:

    docker run -it --link postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

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
