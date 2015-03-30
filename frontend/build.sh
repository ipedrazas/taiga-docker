#! /bin/bash

if [[ $OSTYPE != darwin* ]]; then
  SUDO=sudo
fi

rm -rf build
mkdir build

cp -r /data/taiga build

$SUDO docker build -t ipedrazas/taiga-front .

rm -rf build
