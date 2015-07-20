#! /usr/bin/env bash


if [[ -d taiga-back ]]; then
    rm -rf taiga-back
fi

# git clone -b stable --single-branch https://github.com/taigaio/taiga-back.git
git clone https://github.com/taigaio/taiga-back.git

sed -i '.bak' 's/^enum34/#enum34/' taiga-back/requirements.txt
cp taiga-back/requirements.txt .

docker build -t ipedrazas/taiga-back .


