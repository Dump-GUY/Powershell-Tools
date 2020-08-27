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


# yara_rule_marger - simply yara rules merger
Run script and input source folder with yara rules.
In PATH where script is running new file "merged.yar" is created.


# HASH_MISMATCHER - Folders content comprator
Compares two folders - shows differences - HASH MISMATCH.
