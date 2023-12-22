[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 


#VAR
# Replace A with (
# Actual Client Code E352CdpHA!@GkDS
$ClientCode =  "E352CdpHA!@GkDS"

Start-Process -FilePath "C:\Users\GrantDuvall\OneDrive - NSN Management, LLC\Documents\Workspace\Silent-Install\VBAConnectSetup-1.0.20.exe" -ArgumentList "/S" -NoNewWindow -PassThru
# Wait for 10 seconds
Start-Sleep -s 5

Get-Process | Where-Object {$_.Path -like "*VBA*"} | Stop-Process

Start-Sleep -s 5

Start-Process -FilePath "C:\Users\GrantDuvall\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\VBA\VBA Connect.lnk"


# Load NotePad
#& “$env:WINDIR\notepad.exe”
& "\Users\GrantDuvall\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\VBA\VBA Connect.lnk"

# Wait the application start for 1 sec 
Start-Sleep -s 5
 
# Click into box
#$InputBox.Add_Click( { $this.SelectAll(); $this.Focus() })
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
Start-Sleep -s 2
# Send keys
[System.Windows.Forms.SendKeys]::SendWait(“LOvrtmrxa67xF7Q2gVIMp64E91ys6hU95MgZdPLA”)
#[System.Windows.Forms.SendKeys]::SendWait(“{ENTER}”)
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")

[System.Windows.Forms.SendKeys]::SendWait($ClientCode.Replace('A','{(}'))
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
[System.Windows.Forms.SendKeys]::SendWait(“{ENTER}”)
Start-Sleep -s 2
[System.Windows.Forms.SendKeys]::SendWait(“{ENTER}”)
# Open "Save As.." menu (Alt+f+s)
#[System.Windows.Forms.SendKeys]::SendWait(“%fs”)
 
# Wait menu opening for 0.5 sec 
Start-Sleep -m 500
