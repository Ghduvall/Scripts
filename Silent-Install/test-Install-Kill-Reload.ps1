Start-Process -FilePath "C:\Users\GrantDuvall\OneDrive - NSN Management, LLC\Documents\Workspace\Silent-Install\VBAConnectSetup-1.0.20.exe" -ArgumentList "/S" -NoNewWindow -PassThru
# Wait for 10 seconds
Start-Sleep -s 5

Get-Process | Where-Object {$_.Path -like "*VBA*"} | Stop-Process

Start-Sleep -s 5

Start-Process -FilePath "C:\Users\GrantDuvall\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\VBA\VBA Connect.lnk"

