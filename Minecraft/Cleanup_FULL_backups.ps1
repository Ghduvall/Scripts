# Clean Backups files based off of age of folders
# Set $BackupMaxAge to minus number (-0) of how many days old you would like to keep

$BackupPath="C:\FULL"
$BackupMaxAge="-6"

$DateAgeDelete = (Get-Date).AddDays($BackupMaxAge)

$BackupsToDelete = Get-ChildItem -Path $BackupPath | Where-Object {$_.LastWriteTime -lt $DateAgeDelete}

echo "Removing these backups:" | Out-File -Append -FilePath C:\Users\macblade-win\Documents\Scripts\logs\remove-backups.log
echo ($BackupsToDelete).Fullname | Out-File -Append -FilePath C:\Users\macblade-win\Documents\Scripts\logs\remove-backups.log
Remove-Item -Recurse -Force ($BackupsToDelete).FullName



# their code https://www.reddit.com/r/PowerShell/comments/m14efo/newbie_here_how_can_i_check_if_files_older_than_a/
#$DateAgeDelete = (Get-Date).AddDays($BackupMaxAge)
#Write-host "Following Logs will be deleted:"
#Get-ChildItem -Path $BackupLogsDir | Where-Object { $_.LastWriteTime -lt $DateAgeDelete}
#Get-ChildItem -Path $BackupLogsDir | Where-Object { $_.LastWriteTime -lt $DateAgeDelete} | Remove-Item