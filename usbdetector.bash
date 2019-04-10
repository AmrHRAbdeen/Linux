#!/bin/bash 

# this script shall to detect if usb device inserted or ejected 
# if usb device is detected update songs file 
# if usb device ejected update songs file 
# if no device detected or ejected it should not updated songs file 
# the device should update the current known devices in knowndevices file 

numberOfConnectedDevices=0
currentConnectedDevices=0
counter=0

while :
do 
    # rest counter 
    counter=0
    #get number of connected devices : 
    currentConnectedDevices="$(ls /dev/sd*1)"
    #get number of connected devices 
    for device in $currentConnectedDevices 
    do 
        counter=$(( $counter+1 ))
    done 
    echo "current devices : $currentConnectedDevices"
    numberOfCurrentConnectedDevices=$counter
    echo "number of current devices : $counter"
    echo "number of connected devices : $numberOfConnectedDevices"
    #check if number of connected devices is changed : 
    if [ $numberOfConnectedDevices -eq $numberOfCurrentConnectedDevices ]
    then 
       # no usb inserted or ejected so script will not update songs file  
            echo "no device ejected or connected "
    else 
        if [ $numberOfConnectedDevices -gt $numberOfCurrentConnectedDevices ] #the number of conncected devices is changed so : 
            # you should update songs file 
        #check if the usb ejected to inserted 
        if [ $numberOfConnectedDevices -gt $numberOfCurrentConnectedDevices ]
        then 
            # usb device is ejected 
            # so scan and  update songs file  
            find / -iname "*.mp3" > /root/scripts/mp3Files/songs.txt
            echo "one or more devieces ejected "
            #update songs file 
            numberOfConnectedDevices=$numberOfCurrentConnectedDevices
        else 
            #usb device is connected so the script should update songs file 
            echo "one or more devieces inserted "
            # mount devices 
            for device in $currentConnectedDevices 
            do 
                mkdir -p /media/$(basename $device)
                mount $device /media/$(basename $device)
                echo "$device is mounted successfully"
            done 
            #update songs file 
            find / -iname "*.mp3" > /root/scripts/mp3Files/songs.txt
            #get number of songs 
            no_of_songs="$(cat /root/scripts/mp3Files/songs.txt |wc -l)"
            echo "NO of songs is : $no_of_songs"
            # you should write here comand to tell total number of songs
            # update numberofconnecteddevices value
            numberOfConnectedDevices=$numberOfCurrentConnectedDevices
        fi 
    fi 
done


