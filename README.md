# Carrier Command 2 Capacity Weight Change Mod
A version of srive's script that while less polished alows for easer offset input when trying to find the offset for different game versions.
Lets players alter the capacity weight of the carrier in the game Carrier Command 2

Instructions
1) Drop the powershell script in to your carrier command 2 folder.
2) Run the script and enter the offset
3) I am sure if you are trying this you know where to go from hear.

The weight limit is stored in the executable in little-endian format.
To locate the correct offset, follow these steps:
Open the carrier_command.exe file in a hex editor i used HxD.
Search for the weight limit. The weight limit is represented by a little-endian HEX value of 40 42 0F.
There will be several results. The offset where you find this value should be in the 2,000,000 to 3,000,000 range. 
Use this offset in the script to edit the capacity weight.
