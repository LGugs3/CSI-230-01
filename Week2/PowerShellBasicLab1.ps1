clear
# Deliverable 1
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0"}).IPAddress

#Deliverable 2
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0"}).PrefixLength

#Deliverable 3 and 4
#Get-WmiObject -List | Where-Object {$_.Name -ilike "Win32_Net*" } | Sort-Object

#Deliverable 5 and 6
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | select DHCPServer | Format-Table -HideTableHeaders

#Deliverable 7
#(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet0"}).ServerAddresses[0]

<#
#Deliverable 8
cd $PSScriptRoot
$files=(Get-ChildItem)
for ($j = 0; $j -le $files.Count; $j++)
{
    if ($files[$j].Name -ilike "*.ps1"){
        Write-Host $files[$j].Name
    }
}
#>

<#
#Deliverable 9
$folderPath = "$PSScriptRoot\outfolder"
if (Test-Path -Path $folderPath)
{
    Write-Host "Folder Already Exists"
}
else
{
    New-Item -ItemType "directory" -Path $folderPath
}
#>

<#
#Deliverable 10
cd $PSScriptRoot
$files = Get-ChildItem
$folderPath = "$PSScriptRoot/outfolder/"
$filePath = New-Item -ItemType "file" -Path $folderPath -Name "out.csv"
$files | Where-Object{ $_.Extension -eq ".ps1" } | Export-Csv -Path $filePath
ls $folderPath
#>

<#
#Deliverable 11
$files = Get-ChildItem -Recurse -Filter "*.csv"
$files | Rename-Item -NewName { $_.name -replace 'csv', 'log' }
Get-ChildItem -Recurse -Filter "*.log"
#>