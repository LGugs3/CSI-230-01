#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas
function getCourseLocation()
{
 echo -n "Please input a class code: "
 read classCode

 echo "Location of courses:"
 cat "$courseFile" | grep "$classCode" | cut -d';' -f1,2,5-7,10 | sed 's/;/ | /g'
 echo ""
}

# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas
function getAvailableCourses()
{
 echo -n "Enter course code: "
 read classCode

 echo "Courses with open seats:"
 #cat "$courseFile" | cut -d';' -f1,4 | grep -i "$classCode" | grep -ve "-[[:digit:]]*$" -ve "0$" | sort -t';' -k2 -n | sed 's/;/ | /g'
 output=$(awk -v code=$classCode -F ';' '{if (match($1, code) && $4 > 0) print substr($0, 1, length($0)-1)}' courses.txt)
 echo "$output" | sed 's/;/ | /g'
 echo ""
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display location of class"
  echo "[4] Display Sections with seats"
  echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts
  elif [[ "$userInput" == "3" ]]
  then
    getCourseLocation
  elif [[ "$userInput" == "4" ]]
  then
    getAvailableCourses
  else
    echo "Invlaid Input"
	fi
done
