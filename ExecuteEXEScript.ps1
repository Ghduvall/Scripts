#GUI Program for running .exe emulators

Add-Type -AssemblyName PresentationCore, PresentationFramework


$global:pspID = "fist assign"

#Used for closing application
$currentPID = $PID
echo $currentPID

function openDolphinGameCube {
    cd "C:\Users\EmuMac\Documents\Emulators\Dolphin-5.0-14344-x64\"
    .\Dolphin.exe
    cd C:\
}

function openPS2 {
    cd "C:\Program Files (x86)\PCSX2\"
    .\pcsx2.exe
    cd C:\
}

function openSuperNintendo {
    cd "C:\Users\EmuMac\Documents\Emulators\bsnes_v115-windows\"
    .\bsnes.exe
    cd C:\
}

function openGameBoyAdvance {
    cd "C:\Program Files\mGBA"
    .\mGBA.exe
    cd C:\
}

function openPS3 {
    cd "C:\Users\EmuMac\Documents\Emulators\ps3emu\"
    $ps3 = [Diagnostics.Process]::Start("C:\Users\EmuMac\Documents\Emulators\ps3emu\rpcs3.exe")
    $ps3ID = $ps3.id
    Write-Host "$ps3 Process created. Process id is $pspID" 
    cd C:\
}



function openPSP{
    cd "C:\Program Files\PPSSPP\"
    $psp = [Diagnostics.Process]::Start("C:\Program Files\PPSSPP\PPSSPPWindows64.exe")
    $pspID = $psp.id
    Write-Host "$psp Process created. Process id is $pspID" 
    cd C:\
}



$xamlFile = "C:\Users\EmuMac\source\repos\ExecuteEXE-APP\ExecuteEXE-APP\MainWindow.xaml"

#creating window
$inputXML = Get-Content $xamlFile -Raw
$inputXML = $inputXML -replace 'mc:Ignorable="d"', '' -replace "x:N", 'N' -replace '^<Win.*', '<Window'
[XML]$XAML = $inputXML

#Read XAML
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
try {
    $window = [Windows.Markup.XamlReader]::Load( $reader )
} catch {
    Write-Warning $_.Exception
    throw
}

# Create variables based on form control names.
# Variable will be named as 'var_<control name>'


$xaml.SelectNodes("//*[@Name]") | ForEach-Object {
    #"trying item $($_.Name)"
    try {
        Set-Variable -Name "var_$($_.Name)" -Value $window.FindName($_.Name) -ErrorAction Stop
    } catch {
        throw
    }
}
Get-Variable var_*




function checkBluetoothController{
    $var_txtOutputBox.text = ""
    $deviceController = Get-PnpDevice | Where-Object {$_.Class -eq "Bluetooth" -and $_.FriendlyName -eq "Wireless Controller"}
    Write-Host ($deviceController | Format-Table | Out-String)
    $var_txtOutputBox.text = ($deviceController | Format-Table | Out-String)
}
function enableBluetoothController{
    #$var_txtOutputBox.text = ""
    Enable-PnpDevice -InstanceId $deviceController.InstanceId -Confirm:$false
    $deviceController = Get-PnpDevice | Where-Object {$_.Class -eq "Bluetooth" -and $_.FriendlyName -eq "Wireless Controller"}
    Write-Host ($deviceController | Format-Table | Out-String)
    $var_txtOutputBox.text = ($deviceController | Format-Table | Out-String)
}
function disableBluetoothController{
    #$var_txtOutputBox.text = ""
    $deviceController = Get-PnpDevice | Where-Object {$_.Class -eq "Bluetooth" -and $_.FriendlyName -eq "Wireless Controller"}
    Disable-PnpDevice -InstanceId $deviceController.InstanceId -Confirm:$false
    Write-Host ($deviceController | Format-Table | Out-String)
    $var_txtOutputBox.text = ($deviceController | Format-Table | Out-String)
}


function exitApp{
    Stop-Process -id $currentPID
}

function exitPSP{
    #$test = openPSP 1
    try{ 
        Stop-Process -Name PPSSPPWindows64 -ErrorAction Stop
        Write-Host "Process stopped"  
    } catch { 
        Write-Host "The Process did not stop"
    }
    
}


function exitPS3{
    try{ 
        Stop-Process -Name rpcs3 -ErrorAction Stop
        Write-Host "Process stopped"  
    } catch { 
        Write-Host "The Process did not stop"
    }
    
}

function exitPS2{
    try{ 
        Stop-Process -Name pcsx2 -ErrorAction Stop
        Write-Host "Process stopped"  
    } catch { 
        Write-Host "The Process did not stop"
    }
    
}

function exitSNES{
    try{ 
        Stop-Process -Name bsnes -ErrorAction Stop
        Write-Host "Process stopped"  
    } catch { 
        Write-Host "The Process did not stop"
    }
    
}

function exitGBA{
    try{ 
        Stop-Process -Name mGBA -ErrorAction Stop
        Write-Host "Process stopped"  
    } catch { 
        Write-Host "The Process did not stop"
    }
    
}

function exitGC{
    try{ 
        Stop-Process -Name Dolphin -ErrorAction Stop
        Write-Host "Process stopped"  
    } catch { 
        Write-Host "The Process did not stop"
    }
    
}


$var_btnSNES.Add_Click( {
       openSuperNintendo      
   })
$var_btnPS2.Add_Click( {
       openPS2      
   })
$var_btnPSP.Add_Click( {
       openPSP 
   })
$var_btnGC.Add_Click( {
       openDolphinGameCube      
   })
$var_btnGBA.Add_Click( {
       openGameBoyAdvance      
   })
$var_btnPS3.Add_Click( {
       openPS3
   })
$var_btnExit.Add_Click( {
       exitApp
   })



$var_btnExitPSP.Add_Click( {
       exitPSP
   })
$var_btnExitPS3.Add_Click( {
       exitPS3
   })
$var_btnExitPS2.Add_Click( {
       exitPS2
   })
$var_btnExitSNES.Add_Click( {
       exitSNES
   })
$var_btnExitGC.Add_Click( {
       exitGC
   })
$var_btnExitGBA.Add_Click( {
       exitGBA
   })





$var_btnCheckBluetoothController.Add_Click( {
       checkBluetoothController
   })
$var_btnEnableBluetoothController.Add_Click( {
       enableBluetoothController
   })
$var_btnDisableBluetoothController.Add_Click( {
       disableBluetoothController
   })





$Null = $window.ShowDialog()