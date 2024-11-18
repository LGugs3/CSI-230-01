echo "File was accessed $(date)" >> /home/champuser/CSI-230-01/Week13/Homework/fileaccesslog.txt
sed -i 's/:/-/g' fileaccesslog.txt

:> newEmail.txt
echo "To: liam.gugliotta@mymail.champlain.edu" >> newEmail.txt
echo "Subject: Access" >> newEmail.txt
cat /home/champuser/CSI-230-01/Week13/Homework/fileaccesslog.txt >> newEmail.txt

cat newEmail.txt | ssmtp "liam.gugliotta@mymail.champlain.edu"
