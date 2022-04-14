#Name: Jason Grant
#Student ID: 12430732
#./emailAllRecords
#
#17/Oct/2021
#
#
function highlight
{

echo -e "\e[1;32m=========== $* ===========\e[0m"

}
#This put the email body in a format the is acceptable to send via email.. i.e. in rows
IFS=
emailBody=$(cat speciesDetails.txt)
IFS=' '
highlight Enter email Subject Line
read emailSubjectLine

#2 Steps, 
#1-> Remove Deuplicates ( https://unix.stackexchange.com/questions/131217/how-to-remove-duplicate-lines-with-awk-whilst-keeping-all-empty-lines)
#2-> Number the rows
highlight All Emails
awk '!NF || !seen[$4]++' speciesDetails.txt > emailListUF.txt
awk '{print NR" ) "$4}' emailListUF.txt > emailListF.txt

cat emailListF.txt

#Then user can decide which row they want via the numbering
echo "Choose Specific Email (Input Line Numnber) OR Email All (Input a):"
read d1

case $d1 in
		#Number choosen limited to 0 - 9999
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

