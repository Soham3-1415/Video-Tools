#!/bin/bash

read -p "Enter the path to the files: " path
echo "Did you write your path relative to the C:/ drive in windows?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) windowsC="/mnt/c/"; break;;
    No ) exit 1;;
  esac
done

read -p "Enter the Source Folder name: " sourceFolder
if [ -z "$sourceFolder" ]
then echo "Assuming there is no sourceFolder"
else
[ "${sourceFolder:$((${#sourceFolder}-1)):1}" == "/" ] || sourceFolder="$sourceFolder/"
fi
read -p "Enter the Destination Folder name: " destinationFolder
if [ -z "$destinationFolder" ]
then echo "Assuming there is no destinationFolder"
else
[ "${destinationFolder:$((${#destinationFolder}-1)):1}" == "/" ] || destinationFolder="$destinationFolder/"
fi

read -p "Enter the prestring: " prestring
[ -z "$prestring" ] && echo "Assuming there is no prestring."
read -p "Enter the poststring: " poststring
[ -z "$poststring" ] && echo "Assuming there is no poststring."

while [ -z "$startNumber" ]
do
  read -p "Enter the number to start on: " startNumber
done
while [ -z "$endNumber" ]
do
  read -p "Enter the number to end on: " endNumber
done

#Remove audio
cd "$windowsC$path"
for (( i=6; i<=15; i++))
  do
    ffmpeg -i "$sourceFolder$prestring$i$poststring" -vcodec copy -an "$destinationFolder$prestring$i$poststring"
  done
