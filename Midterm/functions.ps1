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
    #$headerRow = $table[0].getElementsByTagName("th")
    #$patternName = $headerRow[0].innerText.ToString()
    #$descName = $headerRow[1].innerText.ToString()
    $formattedTable = @()

    for($i = 1; $i -le $table.Length - 1; $i++)
    {
        $row = $table[$i].getElementsByTagName("td")
        if($table[$i] -eq $null -or $row -eq "") {continue}
        $formattedTable += [PSCustomObject] @{ "Pattern" = $row[0].innerText; `
                                               "Description" = $row[1].innerText; `
                                             }
    }
    return $formattedTable
}

function parseApacheLogs($filePath)
{
    $unformattedLogs = Get-Content $filePath
    $table = @()

    for($i = 0; $i -lt $unformattedLogs.Length; $i++)
    {
        $line = $unformattedLogs[$i].Split(" ")

        $table += [PSCustomObject]@{ "IP" = $line[0];
                                     "Time" = $line[3].Trim('[');
                                     "Method" = $line[5].Trim('"');
                                     "Page" = $line[6];
                                     "Protocol" = $line[7];
                                     "Response" = $line[8];
                                     "Referrer" = $line[10];
                                   }
    }
    return $table
}

function filterLogsByPage($logTable, $comparisonTable)
{
    $filteredTable = @()
    foreach($log in $logTable)
    {
        if(($comparisonTable.Pattern | % {$log.Page.contains($_)}) -contains $true) { $filteredTable += $log }
    }
    
    return $filteredTable
}