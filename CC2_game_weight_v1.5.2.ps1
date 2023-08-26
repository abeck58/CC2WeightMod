[Environment]::CurrentDirectory = (Get-Location -PSProvider FileSystem).ProviderPath
$ErrorActionPreference = 'Stop'

$file = "carrier_command.exe"

$exehash = Get-FileHash $file -Algorithm "SHA256"
echo $exehash
If ($exeHash.Hash -ne "37847C780814143036C3DDEA29954EBC80A8D8A4EDACD3A8A5BAC00035A64F2A")
{
write-host Hash check failed
pause
exit
}
write-host Hash check passed for v1.5.2

$weight = Read-Host "Carrier Weight Limit"
$weightHex = '{0:X}' -f ([uint32]$weight)
$bytesarray  = [System.BitConverter]::GetBytes([uint32]$weight)


write-host 'Debug (Show Hex)',$weightHex
write-host 'Debug (Show Array)',$bytesarray

$bytes = [System.IO.File]::ReadAllBytes($file)
$weightOffset = 2823564


$bytes[$weightOffset] = $bytesarray[0]
$bytes[$weightOffset+1] = $bytesarray[1]
$bytes[$weightOffset+2] = $bytesarray[2]
$bytes[$weightOffset+3] = $bytesarray[3]

write-host Writing modded file CC2_Modded.exe
[System.IO.File]::WriteAllBytes("CC2_Modded.exe", $bytes)
pause
