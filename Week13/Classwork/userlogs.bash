#! /bin/bash

authfile="/var/log/auth.log"
emailAddr="liam.gugliotta@mymail.champlain.edu"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser" 
}

function getFailedLogins(){
# Todo - 1
# a) Make a little research and experimentation to complete the function
# b) Generate failed logins and test
  keyWord="unix_chkpwd"
  #failedLogins=$(cat "$authfile" | grep "$keyWord" | cut -d ' ' -f1,2,3,4,6- | sed 's/:/-/g')
  failedLogins=$(cat "$authfile" | grep "$keyWord" | awk -F" " '{ newfour="| " $4; $4=newfour; $5="|"; print}' | sed 's/:/-/g')

  echo "$failedLogins"
}

# Sending logins as email
:> emailform.txt
echo "To: $emailAddr" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp $emailAddr

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as email 
:> emailform.txt
echo "To: $emailAddr" > emailform.txt
echo "Subject: Failed Logins" >> emailform.txt
getFailedLogins >> emailform.txt
cat emailform.txt | ssmtp $emailAddr
