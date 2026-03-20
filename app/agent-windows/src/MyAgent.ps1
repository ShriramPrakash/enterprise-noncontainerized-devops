$log = "C:\ProgramData\MyAgent\myagent.log"
$dir = Split-Path $log
if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}
Add-Content -Path $log -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - MyAgent heartbeat"
