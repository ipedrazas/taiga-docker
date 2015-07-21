#! /bin/bash

if [[ $OSTYPE != darwin* ]]; then
  SUDO=sudo
fi

if [[ -d  taiga-front-dist ]]; then
    rm -rf taiga-front-dist
fi

git clone https://github.com/taigaio/taiga-front-dist

$SUDO docker build -t ipedrazas/taiga-front .

if [[ -d  taiga-front-dist ]]; then
    rm -rf taiga-front-dist
fi
