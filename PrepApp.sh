#!/bin/bash

osacompile -o PicNameSort.app PicNameSort.applescript 

cp PicNameSort.sh PicNameSort.app/Contents/Resources/Scripts/PicNameSort.sh
chmod 774 PicNameSort.app/Contents/REsources/Scripts/PicNameSort.sh
echo "Updated PicNameSort version with app"
