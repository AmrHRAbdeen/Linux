#!/bin/bash 

# this script shall to play songs from lists one after one 
#songsFileTimeStamp = 0 ; 
songsFileTimeStamp="DummyTimeStamp" ; 
numberOfSongs=0           # this var will store number of songs 
songsArray=0              # this array will contain songs 
arrayIndex=0
while : 
do 
    # 1 - check if the content of songs file changed or not 
        #get time stamp of the current file : 
        currentTimeStamp="$(date -r /root/scripts/mp3Files/songs.txt)"
        if [ "$songsFileTimeStamp" != "$currentTimeStamp" ]
        then 
            # the file updated so update the content of array 
            echo "The file updated "
            #get the content of file 
            IFS=$'\n'
            read -d '' -r -a songsArray < /root/scripts/mp3Files/songs.txt
            #update the number of current songs 
            numberOfSongs=${#songsArray[@]}
            #update songsfiletimestamp 
            songsFileTimeStamp=$currentTimeStamp
        else 
            # the file didnot update 
            echo "the file doesnot update  "
        fi 

        echo "No of songs : $numberOfSongs"
        #get the index of next song
        #.index.txt will store the index of current song  
        read arrayIndex < /root/scripts/mp3Files/index.txt
        echo "Array index : $arrayIndex"
        if [ $arrayIndex -eq $numberOfSongs ] || [ $arrayIndex -gt $numberOfSongs ]
        then
            arrayIndex=0
            echo $arrayIndex > /root/scripts/mp3Files/index.txt
        else 
            # call another script to play song[arrayindex]
            # play the song 
            # sleep 10      # call song script here 
            #read the content of specific line 
            /root/scripts/mp3Files/playSong.bash "${songsArray[$arrayIndex]}"
            #here if the song finished and index doesnot changed 
            # in will increase it to play next song 
            read currentIndex < /root/scripts/mp3Files/index.txt
            if [ $currentIndex -eq $arrayIndex ]
            then 
                arrayIndex=$(( $arrayIndex + 1 ))
                if [ $arrayIndex -eq $numberOfSongs ]; then 
                    arrayIndex=0
                fi
                echo $arrayIndex > /root/scripts/mp3Files/index.txt
            fi 
        fi
    # pass song name to play song script 
    	# sleep 5
done 
