#!/bin/bash

changeFile() {
	if ! exiftool "$1" -mimetype -S -s | grep -q "image"
	then
		return
	fi
	PIC="$1"
	EXT="${PIC##*.}"
	DATE="`exiftool "$PIC" -d "%Y-%m-%d_%H-%M-%S" -datetimeoriginal -S -s`"
	NEWNAME="${DATE}.${EXT}"

	check() {
		if [ -e "$NEWNAME" ]; then
			NEWNAME="${DATE}_${1}.${EXT}"
			check $(($1+1))
		fi
	}

	check 1
	cp -np "$PIC" "$BUDIR/$PIC"
	mv -nv "$PIC" "$NEWNAME"
	echo "$NEWNAME:" >> Descriptions.txt
}

BUDIR="pnd-backup-`date +"%s"`"

if [ -d "$1" ]; then
	cd $1
	mkdir $BUDIR
	find . -maxdepth 1 -type f -print0 | while read -r -d '' file; do
		changeFile "$file"
	done
	echo "Finished changing names"
elif [ -e "$1" ]; then
	cd `dirname "$1"`
	mkdir $BUDIR
	changeFile `basename "$1"`
	echo "Finished changing names"
else
	echo "PicNameDate is a utility to change the name of pictures to help organize them"
	echo "Usage './PicNameDate.sh [path]'"
	echo "PicNameDate will work on single files or a directory"
	# Will not work with slashes in path
	# Usage PicNameDate.sh path
	# Dropbox names have _1 for some reason
fi

