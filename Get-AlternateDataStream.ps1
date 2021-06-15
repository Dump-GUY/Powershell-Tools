function Parse_Ads ($ads_content){
    $ZoneID = "null"
    $HostUrl = "null"
    $ReferrerUrl = "null"
    foreach($attrib in $ads_content){
        if ($attrib -like "*ZoneID*"){
            $ZoneID = ($attrib.Split("="))[1]       
        }
        elseif ($attrib -like "*HostUrl*"){
            $HostUrl = ($attrib.Split("="))[1]      
        }
        elseif ($attrib -like "*ReferrerUrl*"){
            $ReferrerUrl = ($attrib.Split("="))[1]       
        }
    }
    return ($ZoneID,$HostUrl,$ReferrerUrl)   
}

function Get-AlternateDataStream
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,

        [Parameter(Mandatory = $false)]
        [switch]$recurse,

        [Parameter(Mandatory = $false)]
        [switch]$Export2CSV
    )
    
    [hashtable]$params = @{ 'Path' = $Path ; 'Recurse' = $recurse }
    $files_ads = Get-ChildItem @params -File | Get-Item -Stream "zone.identifier" -ErrorAction Ignore

    ## read zone info from registry traslate number to name
    [hashtable]$zones = @{}
    Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\*' -name DisplayName | ForEach-Object `
    {
        $zones.Add( $_.PSChildName , $_.DisplayName )
    }

    foreach($file_ads in $files_ads){
        try {
            $ADS_content = Get-Content -Path "$($file_ads.FileName):$($file_ads.Stream)"
            $file = Get-Item -LiteralPath $file_ads.FileName
            $File_path = $file.FullName
            $CreationTime = $file.CreationTime
            $LastWriteTime = $file.LastWriteTime
            $ZoneID,$HostUrl,$ReferrerUrl = Parse_Ads($ADS_content)
            [array]$new_objects += [pscustomobject]@{
                'File' = $File_path; 
                'Zone' = $zones[$ZoneID]; 
                'Referrer URL' = $ReferrerURL; 
                'Host URL' = $HostURL; 
                'Created' = $CreationTime; 
                'Modified' = $LastWriteTime; 
                'Size (KB)' = [int]($file.Length / 1KB)}
        }
        catch {
            continue
        }
    }
    if($Export2CSV){
        $new_objects | Export-Csv -LiteralPath ((Get-Location).path + "\Exported_ADS.csv") -NoTypeInformation 
    }
    $new_objects | Out-GridView -Title "ADS Viewer - Dump-GUY"
}