#!/usr/bin/env bash

if [[  -z ${SEMMEDDB_PREDICATION_ARCHIVE} ]]; then
     echo 'Run the setup_environment.sh script before attempting to run this script!';
     exit 0;
fi

# prepend colnames
#
# The latest release has a few (seemingly undocumented?) extra columns: FACT_VALUE,MODE_SCALE,MOD_VALUE
#
cp predication_table_col_names_2020.txt ${SEMMEDDB_PREDICATION_CSV}

# convert mysqldump to csv
gunzip -c ${SEMMEDDB_PREDICATION_ARCHIVE}| python3 mysqldump_to_csv.py >> ${SEMMEDDB_PREDICATION_CSV}
