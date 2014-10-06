##############################################################
##
##
##  Taiga-front
##
##
###############################################################


FROM ruby:2.1.2

MAINTAINER Ivan Pedrazas <ivan@pedrazas.me>

RUN apt-get update -y && apt-get install --no-install-recommends -y -q  nodejs npm



RUN (gem install sass scss-lint)
RUN (npm install -g gulp bower)
RUN (ln -s /usr/bin/nodejs /usr/bin/node)

RUN (cd / && git clone https://github.com/taigaio/taiga-front.git)

RUN (cd /taiga-front && npm install)
RUN (cd /taiga-front && bower install --allow-root)
RUN (cd /taiga-front && gulp deploy)

RUN (echo "alias ll='ls -atrhlF'" >> ~/.bashrc)

VOLUME /taiga

CMD mv /taiga-front/dist /taiga
