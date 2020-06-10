#!/usr/bin/env bash

if [[  -z ${SEMMEDDB_PREDICATION_DOWNLOAD} ]]; then
     echo 'Run the setup_environment.sh script before attempting to run this script!';
     exit 0;
fi

echo Downloading ${SEMMEDDB_PREDICATION_DOWNLOAD}
