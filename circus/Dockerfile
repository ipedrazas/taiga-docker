##############################################################
##
##
##  Taiga-circus
##
##
###############################################################
FROM python:3
MAINTAINER Ivan Pedrazas "ipedrazas@gmail.com"


RUN pip install circus
RUN mkdir /taiga

COPY rc.local /etc/rc.local
COPY rc.local.circusd /etc/rc.local.circusd
COPY circus.ini /taiga/conf/circus.ini

RUN chmod +x /etc/rc.local
RUN chmod +x /etc/rc.local.circusd

CMD /usr/local/bin/circusd --daemon /taiga/conf/circus.ini