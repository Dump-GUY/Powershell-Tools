$cur_PATH = (Get-Location).Path
Write-Host -ForegroundColor Green "Give me folder with all yara rules to merge!"
$Yara_rules_Path = Read-Host -Prompt "PATH"

gci -Path "$Yara_rules_Path" -File  | gc -Encoding Ascii | Out-File -FilePath .\merged.yar -Encoding ascii
Write-Host -ForegroundColor Red "Yara are merged in: $cur_PATH\merged.yar"
