. (Join-Path $PSScriptRoot "Apache-Logs.ps1")
clear

$test = GetApachePageRequests "index.html" "200" "Chrome"
$test