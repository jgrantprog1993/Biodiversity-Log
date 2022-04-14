#!/bin/bash
# Name: Jason Grant
# Student ID: 12430732
# 
#
#Remove Selecetion


cat -n speciesDetails.txt

echo "Remove (a)ll or (s)pecific entry?"
read d1

case $d1 in

	[aA]|[aA][lL][Ll])
						echo " All entries deleted "
						sed -i '/ /d' speciesDetails.txt	
						;;
						
	[sS])
						echo "What line number do you want to delete? : "
						read d2
						echo $d2
						sed -i "${d2}d" speciesDetails.txt	
						;;		
							
	*) echo "Invalid input"
		;;
	
esac

cat -n speciesDetails.txt
./menu

