#!/bin/bash
#set -e
#set -x
COMP=$1
DEST=$2


DEST_PATH=`echo "$DEST" | rev | cut -sd "/" -f2- | rev`
DEST_FILE=`echo "$DEST" | rev | cut -d "/" -f1 | rev`

COMP_PATH=`echo "$COMP" | rev | cut -sd "/" -f2- | rev`
COMP_FILE=`echo "$COMP" | rev | cut -d "/" -f1 | rev`

echo Source $COMP_PATH @ $COMP_FILE
echo Dest $DEST_PATH @ $DEST_FILE

print="components"
if [ -e app/templates/$print/$COMP.hbs ]
then
	mkdir -p app/$print/$DEST_PATH
	mkdir -p app/templates/$print/$DEST_PATH

	mv app/$print/$COMP.js app/$print/$DEST_PATH/$DEST_FILE.js
	mv app/templates/$print/$COMP.hbs app/templates/$print/$DEST_PATH/$DEST_FILE.hbs

	_COMP="${COMP//\//\\/}"
	_DEST="${DEST//\//\\/}"

	sed -i "s/{{\(\W*\)\($_COMP\)\(\s*\(.*\)\)}}/{{\1$_DEST\3}}/g" $(find app/templates -name "*.hbs")
else
	echo "Le fichier $COMP n'existe pas" 1>&2
fi
