#!/usr/bin/env bash

SEMEDDB_DOWNLOAD_PATH=https://skr3.nlm.nih.gov/SemMedDB/download/
SEMEDDB_VERSION=31
SEMMEDB_FILE_PREFIX=semmedVER${SEMEDDB_VERSION}
SEMEDDB_PUBMED_VERSION=to12312017

SEMMEDDB_PREDICATION_FILE=${SEMMEDB_FILE_PREFIX}_R_PREDICATION_${SEMEDDB_PUBMED_VERSION}
SEMMEDDB_PREDICATION_ARCHIVE=${SEMMEDDB_PREDICATION_FILE}.sql.gz
SEMMEDDB_PREDICATION_DOWNLOAD=${SEMEDDB_DOWNLOAD_PATH}${SEMMEDDB_PREDICATION_ARCHIVE}
SEMMEDDB_PREDICATION_CSV=${SEMMEDDB_PREDICATION_FILE}.csv

# https://skr3.nlm.nih.gov/SemMedDB/download/download.html
wget -N ${SEMMEDDB_PREDICATION_DOWNLOAD}

# prepend colnames
cp col_names.txt ${SEMMEDDB_PREDICATION_CSV}

# convert mysqldump to csv
zcat ${SEMMEDDB_PREDICATION_ARCHIVE}| python3 mysqldump_to_csv.py >> ${SEMMEDDB_PREDICATION_CSV}


# download umls metathesarous files
wget -N "https://download.nlm.nih.gov/umls/kss/2018AA/umls-2018AA-full.zip"
# I then manually unzipped this file, then extracted the contained files, then put all of the RRF files in one folder ("2018AA-full")

# then ran the following in the umls folder
# zcat MRCONSO.RRF.a* | gzip > MRCONSO.RRF.gz && rm MRCONSO.RRF.a*
# zcat MRSAT.RRF.a* | gzip > MRSAT.RRF.gz && rm MRSAT.RRF.a*
# zcat MRCONSO.RRF.gz| grep -F "|ENG|" | gzip > rm MRCONSO_ENG.RRF.gz

# download unii fda data and unzip
wget -N "http://fdasis.nlm.nih.gov/srs/download/srs/UNII_Data.zip"
