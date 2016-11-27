Invoke-Webrequest "https://github.com/git-for-windows/git/releases/download/v2.7.2.windows.1/Git-2.7.2-64-bit.exe" -OutFile git.exe -UseBasicParsing
Start-Process git.exe -ArgumentList '/VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS /DIR=c:\git\' -Wait
Remove-Item -Force git.exe
setx /M PATH "$Env:Path;c:\git\cmd"

Invoke-Webrequest "http://mirrors.jenkins-ci.org/windows/latest" -OutFile jenkins.zip -UseBasicParsing

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

$currentPath = Convert-Path(".")
$sourcePath = "$currentPath\jenkins.zip"
Unzip $sourcePath "$currentPath"

Start-Process jenkins.msi -ArgumentList '/quiet /passive' -Wait

New-Item -ItemType Directory -Force -Path "C:\Program Files (x86)\Jenkins\jobs\sampleapp"
Invoke-WebRequest "https://raw.githubusercontent.com/RobBagby/cicddemo/master/jenkinsconfig/sampleapp/config.xml" -OutFile "C:\Program Files (x86)\Jenkins\jobs\sampleappconfig.xml" -UseBasicParsing

New-NetFirewallRule -DisplayName 'Jenkins Inbound' -Profile @('Domain', 'Private', 'Public') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('8080', '50000')

Restart-Service -Name Jenkins

Invoke-Webrequest https://github.com/docker/compose/releases/download/1.9.0/docker-compose-Windows-x86_64.exe -OutFile $Env:Programfiles\docker\docker-compose.exe