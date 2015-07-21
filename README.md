# taiga-docker


Docker scripts to run your own  [Taiga](https://Taiga.io/).



Running Taiga is as easy as running these 3 scripts:

* install-docker.sh: install docker (Ubuntu only). `skip this step if you have Docker installed in your machine`
* setup.sh: creates directories to store the data from postgres, redis and rabbitmq, initializes the database, pre-loads objects and docker images.
* run-taiga.sh: once you have run setup.sh succesfully you can run taiga from this script.

These scripts allow you to run Taiga in one single host. The scripts will launch 5 docker containers:


External Dependencies:

   * [PostgreSQL](https://registry.hub.docker.com/_/postgres/)
   * [Redis](https://registry.hub.docker.com/_/redis/)
   * [RabbitMQ](https://registry.hub.docker.com/_/rabbitmq/)

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

Once you are in psql you can check that indeed our user & database have been created:

    # To list the users defined in our system use the following command
    \du
    # To list the databases, the command is
    \list


### RabbitMQ

    # https://github.com/dockerfile/rabbitmq

    docker run -d -p 5672:5672 -p 15672:15672 -v /data/rabbitmq:/data/log -v /data/rabbitmq:/data/mnesia --name rabbitmq  rabbitmq

### Redis
    # https://github.com/dockerfile/redis

    docker run -d -p 6379:6379 -v /data/redis:/data --name redis redis

### Taiga-Back

Before running our backend, we have to populate our database, to do so, Taiga provides a regenerate script that creates all the tables and even some testing data

    docker run -it --rm --link postgres:postgres ipedrazas/taiga-back bash regenerate.sh

Once the database has been populated, we can start our Django application:

    docker run -d -p 8000:8000 --name taiga-back --link postgres:postgres --link redis:redis --link rabbitmq:rabbitmq ipedrazas/taiga-back


### Taiga-Front


Finally, we run the frontend

        docker run -d -p 80:80 --link taiga-back:taiga-back ipedrazas/taiga-front


#### Note for OSX + boot2docker Users

Since boot2docker actually runs the docker commands in a virtual machine you must omit the leading 'sudo' from those of the above commands that use it.


Once you've successfully run run-taiga.sh start a web browser and point it to http://localhost:80. You should be greeted by a login page. The administrators username is `admin`, and the password is `123123`.
