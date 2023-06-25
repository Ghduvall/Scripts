#save server files manually


$ServerName = "MinecraftServerVanillaJava"
$OriginPath = "C:\Users\macblade-win\Documents\Server_Files"
$CopyPath = "C:\FULL\" + $ServerName + "_$(get-date -f yy-MM-dd--HH.mm.ss)"


Copy-Item $OriginPath -Filter * -Destination $CopyPath -Recurse



#Set up task scheduler to run automagicly https://community.spiceworks.com/how_to/17736-run-powershell-scripts-from-task-scheduler