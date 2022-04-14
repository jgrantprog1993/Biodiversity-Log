#Name: Jason Grant
#Student ID: 12430732
#./addRecords
#
#17/Oct/2021
#
#
#
						####### Desc #########
#	Asks user to enter species name, Eircode, date and email address. 
#	All these have specific checks to check if the format is correct.
#	Then creates the entry and prints it to the screen, asks user if they are happy to add this, gives them option to accept or cancel
#	If accept, added to the speciesDetails.txt file
# 
						####### Issue #########
#	User can't input details in the wronf format more than twice, if its twice, returned to the main menu (this could be slicker)
#	email address isnt case insensitive when checking if .com and .ie are included
function highlight
{

echo -e "\e[1;32m=========== $* ===========\e[0m"

}


echo "Enter the following information"

highlight Species Name ***No Numbers or Special Chars in this field***
#Format -> All chars, no numbers or special characters
read speciesName
if [[ ! $speciesName =~ ^[[:alnum:]]+$ ]] || [[ $speciesName =~ [0-9] ]] ; then
   echo -e "\e[1;31m Invalid input, ensure only letters in name \e[0m"
   echo -e "\e[1;31m Try Again.. \e[0m"
   read speciesName
   	if [[ ! $speciesName =~ ^[[:alnum:]]+$ ]] || [[ $speciesName =~ [0-9] ]]; then
   		echo -e "\e[1;31m Invalid input, returning to Main Menu \e[0m"
   		./menu
   	fi
fi

highlight Location ***In Eircode Format e.g A65 F4E2***
#Format -> The first character is always a letter, followed by 2 numbers. Always 7 characters
read location

if ! [[ $location =~ ^[A-Za-z][0-9][0-9]....$ ]]; then
	echo -e "\e[1;31m Invalid input, ensure valid Format \e[0m"
	echo -e "\e[1;31m Try Again.. \e[0m"
	read location
	if ! [[ $location =~ ^[A-Za-z][0-9][0-9]....$ ]]; then
		echo -e "\e[1;31m Invalid input, returning to Main Menu \e[0m"
		./menu
	fi
fi

highlight Date Spotted ***Format DDMMYYYY***:
echo "Choose Day:  ***Format DD***"
#Format -> 8 chars long, no letters or special chars. DD<32, MM<13, YYYY<2022
read dateDD
if   [[ ! $dateDD =~ ^[0-3][0-9]$ ]] || [[ $dateDD > 31  ]]; then
	echo -e "\e[1;31m Invalid input, ensure valid Format \e[0m"
	echo -e "\e[1;31m Try Again.. \e[0m"
	read dateDD
	if  [[ ! $dateDD =~ ^[0-3][0-9]$ ]] || [[ $dateDD > 31  ]]; then
		echo -e "\e[1;31m Invalid input, returning to Main Menu \e[0m"
		./menu
	fi
fi
echo "Choose Month:  ***Format MM***"
read dateMM
if   [[ ! $dateMM =~ ^[0-1][0-9]$ ]] || [[ $dateMM > 12  ]]; then
	echo -e "\e[1;31m Invalid input, ensure valid Format \e[0m"
	echo -e "\e[1;31m Try Again.. \e[0m"
	read dateMM
	if  [[ ! $dateMM =~ ^[0-1][0-9]$ ]] || [[ $dateMM > 12  ]]; then
		echo -e "\e[1;31m Invalid input, returning to Main Menu \e[0m"
		./menu
	fi
fi
echo "Choose Year:  ***Format YYYY***"
read dateYYYY
if   [[ ! $dateYYYY =~ ^[0-2][0-9][0-9][0-9]$ ]] || [[ $dateYYYY > 2021  ]]; then
	echo -e "\e[1;31m Invalid input, ensure valid Format \e[0m"
	echo -e "\e[1;31m Try Again.. \e[0m"
	read dateYY
	if  [[ ! $dateYYYY =~ ^[0-2][0-9][0-9][0-9]$ ]] || [[ $dateYYYY > 2021  ]]; then
		echo -e "\e[1;31m Invalid input, returning to Main Menu \e[0m"
		./menu
	fi
fi
dateDDMMYYY="${dateDD}${dateMM}${dateYYYY}"



highlight please enter your email : 
read email
if   [[ ! "$email" == *"@"* ]] || [[ ! "$email" =~ ".com"  ]] && [[ ! "$email" == *"@"* ]] || [[ ! "$email" =~ ".ie"  ]] ; then
		echo -e "\e[1;31m Invalid input, ensure valid Format \e[0m"
		echo -e "\e[1;31m Try Again.. \e[0m"
		read email
		if  [[ ! "$email" == *"@"* ]] || [[ ! "$email" =~ ".com"  ]] && [[ ! "$email" == *"@"* ]] || [[ ! "$email" =~ ".ie"  ]]; then
			echo -e "\e[1;31m Invalid input, returning to Main Menu \e[0m"
			./menu
		fi
fi

echo "Add the following entry to the file? Are All entries correct? [y or n]"
echo " $SpeciesName $location $dateDDMMYYY $email "

read word
case $word in 
 		[yY] | [yY][Ee][Ss] )
                echo $SpeciesName $location $dateDDMMYYY $email >> speciesDetails.txt
                echo "Entry Added!"
                ;;

        [nN] | [n|N][O|o] )
                echo "Entry Cancelled";
                exit 1
                ;;
        *) echo "Invalid input"
            ;;
esac


echo ""
./menu
