#Name: Jason Grant
#Student ID: 12430732
#./emailSpecificEmail.sh
#
#17/Oct/2021
#
#
function highlight
{

echo -e "\e[1;32m=========== $* ===========\e[0m"

}

#highlight Enter email Body
#read emailBody
highlight Enter email Subject Line
read emailSubjectLine

highlight Emails that uploaded recodings

#2 Steps, 
#1-> Remove Deuplicates ( https://unix.stackexchange.com/questions/131217/how-to-remove-duplicate-lines-with-awk-whilst-keeping-all-empty-lines)
#2-> Number the rows

awk '!NF || !seen[$4]++'  speciesDetails.txt > emailF.txt
awk '{print NR" ) "$4}' emailF.txt > emailFN.txt
cat emailFN.txt
echo 'From which users(email) recordings do you want to send?'
read specificEmail
specVar=$(awk '$1 == '$specificEmail' {print $3}' emailFN.txt)
echo $specVar
IFS=

case $specificEmail in
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

highlight All Emails
awk '!NF || !seen[$4]++' speciesDetails.txt > emailListUF.txt
awk '{print NR" ) "$4}' emailListUF.txt > emailListF.txt

cat emailListF.txt


echo "Choose Specific Email (Input Line Numnber) OR Email All (Input a):"
read d1

case $d1 in
		
	[0-9] | [0-9][0-9] | [0-9][0-9][0-9] | [0-9][0-9][0-9][0-9])
		
		emailList=$(awk '$1 == '$d1' {print $3}' emailListF.txt)		#selecting specific email from the row number
		echo $emailList
		;;
	[aA])
		
		emailList=$(awk '{print $3}' emailListF.txt | paste -s -d, -)	#selecting all emails listed, and putting them into a format useable by the mail command
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


