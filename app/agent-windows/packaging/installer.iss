[Setup]
AppName=MyAgent
AppVersion=1.0.0
DefaultDirName={pf}\MyAgent
DefaultGroupName=MyAgent
OutputDir=output
OutputBaseFilename=MyAgentSetup
Compression=lzma
SolidCompression=yes

[Files]
Source: "..\src\MyAgent.ps1"; DestDir: "{app}"; Flags: ignoreversion

[Run]
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\MyAgent.ps1"""; Flags: runhidden
