#!/bin/sh

button_state=0
pid=0
play_buttons()
{
	in1=$1
	in2=$2
	in3=$3
	in4=$4

#PINS CONFIGS:-
#########################################################
	#Config pause-play button as input
	if [ ! -d /sys/class/gpio/gpio$in1 ] ; then
		echo "$in1" > /sys/class/gpio/export
		echo "in" > /sys/class/gpio/gpio$in1/direction
	fi
###########################################################
		#Config next button as input
	if [ ! -d /sys/class/gpio/gpio$in2 ] ; then
		echo "$in2" > /sys/class/gpio/export
		echo "in" > /sys/class/gpio/gpio$in2/direction
	fi
###########################################################
		#Config previous button as input
	if [ ! -d /sys/class/gpio/gpio$in3 ] ; then
		echo "$in3" > /sys/class/gpio/export
		echo "in" > /sys/class/gpio/gpio$in3/direction
	fi
###########################################################
		#Config shuffle button as input
	if [ ! -d /sys/class/gpio/gpio$in4 ] ; then
		echo "$in4" > /sys/class/gpio/export
		echo "in" > /sys/class/gpio/gpio$in4/direction
	fi
############################################################

### UPDATE to USB storage devices########
SEARCH_PATH="/MP3_Songs"
#########################################


#Store all .mps songs in a list
List="$(find $SEARCH_PATH -iname "*mp3")"
# Count Songs/Lines
NO_OF_SONGS="$(ls $SEARCH_PATH | wc -l)"

counter=0

while :
do
		#############Start_Stop Button##################
		if [ $(cat /sys/class/gpio/gpio$in1/value) -eq 1 ] ; then
			#toggle button state
				if [ $button_state -eq 0 ]
					then
						button_state=1
						#playSong.sh need to be created
						/Abdeen_Scripts/playSong.sh &
						pid="$(pidof madplay)"
					sleep 0.3
				else
						button_state=0
						#Stop_Song
						kill $pid
					sleep 0.3
				fi
		fi
		#############Next Button##################				
		if [ $(cat /sys/class/gpio/gpio$in2/value) -eq 1 ] ; then
			#kill Prev. Song
			kill $pid
			counter=$((counter+1))
			#Check if it is the last Song
			if [ "$counter" -eq "NO_OF_SONGS" ] 
				then
				counter="1"
			fi
			song="$($List | cut -d' ' -f$counter)"
			madplay "$song"
			pid="$(pidof madplay)"
			sleep 0.3		
		fi
		#############Prev. Button##################				
		if [ $(cat /sys/class/gpio/gpio$in3/value) -eq 1 ] ; then
			#kill Prev. Song
			kill $pid
			counter=$((counter-1))
			#Check if it is the last Song
			if [ "$counter" -le "0" ]
				then
				counter="1"
			fi
			song="$($List | cut -d' ' -f$counter)"
			madplay "$song"
			pid="$(pidof madplay)"
			sleep 0.3		
		fi
		#############Shuffle Button##################				
		if [ $(cat /sys/class/gpio/gpio$in4/value) -eq 1 ] ; then
			#kill Prev. Song
			kill $pid
			#Create Random number 
			counter=$((1 + RANDOM % NO_OF_SONGS))
			#Check if it is the last Song
			if [ "$counter" -le "0" ]
				then
				counter="1"
			fi
			song="$($List | cut -d' ' -f$counter)"
			madplay "$song"
			pid="$(pidof madplay)"
			sleep 0.3		
		fi
done		
}
#Call Function and pass Buttons Numbers to it 
#Play/Pause - Next - Previous - Shuffle (BCM Numbering System)
play_buttons 17 27 22 25