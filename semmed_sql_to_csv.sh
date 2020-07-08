#!/usr/bin/env bash

SOURCE=
TARGET=

echo
echo "Converting Semantic Medline Database SQL to CSV..."
echo
PS3='Please enter your choice of table to convert: '
options=("Predications" "Predications Aux" "Sentences" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Predications")
            echo
            echo "Predications Data"
            SOURCE=${SEMMEDDB_PREDICATION_ARCHIVE}
            TARGET=${SEMMEDDB_PREDICATION_CSV}
            # prepend table column names
            cp predication_table_col_names_2020.txt ${TARGET}
            break
            ;;
        "Predications Aux")
            echo
            echo "Predications Auxiliary Data"
            SOURCE=${SEMMEDDB_PREDICATION_AUX_ARCHIVE}
            TARGET=${SEMMEDDB_PREDICATION_AUX_CSV}
            # prepend table column names
            cp predication_aux_table_col_names_2020.txt ${TARGET}
            break
            ;;
        "Sentences")
            echo
            echo "Sentences Data"
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

echo "Converting '${SOURCE}' to '${TARGET}'"
echo

echo "Do you wish to continue with this conversion?"
echo
PS3='Please choose (1 or 2): '
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            echo;
            echo "gunzip -c ${SOURCE} | python3 mysqldump_to_csv.py >> ${TARGET}"
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