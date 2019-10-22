Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install powershell --y
choco install powershell.portable --y
sleep 10s
$PageFile = Get-WmiObject -Query "Select * From Win32_PageFileSetting Where Name='D:\\pagefile.sys'" -EnableAllPrivileges
$PageFile.Delete()
Restart-Computer -ComputerName $env:computername -Force
sleep 120s