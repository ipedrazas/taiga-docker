Docker taiga-back
=================


This Docker image uses the official Python 3 image (`FROM python:3`).

The build file installs all the dependencies, adds the code from GitHub and configures `Supervisor` with `wsgi`. It does not initialize the application or the database.

If you want to initialise the app, you have to run the following command:

        sudo docker run -it --rm taiga/taiga-back -c 'regenerate.sh'

If you want to check that the database is created and everything is configured as expected:

        docker run -it --link postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

Once you are in psql you can check that indeed our user & database have been created:

    # To list the users defined in our system use the following command
    \du
    # To list the databases, the command is
    \list
    # Now we connect to the taiga database
    \c taiga
    # and list tables
    \dt

And hopefully, our tables will be there :)

The `build` process creates the static elements of the application, to collect them you should execute this command:

        sudo docker run -it --rm  -v /data/taiga/dist:/static taiga/taiga-back sh -c 'mv /taiga/static /static/'


Once everything is ready you can run the Django app with this command:

        docker run -d -p 8000:8000 --link postgres:postgres --link redis:redis --link rabbitmq:rabbitmq taiga/taiga-back


Note for OSX + boot2docker Users
--------------------------------

Since boot2docker actually runs the docker commands in a virtual machine you must omit the leading 'sudo' from those of the above commands that use it.
