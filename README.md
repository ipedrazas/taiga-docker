[![Stories in Ready](https://badge.waffle.io/ipedrazas/taiga-docker.png?label=ready&title=Ready)](https://waffle.io/ipedrazas/taiga-docker)
# taiga-docker

Docker scripts to run your own  [Taiga](https://Taiga.io/).


External Dependencies:

   * [PostgreSQL](https://registry.hub.docker.com/_/postgres/)

Taiga

   * [taiga-back](https://github.com/taigaio/taiga-back): Django backend
   * [taiga-front](https://github.com/taigaio/taiga-front): Angular.js frontend


By far the easiest way of setting up Taiga in Docker is by running the `setup.sh` script. So, if you just want to run it and you just don't care about what happens underneath, just run that script.

There's a catch. The API url has to be specified. Taiga frontend is javascript, so, we have to inject the value of the hostname where taiga-back runs. We can do that by defining an environment variable

        export API_NAME=boot2docker

For example, it will make the requests to `http://boot2docker:8000/api/v1/...` If you don't define this variable the script will assume it's `localhost` (if you're using `boot2docker` it will not work).

If you want to run the frontend manually, this is the command:

        docker run -d --name taiga-front -p 80:80 -e API_NAME=$API_NAME --link taiga-back:taiga-back ipedrazas/taiga-front


Once you've successfully installed Taiga start a web browser and point it to `http://localhost` or `http://boot2docker`. You should be greeted by a login page. The administrators username is `admin`, and the password is `123123`.

If you cannot authenticate, probably is that the API_NAME has not been set properly.

There is another script `run.sh` that you can use to start your taiga containers once the installation has been succesful. You don't have to run it after the setup, just after stopping the containers.

### Postgresql

We run a container based on the original image provided by [PostgreSQL](https://registry.hub.docker.com/_/postgres/)

    docker run -d --name postgres  postgres

**Note about Volumes**

If you try to mount volumes in OSX using `boot2docker` you will see that it does not work. This is known problem and it only affects OSX. There's a solution though. You might want to extend the postgres docker image and add this line:

`RUN usermod -u 1000 postgres`

This change will fix the permission problem when mounting a volume.

**To initialise the database**

    docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createuser -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -d -r -s taiga'"

    docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createdb -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -O taiga taiga'";

If you want to access the database, run the following container:

    docker run -it --link postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

Once you are in psql you can check that indeed our user & database have been created:

    # To list the users defined in our system use the following command
    \du
    # To list the databases, the command is
    \list


### Taiga-Back

Before running our backend, we have to populate our database, to do so, Taiga provides a regenerate script that creates all the tables and even some testing data

    # pull the image
    docker pull ipedrazas/taiga-back

    # regenerate tables
    docker run -it --rm --link postgres:postgres ipedrazas/taiga-back bash regenerate.sh

Once the database has been populated, we can start our Django application:

    docker run -d -p 8000:8000 --name taiga-back --link postgres:postgres ipedrazas/taiga-back


### Taiga-Front


Finally, we run the frontend

        # pull the image
        docker pull ipedrazas/taiga-front

        # run the frontend
        docker run -d -p 80:80 --link taiga-back:taiga-back --volumes-from taiga-back ipedrazas/taiga-front


The frontend needs to know the URL of the backend. Those settings are specified in the `frontend/conf.json` file. You can modify them and re-add them into the image by using a volume

        docker run -d -p 80:80 --link taiga-back:taiga-back -v "$(pwd)"/frontend/conf.json:/taiga/js/conf.json:ro ipedrazas/taiga-front


## What's next?

The docker compose file needs some love and care but the next is to add RabbitMQ and the Taiga events plugged in.
