#!/bin/bash

# Creates a statistics file with information on the translation status of each file for every language.

# Stats file location
STATS_FILE="../build/statistics.md"
echo "" > $STATS_FILE

PO_DIR="./_po/"

# Print yaml front matter and table title/header
echo '---
title: "Statistics"
---
# Current status of website translations

| Document | Translation status |
|----------|--------------------|' >> "$STATS_FILE"

produce_stats () {
# Determine file names
    for file in $(find "${PO_DIR}" -name "*.po")
    do
	echo "Working with ${file}"
	stats=$(msgfmt --statistics "${file}" 2>&1)
        file_path=${file#"${PO_DIR}"}	
        echo "|**${file_path}** | ${stats} |\n" >> "$STATS_FILE"
    done
}

produce_stats

# Remove unwanted messages.mo file created by msgfmt
rm -f *.mo

echo Statistics file created
