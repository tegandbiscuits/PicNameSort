#!/bin/bash
VERSION=1.2

changeFile() {
	PIC="$@"
	if ! exiftool "$PIC" -mimetype -S -s | grep -q "image"
	then
		return
	fi
	EXT="${PIC##*.}"
	DATE="`exiftool "$PIC" -d "%Y-%m-%d_%H-%M-%S" -datetimeoriginal -S -s`"
	if [[ $DATE == "" ]]; then
		echo "WARNING: $PIC is falling back to it's modify date"
		DATE="`exiftool "$PIC" -d "%Y-%m-%d_%H-%M-%S" -filemodifydate -S -s`"
	fi
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

showHelp() {
	printf "PicNameSort (v$VERSION) is a utility to change the name of pictures to help organize them\n\n"
	printf "Usage './PicNameSort.sh [path]'\n"
	printf "PicNameSort will work on single files or a directory\n\n"
	printf "\t--update     -     Update PicNameSort.sh if a newer version is on GitHub\n"
	printf "\t--help (-h)  -     Show this help screen\n"
}

BUDIR="pns-backup-`date +"%s"`"

if [ -d "$1" ]; then
	cd "$1"
	mkdir $BUDIR
	find . -maxdepth 1 -type f -not -name ".*" -print0 | while read -r -d '' file; do
		changeFile "$file"
	done
	echo "Finished changing names"
elif [ -e "$1" ]; then
	cd "`dirname "$1"`"
	mkdir $BUDIR
	changeFile `basename "$1"`
	echo "Finished changing names"
elif [[ $1 == "--update" ]]; then
	updatePNS
elif [[ $1 == "--help" ]]; then
	showHelp
elif [[ $1 == "-h" ]]; then
	showHelp
else
	showHelp
fi

