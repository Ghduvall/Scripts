$scriptblock = {
    $IniFiles = Get-ChildItem "$ENV:LOCALAPPDATA\Microsoft\OneDrive\settings\Business1" -Filter 'ClientPolicy*' -ErrorAction SilentlyContinue
    
    if (!$IniFiles) {
    write-host 'No Onedrive configuration files found. Stopping script.'
    exit 1
    }
    
    $SyncedLibraries = foreach ($inifile in $IniFiles) {
        $IniContent = get-content $inifile.fullname -Encoding Unicode
        [PSCustomObject]@{
            'Item Count' = ($IniContent | Where-Object { $_ -like 'ItemCount*' }) -split '= ' | Select-Object -last 1
            'Site Name'  = ($IniContent | Where-Object { $_ -like 'SiteTitle*' }) -split '= ' | Select-Object -last 1
            'Site URL'   = ($IniContent | Where-Object { $_ -like 'DavUrlNamespace*' }) -split '= ' | Select-Object -last 1
        }
    }
    $SyncedLibraries | ConvertTo-Json | Out-File 'C:\programdata\Microsoft OneDrive\OneDriveLibraries.txt'
    }
    try{
    Invoke-AsCurrentUser -scriptblock $scriptblock
    } catch{
    write-error "Something went wrong"
    }
    start-sleep 2 #Sleeping 2 seconds to allow script to write to disk.
    $SyncedLibraries = (get-content "C:\programdata\Microsoft OneDrive\OneDriveLibraries.txt" | convertfrom-json)
    if (($SyncedLibraries.'Item count' | Measure-Object -Sum).sum -gt '280000') {
    write-host "Unhealthy - Currently syncing more than 280k files. Please investigate."
    $SyncedLibraries
    }
    else {
    write-host "Healthy - Syncing less than 280k files."
    }
    