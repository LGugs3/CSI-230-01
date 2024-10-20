. (Join-Path $PSScriptRoot functions.ps1)
clear

$url = "http://10.0.17.15/IOC.html"

$page = getPageByCom $url
$table = getTable $page
getRows $table



$page.Quit()