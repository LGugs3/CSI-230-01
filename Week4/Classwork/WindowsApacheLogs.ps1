clear
#Deliverable 2
#Get-Content C:\xampp\apache\logs\access.log

#Deliverable 3
#Get-Content C:\xampp\apache\logs\access.log -Tail 5

#Deliverable 4
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '

#Deliverable 5
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

#Deliverable 6
<#
$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
$A[-5..-1]
#>

#Deliverable 7
$notFounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 '

$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

$ipsUnorganized = $regex.Matches($notFounds)

$ips = @()
for($i = 0; $i -lt $ipsUnorganized.Count; $i++)
{
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }
}

#$ips | Where-Object { $_.IP -ilike "10.*" }

#Deliverable 8
$counts = $ips | Where-Object { $_.IP -ilike "10.*" } | Group-Object IP
$counts | select Count, Name
