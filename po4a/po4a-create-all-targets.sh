#!/bin/bash
# SOURCE: https://github.com/jamulussoftware/jamuluswebsite/blob/release/_po4a-tools/po4a-create-all-targets.sh

# This script creates the target translations from the .po files
# po4a >= 0.63 is required, see https://github.com/mquinson/po4a/releases
# You can set the following variables:
# SRC_DIR: directory for the original documents in English. Files in sub-directories within SRC_DIR are also detected.
# PO_DIR: directory where the .po files are stored
#  BUILD_DIR: directory to publish the translated files in
# THRESH_VAL: translation % below which translated documents are not generated

# Sometimes the script needs help to establish where it is in the file system
SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$SCRIPT_DIR"

# VARIABLES

# Set % threshold for translated .md files to be created
THRESH_VAL=0

# Folder where source English files are
SRC_DIR="../src/" # No trailing slash here please

# Directory where the po file folders are
PO_DIR="./_po"

# Directories where the translated files will be
BUILD_DIR="../build"

po4a_conf="doc_po4a.conf"
lang="fr it"

# CHECK FOR PO4A INSTALLATION

# Check if po4a is installed
if ! [ -x "$(command -v po4a)" ] ; then
    echo Error: Please install po4a. v0.63 or higher is required >&2
    exit 1
fi

# Check if the right version is installed
PO4A_VER=$(po4a --version | grep po4a | awk '{print $3}')

if [[ $PO4A_VER < 0.63 ]] ; then
    echo Error: po4a v"$PO4A_VER" is installed >&2
    echo po4a v0.63 or higher is required. >&2
    exit 1
fi

# Check if source document folder exists in the right place
if ! [ -d "$SRC_DIR" ] ; then
    echo Error: Please make sure the source English file directory exists. >&2
    exit 1
fi

echo "Clean all po4a"
# Suppress old po4a config files
find "${PO_DIR}" -name "*.${po4a_conf}" -exec rm "{}" \;

# Generate the header of the config file

echo "
# po4a - Rocky Linux Documentation
#
# This file is auto-generated, don't modify it!
#
# variables
#
# \$master corresponds to the file name ex: index.md
# \$lang matches the localizations set in [po4a_langs]
#
# Localizations to be processed
[po4a_langs] ${lang}

# Path of files where to locate .pot and .po
[po4a_paths] ${PO_DIR}/\$master.pot \$lang:${PO_DIR}/\$lang/\$master.po
# Options to pass to po4a
[po4a_alias: md] text opt:\"-o markdown -o yfm_keys=title,contributors -o neverwrap \"
[options] --master-charset UTF-8 --localized-charset UTF-8

" > "${po4a_conf}"


echo "Search for md files"
# RUN PO4A ON EACH MD FILE FROM SRC_DIR
for file_path in $(find "$SRC_DIR" -name "*.md")
do
    echo "Working with ${file_path}"
    # Get directory and file name
    fulldir=$(dirname "$file_path")
    absolutedir=${fulldir#"${SRC_DIR}"}
    dir=${absolutedir#"/"}
    file=$(basename "$file_path" ".md")
    master=$(basename ${dir})
    echo "Master is : ${master}"
    echo "[type: md] $file_path \$lang:${BUILD_DIR}/${dir}/${file}.\$lang.md master:file=${master}_${file}" >> "${po4a_conf}"

done 

cat "${po4a_conf}"
# Path to final Markdown file - source -> translation
echo "Launching po4a"

mkdir -p "${PO_DIR}"
po4a -v -k 0 "${po4a_conf}"

# Produce a file with translation status of all .po files
source ./po4a-stats.sh

