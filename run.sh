#! /usr/bin/env 0bash

if [[ $OSTYPE != darwin* ]]; then
  SUDO=sudo
fi

$SUDO docker stop taiga-front
$SUDO docker stop taiga-back
$SUDO docker stop postgres
