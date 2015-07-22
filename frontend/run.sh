#! /usr/bin/env bash

sed -i "s/API_SERVER/$API_NAME/g" /taiga/js/conf.json

nginx -g "daemon off;"
