. (Join-Path $PSScriptRoot configuration.ps1)
. (Join-Path $PSScriptRoot email.ps1)
. (Join-Path $PSScriptRoot scheduler.ps1)
. (Join-Path "C:\Users\champuser\Desktop\CSI-230-01\Week6\Classwork" Event-Logs.ps1)
clear
<#
$config = getConfig
[String]$daysBack = $config.Days
$riskUsers = getAtRiskUsers $daysBack
sendAlertEmail ($riskUsers | Format-Table | Out-String)
chooseRunTime $config.ExecutionTime "myTask"
#>

configurationMenu