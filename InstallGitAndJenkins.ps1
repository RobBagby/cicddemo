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