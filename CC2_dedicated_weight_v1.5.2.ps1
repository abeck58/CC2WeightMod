[Environment]::CurrentDirectory = (Get-Location -PSProvider FileSystem).ProviderPath
$ErrorActionPreference = 'Stop'

$file = "dedicated_server.exe"

$exehash = Get-FileHash $file -Algorithm "SHA256"
echo $exehash
If ($exeHash.Hash -ne "058FDB1A32950A4BE9B22E22D95457B8A5FCC062748E714E8D27E85110458124")
{
write-host Hash check failed
pause
exit
}
write-host Hash check passed for dedicated server v1.5.2

$weight = Read-Host "Carrier Weight Limit"
$weightHex = '{0:X}' -f ([uint32]$weight)
$bytesarray  = [System.BitConverter]::GetBytes([uint32]$weight)


write-host 'Debug (Show Hex)',$weightHex
write-host 'Debug (Show Array)',$bytesarray

$bytes = [System.IO.File]::ReadAllBytes($file)
$weightOffset = 1149548


$bytes[$weightOffset] = $bytesarray[0]
$bytes[$weightOffset+1] = $bytesarray[1]
$bytes[$weightOffset+2] = $bytesarray[2]
$bytes[$weightOffset+3] = $bytesarray[3]

write-host Writing modded file dedicated_server_modded.exe
[System.IO.File]::WriteAllBytes("dedicated_server_modded.exe", $bytes)
pause