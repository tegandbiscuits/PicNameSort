#!/bin/bash

osacompile -o PicNameDate.app PicNameDate.applescript 

cp PicNameDate.sh PicNameDate.app/Contents/Resources/Scripts/PicNameDate.sh
echo "Updated PicNameSort version with app"
