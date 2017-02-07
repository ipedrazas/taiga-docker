FROM python:3.4.3-onbuild
MAINTAINER Ivan Pedrazas "ipedrazas@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

COPY docker-settings.py /usr/src/app/taiga-back/settings/local.py
COPY locale.gen /etc/locale.gen
COPY default.locale /etc/default/locale

RUN apt-get update  && apt-get autoremove -y && apt-get install locales -y
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

# RUN (cd /taiga && python manage.py collectstatic --noinput)

WORKDIR /usr/src/app/taiga-back

EXPOSE 8000

# Volume definition in docker-compose.yml instead of here, soon
VOLUME ["/taiga/static","/taiga/media"]


RUN locale -a

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
