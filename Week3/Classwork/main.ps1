. (Join-Path $PSScriptRoot functions.ps1)
clear
$numDays = 30

$loginoutsTable = GetLoginOutLogs $numDays
$loginoutsTable

$shutdownStartupTable = GetPowerLogs $numDays
$shutdownStartupTable