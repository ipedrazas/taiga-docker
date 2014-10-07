##############################################################
##
##
##  Taiga-front
##
##
###############################################################

FROM nginx

COPY build/taiga/dist /usr/local/nginx/html
COPY build/taiga/static /usr/local/nginx/html/static

RUN echo "alias ll='ls -atrhlF'" >> ~/.bashrc
COPY taiga.conf /etc/nginx/sites-available/default
