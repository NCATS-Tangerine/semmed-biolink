#!/usr/bin/env bash

echo "Downloading and pre-processing SemMedDb"

#
# SemMedDb 2019 data release values in original Greg Stupp script
#
# SEMEDDB_DOWNLOAD_PATH=https://skr3.nlm.nih.gov/SemMedDB/download/
# SEMEDDB_VERSION=31
# SEMEDDB_PUBMED_VERSION=to12312017
#
# SemMedDb 2020 data release values in June 2020 script
#
SEMEDDB_DOWNLOAD_PATH=https://ii.nlm.nih.gov/SemRep_SemMedDB_SKR/SemMedDB/download/
SEMEDDB_VERSION=42
SEMEDDB_PUBMED_VERSION=2020

SEMMEDB_FILE_PREFIX=semmedVER${SEMEDDB_VERSION}

# Data file targets:

# SemMedDb 2019 data release file name in original Greg Stupp script
# SEMMEDDB_PREDICATION_FILE=${SEMMEDB_FILE_PREFIX}_R_PREDICATION_${SEMEDDB_PUBMED_VERSION}

# Slightly revised file name format in SemMedDb 2020 data release
SEMMEDDB_PREDICATION_FILE=${SEMMEDB_FILE_PREFIX}_${SEMEDDB_PUBMED_VERSION}_R_PREDICATION

# Data Targets:
SEMMEDDB_PREDICATION_ARCHIVE=${SEMMEDDB_PREDICATION_FILE}.sql.gz
SEMMEDDB_PREDICATION_DOWNLOAD=${SEMEDDB_DOWNLOAD_PATH}${SEMMEDDB_PREDICATION_ARCHIVE}
SEMMEDDB_PREDICATION_CSV=${SEMMEDDB_PREDICATION_FILE}.csv

echo
echo "SemMedDb Predication File Variables":
echo
echo Archive Name:  ${SEMMEDDB_PREDICATION_ARCHIVE}
echo Download Path: ${SEMMEDDB_PREDICATION_DOWNLOAD}
echo CSV File Name: ${SEMMEDDB_PREDICATION_CSV}

echo
echo See the available variables in the shell script to override these values.
echo
read -p 'Continue? (y/n): ' RUNSCRIPT

if [[ ${RUNSCRIPT} != 'y' ]]; then echo 'See you later... Goodbye!'; exit 0; fi

echo Downloading ${SEMMEDDB_PREDICATION_ARCHIVE} from ${SEMEDDB_DOWNLOAD_PATH}