FROM python:3.4.3-onbuild
MAINTAINER Ivan Pedrazas "ipedrazas@gmail.com"

ADD taiga-back /taiga

COPY docker-settings.py /taiga/settings/local.py
#COPY regenerate.sh /taiga/regenerate.sh

RUN apt-get update && apt-get install locales -y
RUN echo "LANG=en_US.UTF-8" > /etc/default/locale
RUN echo "LC_MESSAGES=POSIX" >> /etc/default/locale
RUN echo "LANGUAGE=en" >> /etc/default/locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN (cd /taiga && python manage.py collectstatic --noinput)

VOLUME ["/taiga"]

WORKDIR /taiga

EXPOSE 8001

CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]
