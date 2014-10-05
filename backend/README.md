Docker taiga-back
=================


This Docker image uses the official Python 3 image (`FROM python:3`).

The build file install all the dependencies, add the code from github and configure `Supervisor` with `wsgi`. It does not initializes the application nor the database.

If you want to initialise the app, you have to run the following command:

        sudo docker run -it --rm taiga/taiga-back -c 'regenerate.sh'

If you want to check that the database is created and everything is configured as expected:

        docker run -it --link postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

Once you are in psql you can check that indeed our user & database has been created:

    # To list the users defined in our system use the following command
    \du
    # To list the databases, the command is
    \list
    # Now we connect to the taiga database
    \c taiga
    # and list tables
    \dt

And hopefully, our tables will be there :)


Once everything is you can run the Django App with this command:

        docker run -d -p 8000:8000 --link postgres:postgres --link redis:redis --link rabbitmq:rabbitmq taiga/taiga-back

