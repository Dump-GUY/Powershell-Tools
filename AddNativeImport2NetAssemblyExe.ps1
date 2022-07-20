#AsmResolver dependency - https://github.com/Washi1337/AsmResolver
#Download release and use net6.0 from Powershell on Windows (Using AsmResolver and PWSH 7.2+ (NET6.0), you can use from different PWSH version but use appropriate AsmResolver)

[System.Reflection.Assembly]::LoadFrom("C:\Users\DFIR_GUY\Desktop\test\net6.0\AsmResolver.DotNet.dll")
[System.Reflection.Assembly]::LoadFrom("C:\Users\DFIR_GUY\Desktop\test\net6.0\AsmResolver.PE.dll")


$dllToAddToIAT = "C:\Users\DFIR_GUY\Desktop\test\ShowMessageBox.dll" #example dll to add to IAT
$symbolNameToImport = [AsmResolver.PE.PEImage]::FromFile($dllToAddToIAT).Exports.Entries[0].Name #example exported func name to add to IAT ex. sleep

$NetModuleToPatch = "C:\Users\DFIR_GUY\Desktop\test\print_string.exe"
$moduleDef = [AsmResolver.DotNet.ModuleDefinition]::FromFile($NetModuleToPatch)
$moduleDef.IsILOnly = $false #patching "IL only" Flag to support native import entry

$patchedModule = $NetModuleToPatch + "_mod.exe"
$moduleDef.Write($patchedModule)

$pebuilder = [AsmResolver.PE.DotNet.Builder.ManagedPEFileBuilder]::new()
$peimage = [AsmResolver.PE.PEImage]::FromFile($patchedModule)

$impmodule= [AsmResolver.PE.Imports.ImportedModule]::new($dllToAddToIAT.Split("\")[-1]) #ShowMessageBox.dll
$symbol = [AsmResolver.PE.Imports.ImportedSymbol]::new(0,$symbolNameToImport) #exported symbol from ShowMessageBox.dll ex. sleep
$impmodule.Symbols.Add($symbol)
$peimage.Imports.Add($impmodule)
$newpe = $pebuilder.CreateFile($peimage)
$newpe.Write($patchedModule)
