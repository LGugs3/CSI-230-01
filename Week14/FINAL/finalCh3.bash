#!/bin/bash

function createIOCTable()
{
 htmlFile="iocTable.html"
 reportFile="report.txt"
 :> $htmlFile

 echo -e "<html>\n<body>\n" >> $htmlFile
 
 echo -e "<style>\n" >> $htmlFile
 echo -e "table, td, th {border:1px solid black}\n" >> $htmlFile
 echo -e "</style>\n" >> $htmlFile

 echo -e "<table>\n" >> $htmlFile
 echo -e "<tr><th>IP</th><th>Date</th><th>IOC</th></tr>\n" >> $htmlFile
 awk -v OFS='</td> <td>' -v ORS='</td>\n</tr>\n' '{print "<tr>\n<td>" $1, $2, $3}' $reportFile >> $htmlFile
 echo -e "</table>\n</body>\n</html>" >> $htmlFile
}

createIOCTable
