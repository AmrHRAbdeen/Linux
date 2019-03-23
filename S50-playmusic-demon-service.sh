#!/bin/sh

PATH=/sbin:/bin:/usr/bin
DAEMON="/Abdeen_Scripts/buttonTracker.sh"
test -f ${DAEMON} || exit 0

startdaemon()
{
	echo -n "Starting ${DAEMON}: "
	# modprobe snd-bcm will wire up the sound card with alsa using madplay
	#/root/MP3_Songs will be created during overlay
	madplay /root/MP3_Songs/Song_1.mp3
	start-stop-daemon -b --start --quiet --exec ${DAEMON}
	echo "${DAEMON} stopped."
}

stopdaemon()
{
	echo -n "Stopping ${DAEMON}: "
	start-stop-daemon -b --start --quiet --exec ${DAEMON}
	echo "${DAEMON} stopped."
}

case "$1" in
	
	start)
		startdaemon 
		;;
	
	stop)
		stopdaemon 
		;;
	
	fore-reload)
		stopdaemon
		startdaemon
		;;
	
	restart)
		stopdaemon
		startdaemon
		;;
	*)
		echo "Options: $0 { start - stop - restart}" > &2
		exit 1
		;;
esac						 