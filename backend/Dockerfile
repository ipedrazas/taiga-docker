
FROM python:3
MAINTAINER Ivan Pedrazas "ipedrazas@gmail.com"
RUN apt-get -qq update
RUN apt-get install -y python-dev python-setuptools supervisor git-core
RUN easy_install pip
RUN pip install uwsgi
ADD supervisor.conf /opt/supervisor.conf
RUN (cd / && git clone https://github.com/taigaio/taiga-back.git taiga)
RUN (pip install -r /taiga/requirements.txt)

EXPOSE 8000
CMD ["supervisord", "-c", "/opt/supervisor.conf", "-n"]