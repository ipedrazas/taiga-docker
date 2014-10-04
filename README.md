# taiga-docker  - NOT READY, YET!


Docker scripts to run your own  [Taiga](https://Taiga.io/).


If you have Docker installed in your machine running Taiga is as easy as running these 2 scripts:

* setup.sh: creates directories to store the data from postgres, redis and rabbitmq, initializes the database, pre-loads objects and docker images.
* run-taiga.sh: once you have run setup.sh succesfully you can run taiga from this script.

These scripts allow you to run Taiga in one single host. The scripts will launch 5 docker containers:


External Dependencies:

   * [PostgreSQL](https://registry.hub.docker.com/_/postgres/)
   * [Redis](https://registry.hub.docker.com/u/dockerfile/redis/)
   * [RabbitMQ](https://registry.hub.docker.com/u/dockerfile/rabbitmq/)

Taiga

   * [taiga-back](https://github.com/taigaio/taiga-back): Django backend
   * [taiga-front](https://github.com/taigaio/taiga-front): Angular.js frontend

### Postgresql

We run a container based on the original image provided by [PostgreSQL](https://registry.hub.docker.com/_/postgres/)

    docker run --name postgres -v /data/postgresql:/var/lib/postgresql/data -d -p 5432:5432 postgres

To initialise the database

    docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createuser -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -d -r -s taiga'"

    docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createdb -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -O taiga taiga'";

If you want to access the database, run the following container:

    docker run -it --link postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

Once you are in psql you can check that indeed our user & database has been created:

    # To list the users defined in our system use the following command
    \du
    # To list the databases, the command is
    \list


### RabbitMQ

    # https://github.com/dockerfile/rabbitmq

    docker run -d -p 5672:5672 -p 15672:15672 -v /data/rabbitmq:/data/log -v /data/rabbitmq:/data/mnesia --name rabbitmq  dockerfile/rabbitmq

### Redis
    # https://github.com/dockerfile/redis

    docker run -d -p 6379:6379 -v /data/redis:/data --name redis dockerfile/redis

### Taiga-Back

Before running our backend, we have to populate our database, to do so, Taiga provides a regenerate script that creates all the tables and even some testing data

    docker run -it --rm --link postgres:postgres taiga/taiga-back bash regenerate.sh

Once the database has been populated, we can start our Django application:

    docker run -d -p 8000:8000 --link postgres:postgres --link redis:redis --link rabbitmq:rabbitmq taiga/taiga-back


### Taiga-Front

Frontend is slightly different because we don't have a production ready system, but the source. This means that before running our instance, we have to build it.

We have two options here: to ask politely to taiga to provide an already built version (\o/) or building and intermediate container that will pull the source from github, compile it and build our new image.