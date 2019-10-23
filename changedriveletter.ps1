$drive = gwmi win32_volume -Filter "DriveLetter = 'D:'"
$drive.DriveLetter = "Q:"
$drive.Put()
sleep 10S
foreach ($disk in get-wmiobject Win32_DiskDrive -Filter "Partitions = 0"){ 
   $disk.DeviceID
   $disk.Index
   "select disk "+$disk.Index+"`r clean`r create partition primary`r format fs=ntfs unit=65536 quick`r active`r assign letter=D" | diskpart
}
sleep 10s
label D:Data
REG add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagingFiles" /t REG_MULTI_SZ /d "Q:\pagefile.sys 0 0" /f
Restart-Computer -ComputerName $env:computername -Force
sleep 120s
