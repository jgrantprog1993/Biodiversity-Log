#!/bin/bash
# Name: Jason Grant
# Student ID: 12430732
# 
#
#-------Search Function
function highlight
{

echo -e "\e[1;32m=========== $* ===========\e[0m"
}


highlight Search Function
echo "What Species do you want to Search for ?"
read searchSpecies

var="$(grep -c -i $searchSpecies speciesDetails.txt)" 
##### askubuntu.com/questions/410301/assigning-grep-output-to-a-variable

if [ $var -lt 1 ]
then
	echo "There are no recordings of $searchSpecies"
	./menu
else

	echo "There are $var recordings of $searchSpecies"

	grep -i $searchSpecies speciesDetails.txt
fi
./menu
