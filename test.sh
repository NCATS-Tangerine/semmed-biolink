#!/usr/bin/env bash
if [ -f ".env" ]
then
  export $(cat .env | sed 's/#.*//g' | sed '/^[[:space:]]*$/d'  | sed 's/^/export /' |  sed 's/ = /=/' | xargs )
else
  echo "Please copy the template.env file into .env; customize as required, before running this script"
  read
  exit -1
fi
