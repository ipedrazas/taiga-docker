Docker taiga-back
=================


This Docker image uses the official Python 3 image (`FROM python:3`).

The build file install all the dependencies, add the code from github and configure `Supervisor` with `wsgi`. It does not initializes the application nor the database.

If you want to initialise the app, you have to run the following command:

        sudo docker -it --rm taiga/taiga-back -c 'regenerate.sh'

If you want to check that the image is configured as you wanted, run bash from the image

        sudo docker run -it --rm --link postgres:postgres taiga/taiga-back bash


Once everything is you can run the Django App with this command:

        docker run -d -p 8000:8000 --link postgres:postgres --link redis:redis --link rabbitmq:rabbitmq taiga/taiga-back