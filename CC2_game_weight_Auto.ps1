[Environment]::CurrentDirectory = (Get-Location -PSProvider FileSystem).ProviderPath
$ErrorActionPreference = 'Stop'

$file = "carrier_command.exe"

# Set the Carrier Weight Limit to 2,000,000
$weight = 2000000
$weightHex = '{0:X}' -f ([uint32]$weight)
$bytesarray  = [System.BitConverter]::GetBytes([uint32]$weight)

write-host 'Setting Carrier Weight Limit to 2,000,000'
write-host 'Debug (Show Hex)', $weightHex
write-host 'Debug (Show Array)', $bytesarray

$bytes = [System.IO.File]::ReadAllBytes($file)

# Prompt user for the offset
$weightOffsetInput = Read-Host "Enter the offset for the weight limit (in decimal format)"
$weightOffset = [int]$weightOffsetInput

# Apply the new weight limit
$bytes[$weightOffset] = $bytesarray[0]
$bytes[$weightOffset+1] = $bytesarray[1]
$bytes[$weightOffset+2] = $bytesarray[2]
$bytes[$weightOffset+3] = $bytesarray[3]

# Generate the modded file name using the offset with ".exe" added
$customFileName = "$weightOffsetInput.exe"
write-host "Writing modded file $customFileName"
[System.IO.File]::WriteAllBytes($customFileName, $bytes)
pause
