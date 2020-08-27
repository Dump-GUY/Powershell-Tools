Write-Host "##### Folder content comprator HASH MISMATCH #####" -ForegroundColor Green 
Write-Host "##### Compares two folders - shows differences #####`n" -ForegroundColor Green 


[string]$Folder1_Path = Read-Host -Prompt "Folder 1 path"
[string]$Folser2_Path = Read-Host -Prompt "Folder 2 path"


$folder1 = gci -LiteralPath $Folder1_Path -Recurse -File | Get-FileHash -Algorithm MD5
$folder2 = gci -LiteralPath $Folser2_Path -Recurse -File | Get-FileHash -Algorithm MD5


Write-Host "`nThis Hashes-Files are in FOLDER1, but not in FOLDER2:" -ForegroundColor Red
foreach ($hash1 in $folder1.hash){ 

        if ($folder2.hash -notcontains $hash1) {       
        $path = $folder1 | ?{$_.Hash -eq $hash1} | %{$_.Path}
        Write-Host "$hash1   $path"
        }

}

Write-Host "`nThis Hashes-Files are in FOLDER2, but not in FOLDER1:"-ForegroundColor Red

foreach ($hash2 in $folder2.hash){ 

        if ($folder1.hash -notcontains $hash2) {
        $path = $folder2 | ?{$_.Hash -eq $hash2} | %{$_.Path}
        Write-Host "$hash2   $path"
        }

}