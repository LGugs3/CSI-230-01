﻿. (Join-Path $PSScriptRoot functions.ps1)
clear

$url = "http://10.0.17.15/IOC.html"
$logFilePath = "C:\Users\champuser\Desktop\CSI-230-01\Midterm\access.log"

$page = getPageByCom $url
$comTable = getTable $page
$formattedComTable = @()
$formattedComTable = getRows $comTable

$formattedApacheTable = parseApacheLogs $logFilePath
$filteredApacheTable = filterLogsByPage $formattedApacheTable $formattedComTable

$filteredApacheTable | Format-Table | Out-String

$page.Quit()