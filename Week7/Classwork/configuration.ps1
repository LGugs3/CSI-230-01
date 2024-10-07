function getConfig()
{
    $configTable = @()
    $configText = Get-Content "$($PSScriptRoot)/configuration.txt"
    $configTable += [pscustomobject] @{"Days" = $configText[0]; `
                                       "ExecutionTime" = $configText[1]; `
                                      }
    return $configTable
}

function changeConfig()
{
    $daysRegex = [regex] '^\d+$'
    $dateRegex = [regex] '^(1[0-2]|\d{1}):[0-5]?\d{1}\s{1}[AP]M$'
    $validatedInput = $false
    while(-not $validatedInput)
    {
        Write-Host "Enter new number of days for which the logs will be obtained: " -NoNewline
        $newDays = Read-Host
        Write-Host "`nEnter new daily execution date: " -NoNewline
        $newDate = Read-Host

        if(($newDays -match $daysRegex) -and ($newDate -match $dateRegex))
        {
            Write-Host "Saving new values"
            $validatedInput = $true
        }
        else
        {
            Write-Host "Invalid Input`n`n"
        }
    }
    Clear-Content "$($PSScriptRoot)\configuration.txt"
    $configData = "$($newDays)`n$($newDate)"
    Out-File -FilePath "$($PSScriptRoot)\configuration.txt" -InputObject $configData
}

function configurationMenu()
{
    $prompt = "`n"
    $prompt += "Enter Number: `n"
    $prompt += "1. Show Configuration `n"
    $prompt += "2. Change configuration `n"
    $prompt += "3. Exit"

    $continueOp = $true
    while($continueOp)
    {
        $prompt | Out-String
        $opNumber = Read-Host

        if ($opNumber -eq 3)
        {
            Write-Host "Exiting..."
            $continueOp = $false
        }
        elseif ($opNumber -eq 1)
        {
            $config = getConfig
            $config | Out-String
        }
        elseif($opNumber -eq 2)
        {
            changeConfig
        }
        else
        {
            Write-Host "Invalid Input"
        }
    }
}
