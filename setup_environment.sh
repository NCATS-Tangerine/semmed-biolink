#!/usr/bin/env bash

echo "Downloading and pre-processing SemMedDb"

#
# SemMedDb 2019 data release values in original Greg Stupp script
#
# SEMEDDB_DOWNLOAD_PATH=https://skr3.nlm.nih.gov/SemMedDB/download/
# SEMEDDB_VERSION=31
# SEMEDDB_PUBMED_RELEASE=to12312017
#

#
# SemMedDb 2020 data release values taken as defaults in June 2020 script
# These are the only variables which normally might be overridden from the command line
#
${SEMEDDB_DOWNLOAD_PATH:=https://ii.nlm.nih.gov/SemRep_SemMedDB_SKR/SemMedDB/download/}
${SEMEDDB_VERSION:=42}
${SEMEDDB_PUBMED_RELEASE:=2020}

echo
echo "SemMedDb Data Parameters (variables that might be overridden from the command line):"
echo
echo SEMEDDB_DOWNLOAD_PATH:  ${SEMEDDB_DOWNLOAD_PATH}
echo SEMEDDB_VERSION: ${SEMEDDB_VERSION}
echo SEMEDDB_PUBMED_RELEASE: ${SEMEDDB_PUBMED_RELEASE}

# Data file targets:
SEMMEDB_FILE_PREFIX=semmedVER${SEMEDDB_VERSION}

# SemMedDb 2019 data release file name in original Greg Stupp script
# SEMMEDDB_PREDICATION_FILE=${SEMMEDB_FILE_PREFIX}_R_PREDICATION_${SEMEDDB_PUBMED_RELEASE}

# Slightly revised file name format in SemMedDb 2020 data release

SEMMEDDB_PREDICATION_FILE=${SEMMEDB_FILE_PREFIX}_${SEMEDDB_PUBMED_RELEASE}_R_PREDICATION

# Data Targets:
export SEMMEDDB_PREDICATION_ARCHIVE=${SEMMEDDB_PREDICATION_FILE}.sql.gz
export SEMMEDDB_PREDICATION_DOWNLOAD=${SEMEDDB_DOWNLOAD_PATH}${SEMMEDDB_PREDICATION_ARCHIVE}
export SEMMEDDB_PREDICATION_CSV=${SEMMEDDB_PREDICATION_FILE}.csv

echo
echo "SemMedDb Predication File Variables (normally not overridden but generated from above SemMedDb parameters):"
echo
echo Source SEMMEDDB_PREDICATION_DOWNLOAD: ${SEMMEDDB_PREDICATION_DOWNLOAD}
echo Target SEMMEDDB_PREDICATION_CSV: ${SEMMEDDB_PREDICATION_CSV}
