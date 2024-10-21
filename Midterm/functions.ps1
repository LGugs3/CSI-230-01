function getPageByCom($url)
{
    $ie = New-Object -ComObject internetexplorer.application #Creating COM object

    $ie.navigate($url)
    while($ie.ReadyState -ne 4) {Start-Sleep -s 10} #Wait for page to load
    $ie.visible = $false

    return $ie
}

function getTable($page)
{
    $trs = $page.Document.getElementsByTagName("tr")
    return $trs
}

function getRows($table)
{
    $headerRow = $table[0].getElementsByTagName("th")
    $patternName = $headerRow[0].innerText.ToString()
    $descName = $headerRow[1].innerText.ToString()
    $formattedTable = @()
    
    for($i = 1; $i -le $table.length - 1; $i++)
    {
        $row = $table[$i].getElementsByTagName("td")
        $formattedTable += [pscustomobject] @{ $patternName = $row[0].innerText; `
                                               $descName = $row[1].innerText; `
                                             }
    }
    
    return $formattedTable | Format-Table
}

function parseApacheLogs($filePath)
{
    $unformattedLogs = Get-Content $filePath
    $table = @()

    for($i = 0; $i -lt $unformattedLogs.Count; $i++)
    {
        $line = $unformattedLogs[$i].Split(" ")

        $table += [pscustomobject]@{ "IP" = $line[0];
                                     "Time" = $line[3].Trim('[');
                                     "Method" = $line[5].Trim('"');
                                     "Page" = $line[6];
                                     "Protocol" = $line[7];
                                     "Response" = $line[8];
                                     "Referrer" = $line[10];
                                   }
    }
    return $table | Format-Table
}

function filterLogsByPage($logTable, [pscustomobject]$comparisonTable)
{
    $comparisonTable | Out-String
    $testTable = @()
    for($i = 0; $i -lt $comparisonTable.Count; $i++)
    {
        $testTable += [pscustomobject] @{ "Description" = $comparisonTable[$i].Description; }
    }
    #return $logTable.Page | Select-String $testTable | Format-Table
}