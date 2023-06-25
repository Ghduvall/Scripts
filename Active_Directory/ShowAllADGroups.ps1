#Script that prints out All ADGroups in we.local

#Sets current user var
$CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$CurrentUser = $CurrentUser.Substring(3)

#Gets all AD Groups in a list
$ADGroupsList = Get-ADGroup -Filter '*' | Select-Object -Property Name

#Outputs all AD Groups into a .txt
$ADGroupsList | Out-File "C:\Users\$CurrentUser\Desktop\CurrentADSecurityGroups.txt"
#$ADGroupsList

#Gets AD Group Memebers from -Identity Group specified
$ADUserInGroupsList = Get-ADGroupMember -Identity "Enterprise Admins" | Select-Object -Property Name
$ADUserInGroupsList
