#!/usr/bin/env bash


if [[  -z ${SEMMEDDB_PREDICATION_DOWNLOAD} ]]; then
     echo 'Run the setup_environment.sh script before attempting to run this script!';
     exit 0;
fi

# prepend colnames
cp col_names.txt ${SEMMEDDB_PREDICATION_CSV}

# convert mysqldump to csv
zcat ${SEMMEDDB_PREDICATION_ARCHIVE}| python3 mysqldump_to_csv.py >> ${SEMMEDDB_PREDICATION_CSV}
