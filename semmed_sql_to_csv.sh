#!/usr/bin/env bash

GUNZIP="/usr/bin/env gunzip"
SOURCE=
TARGET=
DATA_PATH=./data/

echo
echo "Converting Semantic Medline Database SQL to CSV..."
echo
PS3='Please enter your choice of table to convert: '
options=("Predication" "Citations" "Predication Aux" "Sentence" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Predication")
            echo
            echo "Predication Data"
            SOURCE=${SEMMEDDB_PREDICATION_ARCHIVE}
            TARGET=${SEMMEDDB_PREDICATION_CSV}
            # prepend table column names
            cp predication_table_col_names_2020.txt ${TARGET}
            break
            ;;
        "Citations")
            echo
            echo "Citations Auxiliary Data"
            SOURCE=${SEMMEDDB_CITATIONS_ARCHIVE}
            TARGET=${SEMMEDDB_CITATIONS_CSV}
            # prepend table column names
            cp citations_table_col_names_2020.txt ${TARGET}
            break
            ;;
         "Predication Aux")
            echo
            echo "Predication Auxiliary Data"
            SOURCE=${SEMMEDDB_PREDICATION_AUX_ARCHIVE}
            TARGET=${SEMMEDDB_PREDICATION_AUX_CSV}
            # prepend table column names
            cp predication_aux_table_col_names_2020.txt ${TARGET}
            break
            ;;
        "Sentence")
            echo
            echo "Sentence Data"
            SOURCE=${SEMMEDDB_SENTENCE_ARCHIVE}
            TARGET=${SEMMEDDB_SENTENCE_CSV}
            # prepend table column names
            cp sentence_table_col_names_2020.txt ${TARGET}
            break
             ;;
        "Quit")
            exit 0
            ;;
        *) echo "invalid option $opt";;
    esac
done

echo

if [[  -z ${TARGET} ]]; then
     echo 'Target file path not yet specified: execute the "setup_environment.sh" script before running this script!'
     exit 0
fi

echo "Converting '${SOURCE}' to '${TARGET}' in folder '${DATA_PATH}'"
echo

echo "Do you wish to continue with this conversion?"
echo
PS3='Please choose (1 or 2): '
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            echo;
            echo "${GUNZIP} -c ${DATA_PATH}${SOURCE} | python3 mysqldump_to_csv.py >> ${DATA_PATH}${TARGET}"
            break;;
        No )
            echo
            echo "OK... I abort the conversion... come again soon!"
            exit 0;;
        *) echo "Please select option 1 (Yes) or 2 (No)";;
    esac
done

echo
echo "Processing completed!"