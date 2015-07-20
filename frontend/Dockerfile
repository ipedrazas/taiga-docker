##############################################################
##
##
##  Taiga-front
##
##
###############################################################

FROM nginx

COPY taiga-front-dist/dist /taiga
COPY nginx.conf /etc/nginx/nginx.conf
COPY taiga.conf /etc/nginx/conf.d/default.conf

RUN chmod -R 755 /taiga
