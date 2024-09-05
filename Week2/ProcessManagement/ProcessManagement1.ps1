clear
#Deliverable 1
#Get-Process | Where-Object {$_.ProcessName -ilike "c*" }

#Deliverable 2
#Get-Process | Where-Object { $_.Path -inotlike "*system32*" } | select Id, SI, ProcessName, Path

#Deliverable 3
#Get-Service | Where-Object { $_.Status -match "Stopped" } | Sort-Object | Export-Csv -Path C:\Users\champuser\CSI-230-01\Week2\ProcessManagement\StoppedProcesses.csv


#Deliverable 4
$chromeExe = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$service = Get-Process | Where-Object {$_.Name -ilike "*chrome*" } | select Id, ProcessName

if ($service -eq $null)
{
    Write-Host "Starting Chrome Service"
    Start-Process -FilePath $chromeExe -ArgumentList '--new-window "https://www.champlain.edu"'
}
else
{
    Write-Host "Stopping Chrome service"
    Stop-Process -Id $service.Id
}

