
$scriptblock = {

    

    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

    Start-Process "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PowerShell\PowerShell 7 (x64).lnk"


    Start-Sleep -s 5


    [System.Windows.Forms.SendKeys]::SendWait(“. C:\Users\GrantDuvall\Final-Final-Test-VBA-Install.ps1”)

    #. C:\Users\GrantDuvall\Final-Final-Test-VBA-Install.ps1


    [System.Windows.Forms.SendKeys]::SendWait(“{ENTER}”)
}

Invoke-AsCurrentUser -scriptblock $scriptblock