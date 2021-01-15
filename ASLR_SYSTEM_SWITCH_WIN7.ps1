#Requires -RunAsAdministrator

Function Restart-PC
{
$input = Read-Host -Prompt "To finish SYSTEM ASLR changes, restart need. Do you want to restart computer now?(yes/no)"
        if($input -like "*yes*"){
        Restart-Computer -Force
        }
        else {
        Continue
        }
}

Function Test-RegistryValue
{
param([string]$RegKeyPath,[string]$Value)
$ValueExist = (Get-ItemProperty $RegKeyPath).$Value -ne $null
Return $ValueExist
}

Write-Host "------------------------------SYSTEM ASLR SWITCHER------------------------------" -ForegroundColor Green
Write-Host "Supported Windows 7" -ForegroundColor Green

#win7
if(([Environment]::OSVersion.Version.Major -eq 6) -and ([Environment]::OSVersion.Version.Minor -eq 1)){
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
$Value_name = "MoveImages"
$value = 0

if(Test-RegistryValue -RegKeyPath $registryPath -Value $Value_name){
    $current_value = Get-ItemProperty -Path $registryPath -Name $Value_name
    if($current_value.MoveImages -eq 0){
        Write-Host "SYSTEM ASLR - Already DISABLED" -ForegroundColor Red     
        $input = Read-Host -Prompt "Do you want to ENABLE SYSTEM ASLR?(yes/no)"
        if($input -like "*yes*"){
            Remove-ItemProperty -Path $registryPath -Name $Value_name -Force | Out-Null
            Write-Host "SYSTEM ASLR ENABLED" -ForegroundColor Green
            Restart-PC
        }                 
    }

    else{
        Write-Host "SYSTEM ASLR - Already set to another option than DISABLED/ENABLED" -ForegroundColor Red
        $input = Read-Host -Prompt "Do you want to DISABLE SYSTEM ASLR?(yes/no)"
        if($input -like "*yes*"){
            Set-ItemProperty -Path $registryPath -Name $Value_name -Value $value -Force | Out-Null
            Write-Host "SYSTEM ASLR DISABLED" -ForegroundColor Green
            Restart-PC
        }
    }
}

else{
    Write-Host "SYSTEM ASLR IS ENABLED" -ForegroundColor Red
    $input = Read-Host -Prompt "Do you want to DISABLE SYSTEM ASLR?(yes/no)"
    if($input -like "*yes*"){
        New-ItemProperty -Path $registryPath -Name $Value_name -Value $value -PropertyType DWORD  -Force | Out-Null
        Write-Host "SYSTEM ASLR DISABLED" -ForegroundColor Green
        Restart-PC
    }
}
}


#unsupported
else{
Write-Host "Only Windows 7 is supported !!!" -ForegroundColor Red
}
