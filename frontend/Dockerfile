##############################################################
##
##
##  Taiga-front
##
##
###############################################################

FROM debian:wheezy

MAINTAINER NGINX Docker Maintainers "docker-maint@nginx.com"

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.7.6-1~wheezy

RUN apt-get update && apt-get install -y nginx=${NGINX_VERSION}

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/usr/share/nginx/html"]
VOLUME ["/etc/nginx"]
VOLUME ["/var/log/nginx"]

RUN echo "alias ll='ls -atrhlF'" >> ~/.bashrc

COPY build/taiga/dist /usr/local/nginx/html
COPY build/taiga/static /usr/local/nginx/html
#COPY nginx.conf /etc/nginx/nginx.conf
COPY taiga.conf /etc/nginx/conf.d/default.conf

ENV PATH /usr/local/nginx/sbin:$PATH
WORKDIR /usr/local/nginx/html

EXPOSE 80 8000

CMD ["nginx", "-g", "daemon off;"]