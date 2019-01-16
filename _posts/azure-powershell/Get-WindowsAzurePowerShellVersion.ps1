function Get-WindowsAzurePowerShellVersion
{
[CmdletBinding()]
Param ()
 
## - Section to query local system for Windows Azure PowerShell version already installed:
Write-Host "Windows Azure PowerShell Installed version: "

(Get-Module -ListAvailable | Where-Object{ $_.Name -eq 'Azure' }) |
    Select Version, Name, Author |
    Format-List;
}

Get-WindowsAzurePowerShellVersion