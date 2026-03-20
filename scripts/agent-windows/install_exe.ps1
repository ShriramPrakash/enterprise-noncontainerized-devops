param(
  [Parameter(Mandatory = $true)][string]$InstallerPath
)

Start-Process -FilePath $InstallerPath -ArgumentList "/VERYSILENT" -Wait
Write-Host "Installer execution completed"
