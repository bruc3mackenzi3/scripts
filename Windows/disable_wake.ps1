<#
Script to disable devices from waking computer.  Useful for changing new or
existing devices from waking computer by default.

To configure to run automatically:
    $trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:30
    Register-ScheduledJob -Trigger $trigger -FilePath C:\Users\BMacK\GitHub\scripts\Windows\disable_wake.ps1 -Name DisableDeviceWake

To view the scheduled job or trigger:
    Get-ScheduledJob DisableDeviceWake
    Get-ScheduledJob DisableDeviceWake | Get-JobTrigger

Test the script by manually enabling a device to wake, e.g.,
    powercfg /deviceenablewake "HID Keyboard Device (006)"
#>

Set-ExecutionPolicy RemoteSigned

$devices=powershell -Command "powercfg /devicequery wake_armed"
if ($devices -eq "NONE") {
    exit
}

foreach ($d in $devices) {
    if ($d -ne "") {
        Write-Host Disabling: $d
        powercfg /devicedisablewake $d
    }
}

if ("NONE" -ne $(powershell -Command "powercfg /devicequery wake_armed")) {
    Write-Host "Failed to disable all devices"
}
else {
    Write-Host "All devices disabled from waking computer"
}
