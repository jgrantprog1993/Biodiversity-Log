#Name: Jason Grant
#Student ID: 12430732
#./email
#
#16/Oct/2021
#
#

function highlight
{

echo -e "\e[1;32m=========== $* ===========\e[0m"

}

echo -e "\e[1;32mWhat records do you want to send ?\e[0m"

#Gives user a predefined set of options
options1=("All" "Record" "Species" "Location" "Date" "Email")

select opt1 in "${options1[@]}"
do 
	case $opt1 in
		
		All)
			echo -e "\e[1;32m all Records\e[0m"
			./emailAllRecords.sh
			;;
		Record)
			echo -e "\e[1;32mSpecificRecord\e[0m"
			./emailSpecificRecords.sh
			;;
		Species)
			echo -e "\e[1;32mAllrecords of specific species\e[0m"
			./emailSpecificSpecies.sh
			;;
		Location)
			echo -e "\e[1;32mAll Records in specific Location \e[0m"
			./emailSpecificLocation.sh
			;;
		Date)
			echo -e "\e[1;32mAll records of specific date\e[0m"
			./emailSpecificDate.sh
			;;
		Email)
			echo -e "\e[1;32mAll records from specific email/operator\e[0m"
			./emailSpecificEmail.sh
			;;
		*) echo "invalid option $REPLY";;
    esac
done

./menu
		
