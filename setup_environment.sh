#!/usr/bin/env bash

if [[ -f ".env" ]]
then
  export $(cat .env | sed 's/#.*//g' | sed '/^[[:space:]]*$/d'  | sed 's/^/export /' |  sed 's/ = /=/' | xargs )
else
  echo "Please copy the template.env file into .env; customize as required, before running this script"
  read
  exit -1
fi

#
# SemMedDb 2020 data release values taken as defaults in June 2020 script
# These variables which can be overridden from the command line or by the .env file
#
: ${SEMEDDB_DOWNLOAD_PATH:=https://ii.nlm.nih.gov/SemRep_SemMedDB_SKR/SemMedDB/download/}
: ${SEMEDDB_VERSION:=42}
: ${SEMEDDB_PUBMED_RELEASE:=2020}

echo
echo "SemMedDb Data Parameters (variables that might be overridden from the command line):"
echo
echo "SEMEDDB_DOWNLOAD_PATH:  ${SEMEDDB_DOWNLOAD_PATH}"
echo "SEMEDDB_VERSION: ${SEMEDDB_VERSION}"
echo "SEMEDDB_PUBMED_RELEASE: ${SEMEDDB_PUBMED_RELEASE}"

# Data file targets:
SEMMEDB_FILE_PREFIX=semmedVER${SEMEDDB_VERSION}
echo "SEMMEDB_FILE_PREFIX: ${SEMMEDB_FILE_PREFIX}"

# SemMedDb 2019 data release file name in original Greg Stupp script
# SEMMEDDB_PREDICATION_FILE=${SEMMEDB_FILE_PREFIX}_R_PREDICATION_${SEMEDDB_PUBMED_RELEASE}
# Slightly revised file name format in SemMedDb 2020 data release

# Predication Table Data Targets:
: ${SEMMEDDB_PREDICATION_FILE:=${SEMMEDB_FILE_PREFIX}_${SEMEDDB_PUBMED_RELEASE}_R_PREDICATION}

export SEMMEDDB_PREDICATION_ARCHIVE=${SEMMEDDB_PREDICATION_FILE}.sql.gz
export SEMMEDDB_PREDICATION_DOWNLOAD=${SEMEDDB_DOWNLOAD_PATH}${SEMMEDDB_PREDICATION_ARCHIVE}
export SEMMEDDB_PREDICATION_CSV=${SEMMEDDB_PREDICATION_FILE}.csv

echo
echo "SemMedDb Predication File Variables (normally not overridden but generated from above SemMedDb parameters):"
echo
echo "SEMMEDDB_PREDICATION_ARCHIVE: ${SEMMEDDB_PREDICATION_ARCHIVE}"
echo "SEMMEDDB_PREDICATION_DOWNLOAD: ${SEMMEDDB_PREDICATION_DOWNLOAD}"
echo "SEMMEDDB_PREDICATION_CSV: ${SEMMEDDB_PREDICATION_CSV}"

# Citation Table Data Targets:
SEMMEDDB_CITATIONS_FILE=${SEMMEDB_FILE_PREFIX}_${SEMEDDB_PUBMED_RELEASE}_R_CITATIONS
export SEMMEDDB_CITATIONS_ARCHIVE=${SEMMEDDB_CITATIONS_FILE}.sql.gz
export SEMMEDDB_CITATIONS_DOWNLOAD=${SEMEDDB_DOWNLOAD_PATH}${SEMMEDDB_CITATIONS_ARCHIVE}
export SEMMEDDB_CITATIONS_CSV=${SEMMEDDB_CITATIONS_FILE}.csv

echo
echo "SemMedDb Citation File Variables (normally not overridden but generated from above SemMedDb parameters):"
echo
echo "SEMMEDDB_CITATIONS_ARCHIVE: ${SEMMEDDB_CITATIONS_ARCHIVE}"
echo "SEMMEDDB_CITATIONS_DOWNLOAD: ${SEMMEDDB_CITATIONS_DOWNLOAD}"
echo "SEMMEDDB_CITATIONS_CSV: ${SEMMEDDB_CITATIONS_CSV}"

# Predication Aux Table Data Targets:
SEMMEDDB_PREDICATION_AUX_FILE=${SEMMEDB_FILE_PREFIX}_${SEMEDDB_PUBMED_RELEASE}_R_PREDICATION_AUX
export SEMMEDDB_PREDICATION_AUX_ARCHIVE=${SEMMEDDB_PREDICATION_AUX_FILE}.sql.gz
export SEMMEDDB_PREDICATION_AUX_DOWNLOAD=${SEMEDDB_DOWNLOAD_PATH}${SEMMEDDB_PREDICATION_AUX_ARCHIVE}
export SEMMEDDB_PREDICATION_AUX_CSV=${SEMMEDDB_PREDICATION_AUX_FILE}.csv

echo
echo "SemMedDb Predication File Variables (normally not overridden but generated from above SemMedDb parameters):"
echo
echo "SEMMEDDB_PREDICATION_AUX_ARCHIVE: ${SEMMEDDB_PREDICATION_AUX_ARCHIVE}"
echo "SEMMEDDB_PREDICATION_AUX_DOWNLOAD: ${SEMMEDDB_PREDICATION_AUX_DOWNLOAD}"
echo "SEMMEDDB_PREDICATION_AUX_CSV: ${SEMMEDDB_PREDICATION_AUX_CSV}"

# Sentence Table Data Targets:
SEMMEDDB_SENTENCE_FILE=${SEMMEDB_FILE_PREFIX}_${SEMEDDB_PUBMED_RELEASE}_R_SENTENCE
export SEMMEDDB_SENTENCE_ARCHIVE=${SEMMEDDB_SENTENCE_FILE}.sql.gz
export SEMMEDDB_SENTENCE_DOWNLOAD=${SEMEDDB_DOWNLOAD_PATH}${SEMMEDDB_SENTENCE_ARCHIVE}
export SEMMEDDB_SENTENCE_CSV=${SEMMEDDB_SENTENCE_FILE}.csv

echo
echo "SemMedDb Predication File Variables (normally not overridden but generated from above SemMedDb parameters):"
echo
echo "SEMMEDDB_SENTENCE_ARCHIVE: ${SEMMEDDB_SENTENCE_ARCHIVE}"
echo "SEMMEDDB_SENTENCE_DOWNLOAD: ${SEMMEDDB_SENTENCE_DOWNLOAD}"
echo "SEMMEDDB_SENTENCE_CSV: ${SEMMEDDB_SENTENCE_CSV}"

#
# Original "classic" release  used https://download.nlm.nih.gov/umls/kss/2018AA/umls-2018AA-full.zip
#
# But we update to the latest UMLS release
#
: ${UMLS_VERSION:="2020AA"}
export UMLS_ARCHIVE="umls-${UMLS_VERSION}-full.zip"
export UMLS_DOWNLOAD="https://download.nlm.nih.gov/umls/kss/${UMLS_VERSION}/${UMLS_ARCHIVE}"

echo
echo "UMLS Metadata version (update to set to latest version, as necessary):"
echo
echo "UMLS_VERSION: ${UMLS_VERSION}"
echo
echo "UMLS Metadata file variables (normally not overridden but generated for above UMLS_VERSION):"
echo
echo "UMLS_ARCHIVE: ${UMLS_ARCHIVE}"
echo "UMLS_DOWNLOAD: ${UMLS_DOWNLOAD}"
echo
echo "METAMAP_VERSION: ${METAMAP_VERSION}"
echo "UNII_VERSION: ${UNII_VERSION}"
echo