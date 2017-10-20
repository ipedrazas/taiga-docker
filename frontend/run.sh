#! /usr/bin/env bash

ESCAPED_BASE_URL=$(echo $BASE_URL | sed -e 's/[\/&]/\\&/g')
sed -i "s/BASE_URL/$ESCAPED_BASE_URL/g" /taiga/conf.json

nginx -g "daemon off;"
