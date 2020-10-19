<#
Script to disable devices from waking computer.  Useful for changing new or
existing devices from waking computer by default.

To configure to run automatically:
    $trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:30
    Register-ScheduledJob -Trigger $trigger -FilePath C:\Users\BMacK\repos\scripts\Windows\disable_wake.ps1 -Name DisableDeviceWake

To view the scheduled job or trigger:
    Get-ScheduledJob DisableDeviceWake
    Get-ScheduledJob DisableDeviceWake | Get-JobTrigger

Test the script by manually enabling a device to wake, e.g.,
    powercfg /deviceenablewake "HID Keyboard Device (006)"

Logs:
    C:\Users\BMacK\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\DisableDeviceWake
#>

Set-ExecutionPolicy RemoteSigned

# Write-Output "Running DisableDeviceWake" | Out-File -FilePath C:\Users\BMacK\DisableDeviceWake.log

$devices=powershell -Command "powercfg /devicequery wake_armed"
if ($devices -eq "NONE") {
    Write-Output "No devices to disable. Exiting."
    exit
}

foreach ($d in $devices) {
    if ($d -ne "") {
        Write-Output "Disabling: $d"
        powercfg /devicedisablewake $d
    }
}

if ("NONE" -ne $(powershell -Command "powercfg /devicequery wake_armed")) {
    Write-Output "Failed to disable all devices"
}
else {
    Write-Output "All devices disabled from waking computer"
}
