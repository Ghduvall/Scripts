[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 


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
[System.Windows.Forms.SendKeys]::SendWait(“I'm wrinting something”)
#[System.Windows.Forms.SendKeys]::SendWait(“{ENTER}”)
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")

[System.Windows.Forms.SendKeys]::SendWait(“Powered by PowerShell”)

[System.Windows.Forms.SendKeys]::SendWait("{TAB}")

[System.Windows.Forms.SendKeys]::SendWait(“{ENTER}”)
[System.Windows.Forms.SendKeys]::SendWait(“{ENTER}”)
 
# Open "Save As.." menu (Alt+f+s)
#[System.Windows.Forms.SendKeys]::SendWait(“%fs”)
 
# Wait menu opening for 0.5 sec 
Start-Sleep -m 500