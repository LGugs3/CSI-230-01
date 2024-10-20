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
    $headerRow = $table[0].getElementsByTagName("td")
    $patternName = $headerRow[0].innerText
    $descName = $headerRow[1].innerText
    $formattedTable = @()
    <#
    for($i = 1; $i -le $table.length; $i++)
    {
        $row = $table[$i].getElementsByTagName("td")
        $formattedTable += [pscustomobject] @{ $patternName = $row[0].innerText; `
                                               $descName = $row[0].innerText; 
                                             }
    }
    #>
    return $formattedTable | Format-Table
}