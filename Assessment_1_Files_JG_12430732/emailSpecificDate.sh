#Name: Jason Grant
#Student ID: 12430732
#./emailSpecificDate.sh
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

highlight Unique Dates of Recordings

#2 Steps, 
#1-> Remove Deuplicates ( https://unix.stackexchange.com/questions/131217/how-to-remove-duplicate-lines-with-awk-whilst-keeping-all-empty-lines)
#2-> Number the rows

awk '!NF || !seen[$3]++'  speciesDetails.txt > datesF.txt
awk '{print NR" ) "$3}' datesF.txt > datesFN.txt
cat datesFN.txt
echo 'What specific date do you want to send?'
read specificDate
#matches date to first item in row in the filtered and numbered version of the txt file
specVar=$(awk '$1 == '$specificDate' {print $3}' datesFN.txt)
echo $specVar
IFS=

case $specificDate in
#Number choosen limited to 0 - 9999
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
##
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


