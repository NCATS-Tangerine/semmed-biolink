#!/usr/bin/env bash

if [[  -z ${SEMMEDDB_PREDICATION_DOWNLOAD} ]]; then
     echo 'Run the setup_environment.sh script before attempting to run this script!';
     exit 0;
fi

echo Downloading ${SEMMEDDB_PREDICATION_DOWNLOAD}

# Downloading attempted here!
wget -N ${SEMMEDDB_PREDICATION_DOWNLOAD}

# prepend colnames
cp col_names.txt ${SEMMEDDB_PREDICATION_CSV}

# convert mysqldump to csv
zcat ${SEMMEDDB_PREDICATION_ARCHIVE}| python3 mysqldump_to_csv.py >> ${SEMMEDDB_PREDICATION_CSV}


# download umls metathesaurus files
wget -N "https://download.nlm.nih.gov/umls/kss/2018AA/umls-2018AA-full.zip"
# I then manually unzipped this file, then extracted the contained files, then put all of the RRF files in one folder ("2018AA-full")

# then ran the following in the umls folder
# zcat MRCONSO.RRF.a* | gzip > MRCONSO.RRF.gz && rm MRCONSO.RRF.a*
# zcat MRSAT.RRF.a* | gzip > MRSAT.RRF.gz && rm MRSAT.RRF.a*
# zcat MRCONSO.RRF.gz| grep -F "|ENG|" | gzip > rm MRCONSO_ENG.RRF.gz

# download unii fda data and unzip
wget -N "http://fdasis.nlm.nih.gov/srs/download/srs/UNII_Data.zip"
