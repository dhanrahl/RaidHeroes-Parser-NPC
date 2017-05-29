#Location of Output Folder Path
$FolderPath = "$env:USERPROFILE\Dropbox\Raid Parses"

#Variables for Folder Creation; Currently this creates folders with a "M-dd & M-dd" naming scheme for 2 raid days a week.
$RaidDay = (Get-Date).ToString("M/dd/yyyy")
$RaidDay1 = (Get-Date).ToString("M-dd")
$RaidDay2 = (Get-Date).AddDays(2).ToString("M-dd")
$RaidDayFolder = "$env:USERPROFILE\Dropbox\Raid Parses\$RaidDay1 & $RaidDay2"
$RaidFolder = Get-ChildItem "$env:USERPROFILE\Dropbox\Raid Parses\" | Sort-Object -Property CreationTime | Select-Object -Last 1
$RaidFolderCreation = Get-ChildItem $FolderPath | Where-Object {$_.CreationTime.Date -Match $RaidDay}
$RaidFolderCreation1 = (Get-Date).AddDays(-2).ToString("M/dd/yyyy")
$RaidFolderCreation2 = Get-ChildItem $FolderPath | Where-Object {$_.CreationTime.Date -Match $RaidFolderCreation1} 

#Variable for File Deletion
$TestPathRemove = Test-Path "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\*.evtc"

#Locations of Boss EVTC Logs
$ValeGuardian = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Vale Guardian\*.evtc"
$ValeGuardianCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Vale Guardian\*.evtc" | sort LastWriteTime | select -last 1

$Gorseval = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Gorseval\*.evtc"
$GorsevalCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Gorseval\*.evtc" | sort LastWriteTime | select -last 1

$Sabetha = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Sabetha\*.evtc"
$SabethaCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Sabetha\*.evtc" | sort LastWriteTime | select -last 1

$Slothasor = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Slothasor\*.evtc"
$SlothasorCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Slothasor\*.evtc" | sort LastWriteTime | select -last 1

$Matthias = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Matthias\*.evtc"
$MatthiasCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Matthias\*.evtc" | sort LastWriteTime | select -last 1

$KeepConstruct = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Keep Construct\*.evtc"
$KeepConstructCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Keep Construct\*.evtc" | sort LastWriteTime | select -last 1

$Xera = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Xera\*.evtc"
$XeraCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Xera\*.evtc" | sort LastWriteTime | select -last 1

$Cairn = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Cairn\*.evtc"
$CairnCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Cairn\*.evtc" | sort LastWriteTime | select -last 1

$MursaatOverseer = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Mursaat Overseer\*.evtc"
$MursaatOverseerCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Mursaat Overseer\*.evtc" | sort LastWriteTime | select -last 1

$Samarog = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Samarog\*.evtc"
$SamarogCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Samarog\*.evtc" | sort LastWriteTime | select -last 1

$Deimos = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Deimos\*.evtc"
$DeimosCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\Deimos\*.evtc" | sort LastWriteTime | select -last 1

#Checks location of Raid Folders to see if a folder exists for the two raid days. If no folder is present it will create a folder. Else Find and match the last known folder and set it as $OutputFolder for parsing.

If ($RaidFolder = $RaidFolderCreation2) { #Determined today is RaidDay2, setting directory as $OutputFolder
    New-Variable -ErrorAction Ignore -Name "OutputFolder" -Value (Get-ChildItem -Directory -Path "$env:USERPROFILE\Dropbox\Raid Parses" | Sort-Object -Property CreationTime | select -last 1)
    Write-Host "Successfuly set variable for OutputFolder"
    CD "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\"
}
Else {  
        If ($RaidFolder = $RaidFolderCreation) { #Checks to see if the raid folder that exists is from today, incase of new log file after running the script.
            Write-Host "Failure: Today was not a raid day"
            Pause
            QUIT
        }
        Else { #Determined that there is no folder created for RaidDay1 & RaidDay2, proceed with folder creation and setting directory as $OutputFolder
            New-Item -Path "$env:USERPROFILE\Dropbox\Raid Parses" -Name "$RaidDay1 & $RaidDay2" -ItemType Directory 
            New-Variable -ErrorAction Ignore -Name "OutputFolder" -Value (Get-ChildItem -Directory -Path "$env:USERPROFILE\Dropbox\Raid Parses" | Sort-Object -Property CreationTime | select -last 1)
            Write-Host "Successfully created new parse folder and set OutputFolder variable" 
            CD "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\"
        }
}

