
FROM python:3
MAINTAINER Ivan Pedrazas "ipedrazas@gmail.com"
RUN apt-get -qq update
#RUN apt-get install -y python-dev python-setuptools supervisor git-core
RUN apt-get install -y python-dev python-setuptools git-core
RUN easy_install pip
# RUN pip install uwsgi
# ADD supervisor.conf /opt/supervisor.conf
COPY docker-settings.py /tmp/docker-settings.py
RUN (cd / && git clone https://github.com/taigaio/taiga-back.git taiga)

# docker needs to define the host database, use this file for
# any other settings you want to add/change
RUN (pip install -r /taiga/requirements.txt)
RUN (cd /taiga && cat /tmp/docker-settings.py >> settings/local.py)
RUN (rm /tmp/docker-settings.py)

# RUN (cd /taiga && python manage.py collectstatic --noinput)

WORKDIR /taiga

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

#CMD ["supervisord", "-c", "/opt/supervisor.conf", "-n"]