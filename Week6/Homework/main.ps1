$apacheLogsFilePath = "C:\Users\champuser\Desktop\CSI-230-01\Week4\Homework" #ParsingApacheLogs.ps1
$loginsAndRiskFilePath = "C:\Users\champuser\Desktop\CSI-230-01\Week6\Classwork" #Event-Logs.ps1
$chromeInstance = "C:\Users\champuser\Desktop\CSI-230-01\Week2\ProcessManagement" #ProcessManagement1.ps1

. (Join-Path $apacheLogsFilePath ParsingApacheLogs.ps1)
. (Join-Path $loginsAndRiskFilePath Event-Logs.ps1)
. (Join-Path $chromeInstance ProcessManagement1.ps1)
clear

$prompt = "`n"
$prompt += "Enter Number: `n"
$prompt += "1. Display last 10 Apache logs `n"
$prompt += "2. Display last 10 failed logins for all users `n"
$prompt += "3. Display at risk users `n"
$prompt += "4. Open Chrome to champlain.edu `n"
$prompt += "5. Exit `n"

$continueOp = $true

while($continueOp)
{
    Write-Host $prompt | Out-String
    $opNumber = Read-Host

    if ($opNumber -eq 5)
    {
        Write-Host "Exiting..." | Out-String
        $continueOp = $false
        exit
    }
    elseif($opNumber -eq 1)
    {
        $apacheLogs = ApacheLogs1
        $apacheLogs | Sort-Object Time -Descending | Select-Object -First 10 | Format-Table -AutoSize -Wrap | Out-String
    }
    elseif($opNumber -eq 2)
    {
        $failedLogins = getFailedLogins 90 | Sort-Object Time -Descending | Select-Object -First 10
        if ($failedLogins.Length -lt 10)
        {
            Write-Host "Number of Failed Logins is $($failedLogins.Length) `n"
        }
        $failedLogins | Out-String
    }
    elseif($opNumber -eq 3)
    {
        $atRiskUsers = getAtRiskUsers 90
        $numUsers = $atRiskUsers | Measure-Object -Line
        if($numUsers.Count -gt 0)
        {
            Write-Host "Number of at risk users is $($numUsers.Count)"
        }
        $atRiskUsers | Out-String
    }
    elseif($opNumber -eq 4)
    {
        goToWebAddress "https://www.champlain.edu"
    }
    else
    {
        Write-Host "Invalid Input"
        continue
    }
}