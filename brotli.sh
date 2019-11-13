#!/usr/bin/env bash
OLDIFS=$IFS
IFS=$'\n'
for FILE in $(find . -type f -iname '*.html' -o -iname '*.css' -o -iname '*.js' -o -iname '*.svg' -o -iname '*.json'); do
    echo -n "Compressing ${FILE}..."
    brotli ${FILE} -f -q 11
    echo "done."
done
IFS=$OLDIFS
