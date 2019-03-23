#!/bin/bash
SEARCH_PATH="/home/amrabdeen/Desktop/Emd_Linux/Final_Project/MP3_Songs"
List="$(find $SEARCH_PATH -iname "*mp3")"
echo $List
echo "######################################"

NO_OF_SONGS="$(ls $SEARCH_PATH | wc -l)"
echo $NO_OF_SONGS
