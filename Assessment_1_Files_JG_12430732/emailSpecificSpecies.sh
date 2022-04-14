#Name: Jason Grant
#Student ID: 12430732
#./emailSpecificSpecies.sh
#
#17/Oct/2021
#
#
function highlight
{

echo -e "\e[1;32m=========== $* ===========\e[0m"

}

highlight Enter email Subject Line
read emailSubjectLine

highlight All Species Recorded

awk '!NF || !seen[$1]++'  speciesDetails.txt > speciesF.txt
awk '{print NR" ) "$1}' speciesF.txt > speciesFN.txt
cat speciesFN.txt
echo 'What Species records do you want to send?'
read specificRecording
specVar=$(awk '$1 == '$specificRecording' {print $3}' speciesFN.txt)
echo $specVar
IFS=

case $specificRecording in

	[0-9] | [0-9][0-9] | [0-9][0-9][0-9] | [0-9][0-9][0-9][0-9])
					awk '/'$specVar'/ {print $0}' speciesDetails.txt > emailBody_F.txt
					emailBody=$(cat emailBody_F.txt)
					IFS=' '
					echo $emailBody
					;;
	*)echo "Incorrect option"
		exit 1
		;;
esac	

highlight All Emails
awk '!NF || !seen[$4]++' speciesDetails.txt > emailListUF.txt
awk '{print NR" ) "$4}' emailListUF.txt > emailListF.txt

cat emailListF.txt


echo "Choose Specific Email (Input Line Numnber) OR Email All (Input a):"
read d1

case $d1 in
		
	[0-9] | [0-9][0-9] | [0-9][0-9][0-9] | [0-9][0-9][0-9][0-9])
		
		emailList=$(awk '$1 == '$d1' {print $3}' emailListF.txt)
		echo $emailList
		;;
	[aA])
		
		emailList=$(awk '{print $3}' emailListF.txt | paste -s -d, -)
		echo $emailList
		;;
	*)echo "Incorrect option"
		exit 1
		;;
esac		
	
echo '$emailBody' | mail -s '$emailSubjectLine' $emailList
highlight Sent the Following email to to the following emails  
echo 'To: ' $emailList
echo 'Subject:' $emailSubjectLine
echo 'Message:' $emailBody
  
./menu


