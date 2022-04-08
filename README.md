# PSUnzipper - PowerShell Unzipper  
Uses SharpZipLiB in .NET, loaded in runtime (no file on disk) - ref. https://github.com/icsharpcode/SharpZipLib  
Can be used with password (zip, unzip)  
Both encryption methods AES and ZipCrypto is supported.
When zipping/unzipping - no file in temp is created - all running in memory.



# McAfee_DEBUP - Recreates McAfee quarantined file
Written in powershell and compiled to exe with GUI.  
Uses openmcdf .net dll for work with ole files - ref. https://github.com/ironfede/openmcdf  
These kind of files have .bup extension and in fact they are actually type of ole file. 
BUP file contains two streams: Details and File_0. Details is the McAfee anti-virus report, and File_0 is the quarantined file. Remark that quarantined files can contain more than one quarantined file.  
Streams are XOR encoded. The key is 0x6A.  


# yara_rule_merger - simply yara rules merger
Run script and input source folder with yara rules.
In PATH where script is running new file "merged.yar" is created.


# HASH_MISMATCHER - Folders content comprator
Compares two folders - shows differences - HASH MISMATCH.


# ASLR_SYSTEM_SWITCH_WIN7 - Simply SYSTEM ASLR switcher (on/off) for WIN7
There are situations during malware analysis, where you find quite useful to have
SYSTEM ASLR disabled. For example you need to all dlls be loaded according to
imagebase in optional header. In such situation, to get modules loaded in process space everytime on their imagebase, the system ASLR has to be disabled.
Another adavantage to have SYSTEM ASLR disabled is that the main module (your sample) ASLR settings (Optionl header --> Dll Characteristics --> Dll can move) will be ignored too (disabled) so you do not have to patch it.
PS version > 4.0

# Get-AlternateDataStream - Find files with ADS "zone.identifier"
This tool is simple PSModule which is able to find files with Alternate Data Stream "zone.identifier".<br/>
It will parse the ADS and show all related info and some info about files in GridView.<br/>
Possilble options:<br/>
-recurse (Search files recursively)<br/>
-path (Start path to search files)<br/>
-Export2CVS (Export table to CSV into current directory)<br/>
Example:<br/>
Import-Module .\Get-AlternateDataStream.ps1<br/>
Get-AlternateDataStream -Path ..\..\Downloads\ -recurse -Export2CSV<br/>

Requirements:<br/>
Windows OS<br/>
PowerShell Core or Windows Powershell<br/>


# SpecialFoldersView_CSIDL_Oneliner
Simple one-liner to obtain NAME, FOLDER_PATH and CSIDL.


# Invoke-DetectItEasy
Invoke-DetectItEasy is a powershell module and wrapper for excellent tool called Detect-It-Easy. It is very useful for Threat Hunting and Forensics.<br/>
LINK: https://github.com/Dump-GUY/Invoke-DetectItEasy


# Get-PDInvokeImports
Get-PDInvokeImports is tool (PowerShell module) which is able to perform automatic detection of P/Invoke, Dynamic P/Invoke and D/Invoke usage in assembly. Showing all locations from where they are referenced and Exports all to DnSpy_Bookmarks.xml<br/>
LINK: https://github.com/Dump-GUY/Get-PDInvokeImports
