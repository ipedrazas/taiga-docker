#! /bin/bash

if [[ $OSTYPE != darwin* ]]; then
  SUDO=sudo
fi

$SUDO docker start postgres
$SUDO docker start taiga-back
$SUDO docker start taiga-front
