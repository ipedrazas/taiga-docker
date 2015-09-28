#! /usr/bin/env bash


if [[ -d taiga-back ]]; then
    rm -rf taiga-back
fi

git clone -b stable --single-branch https://github.com/taigaio/taiga-back.git
#git clone https://github.com/taigaio/taiga-back.git

if [[ $OSTYPE != darwin* ]]; then
    sed -i 's/^enum34/#enum34/' taiga-back/requirements.txt
    sed -i -e '/sample_data/s/^/#/' taiga-back/regenerate.sh
    sed -i -e 's/django.db.backends.postgresql_psycopg2/transaction_hooks.backends.postgresql_psycopg2/g' settings/local.py
else
    sed -i '.bak' 's/^enum34/#enum34/' taiga-back/requirements.txt
    sed -i '.bak' '/sample_data/s/^/#/' taiga-back/regenerate.sh
    sed -i 's/django.db.backends.postgresql_psycopg2/transaction_hooks.backends.postgresql_psycopg2/g' settings/local.py
fi

cp taiga-back/requirements.txt .

docker build -t ipedrazas/taiga-back .
