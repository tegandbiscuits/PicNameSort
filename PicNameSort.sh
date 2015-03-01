#!/bin/bash
VERSION=0.6

changeFile() {
	PIC="$@"
	if ! exiftool "$PIC" -mimetype -S -s | grep -q "image"
	then
		return
	fi
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
	echo "$NEWNAME:" >> Picture-Descriptions.txt
}

updatePNS() {
	CURVER=$VERSION
	eval `curl --silent https://raw.githubusercontent.com/NRauh/PicNameSort/master/PicNameSort.sh | sed '2!d'`
	if [[ $CURVER < $VERSION ]]; then
		echo "Updating from $CURVER to $VERSION"
		curl --silent https://raw.githubusercontent.com/NRauh/PicNameSort/master/PicNameSort.sh -o new.sh
		chmod 774 new.sh
		mv new.sh PicNameSort.sh
	elif [[ $CURVER == $VERSION ]]; then
		echo "This version is current"
	fi
}

BUDIR="pns-backup-`date +"%s"`"

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
elif [[ $1 == "--update" ]]; then
	updatePNS
else
	echo "PicNameSort is a utility to change the name of pictures to help organize them"
	echo "Usage './PicNameSort.sh [path]'"
	echo "PicNameSort will work on single files or a directory"
fi