#Parsing the logs. Checks the most recent EVTC log and compares to current date.

    if ( (Get-ChildItem $ValeGuardian | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        #If Get-ChildItem returned TRUE, run Get-ChildItem on directory to copy and rename
        Copy-Item -Path $ValeGuardianCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\ValeGuardian.evtc"
        Write-Host "ValeGuardian has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\ValeGuardian.evtc"
        }
    else {
        Write-Host "Vale Guardian was NOT created today"
    }  

    if ( (Get-ChildItem $Gorseval | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        Copy-Item -Path $GorsevalCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Gorseval.evtc"
        Write-Host "Gorseval has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Gorseval.evtc"
        }
    else {
        Write-Host "Gorseval was NOT created today"
    }  

    if ( (Get-ChildItem $Sabetha | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        Copy-Item -Path $SabethaCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Sabetha.evtc"
        Write-Host "Sabetha has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Sabetha.evtc"
        }
    else {
        Write-Host "Sabetha was NOT created today"
    }  

    if ( (Get-ChildItem $Slothasor | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        Copy-Item -Path $SlothasorCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Slothasor.evtc"
        Write-Host "Slothasor has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Slothasor.evtc"
        }
    else {
        Write-Host "Slothasor was NOT created today"
    }  

    if ( (Get-ChildItem $Matthias | sort CreationTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        Copy-Item -Path $MatthiasCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Matthias.evtc"
        Write-Host "Matthias has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Matthias.evtc"
        }
    else {
        Write-Host "Matthias was NOT created today"
    }  

    if ( (Get-ChildItem $KeepConstruct | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        Copy-Item -Path $KeepConstructCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\KeepConstruct.evtc"
        Write-Host "KeepConstruct has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\KeepConstruct.evtc"
        }
    else {
        Write-Host "Keep Construct was NOT created today"
    }  

    if ( (Get-ChildItem $Xera | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        Copy-Item -Path $XeraCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Xera.evtc"
        Write-Host "Xera has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Xera.evtc"
        }
    else {
        Write-Host "Xera was NOT created today"
    }  

    if ( (Get-ChildItem $Cairn | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        Copy-Item -Path $CairnCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Cairn.evtc"
        Write-Host "Cairn has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Cairn.evtc"
        }
    else {
        Write-Host "Cairn was NOT created today"
    }  

    if ( (Get-ChildItem $MursaatOverseer | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        Copy-Item -Path $MursaatOverseerCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\MursaatOverseer.evtc"
        Write-Host "MursaatOverseer has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\MursaatOverseer.evtc"
        }
    else {
        Write-Host "Mursaat Overseer was NOT created today"
    }  

    if ( (Get-ChildItem $Samarog | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        Copy-Item -Path $SamarogCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Samarog.evtc"
        Write-Host "Samarog has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Samarog.evtc"
        }
    else {
        Write-Host "Samarog was NOT created today"
    }  

    if ( (Get-ChildItem $Deimos | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        Copy-Item -Path $DeimosCopy -Destination "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Deimos.evtc"
        Write-Host "Deimos has been modified today and copied to $OutputFolder."
		&'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\Deimos.evtc"
        }
    else {
        Write-Host "Deimos was NOT created today."
    }  

#Renaming log files after being parsed by RaidHeroes.exe

 If (Test-Path $FolderPath\$OutputFolder\ValeGuardian_vg.html) {
    Rename-Item $FolderPath\$OutputFolder\ValeGuardian_vg.html "Vale Guardian.html"
    }
Else {  }

 If (Test-Path $FolderPath\$OutputFolder\Gorseval_gorse.html) {
    Rename-Item $FolderPath\$OutputFolder\Gorseval_gorse.html "Gorseval.html"
    }
Else {  }

 If (Test-Path $FolderPath\$OutputFolder\Sabetha_sab.html) {
    Rename-Item $FolderPath\$OutputFolder\Sabetha_sab.html "Sabetha.html"
    }
Else {  }

 If (Test-Path $FolderPath\$OutputFolder\Slothasor_sloth.html) {
    Rename-Item $FolderPath\$OutputFolder\Slothasor_sloth.html "Slothasor.html"
    }
Else {  }

 If (Test-Path $FolderPath\$OutputFolder\Matthias_matt.html) {
    Rename-Item $FolderPath\$OutputFolder\Matthias_matt.html "Matthias.html"
    }
Else {  }

 If (Test-Path $FolderPath\$OutputFolder\KeepConstruct_kc.html) {
    Rename-Item $FolderPath\$OutputFolder\KeepConstruct_kc.html "Keep Construct.html"
    }
Else {  }

 If (Test-Path $FolderPath\$OutputFolder\Xera_xera.html) {
    Rename-Item $FolderPath\$OutputFolder\Xera_xera.html "Xera.html"
    }
Else {  }

 If (Test-Path $FolderPath\$OutputFolder\Cairn_cairn.html) {
    Rename-Item $FolderPath\$OutputFolder\Cairn_cairn.html "Cairn.html"
    }
Else {  }

 If (Test-Path $FolderPath\$OutputFolder\MursaatOverseer_mo.html) {
    Rename-Item $FolderPath\$OutputFolder\MursaatOverseer_mo.html "Mursaat Overseer.html"
    }
Else {  }

 If (Test-Path $FolderPath\$OutputFolder\Samarog_sam.html) {
    Rename-Item $FolderPath\$OutputFolder\Samarog_sam.html "Samarog.html"
    }
Else {  }

 If (Test-Path $FolderPath\$OutputFolder\Deimos_dei.html) {
    Rename-Item $FolderPath\$OutputFolder\Deimos_dei.html "Deimos.html"
    }
Else {  }

#Variable for File Deletion
$TestPathRemove = Test-Path "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\*.evtc"

If ($TestPathRemove -eq $True){ 
     Remove-Item "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder\*.evtc"
     Write-Host Files have been removed
}
Else { Write-Host No files to remove }

PAUSE