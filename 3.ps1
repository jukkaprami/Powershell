# Silmukat forEach

$Tilit = Get-ADUser -Filter *

foreach ($Tili in $Tilit) {

Write-Host $Tili.name

}