#!/bin/bash

osacompile -o PicNameSort.app PicNameSort.applescript 

cp PicNameDate.sh PicNameSort.app/Contents/Resources/Scripts/PicNameSort.sh
echo "Updated PicNameSort version with app"
