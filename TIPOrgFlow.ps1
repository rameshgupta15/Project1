$username = "v-rapra2@microsoft.com"
$PAT = "7fkug45g54qsiodtujoia7zvqudi4liwgcijucsm4aychabyi5ha"
#$Row = 3574

$Base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "",$PAT)))
#$Base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("{0}:{1}" -f $username,$PAT))

$ReleaseURI = 'https://vsrm.dev.azure.com/dynamicscrm/OneCRM/_apis/release/releases?definitionId=3574&api-version=6.0-preview'
Write-Host $ReleaseURI
$ReleaseData = Invoke-RestMethod -Method Get -Uri $ReleaseURI -Headers @{Authorization=("Basic {0}" -f $Base64AuthInfo)}
Write-Host $ReleaseData

$totalReleases = $ReleaseData.value.Count
Write-Host $totalReleases

$totalInProgress = 0;
for($i=0;$i -lt $totalReleases;$i++){
    $id = $ReleaseData.value[$i].id
    $Releasevalue = "https://vsrm.dev.azure.com/dynamicscrm/onecrm/_apis/release/releases/{0}?$expand=all&api-version=6.0-preview" -f $id
    #Write-Host $Releasevalue
    $response = Invoke-RestMethod -Method Get -Uri $Releasevalue -Headers @{Authorization=("Basic {0}" -f $Base64AuthInfo)}
    #Write-Host $response
    $statusCount = 0;
    $environments = $response.environments
    foreach($env in $environments){
        $status = $env.status
        if($status -eq "inProgress"){
            $statusCount = $statusCount + 1
        }
        $totalInProgress = $totalInprogress + $statusCount
    }
    Write-Host ("testing {0} in-progress: {1} total in-progress {2} " -f $ReleaseData.value[$i].name, $statusCount, $totalInProgress)
}
Write-Host $totalInProgress

<#
foreach($value in $ReleaseData.value){
    $id = ($value.id)
    #$id = $id -as [int]
    Write-Host $id
    $id = [convert]::ToInt32($id)
    $id.GetType()
    $Relesevalue = "https://vsrm.dev.azure.com/dynamicscrm/onecrm/_apis/release/releases/'$id'?$expand=all&api-version=6.0-preview"
    Write-Host $Relesevalue
    $ReleaseData1 = Invoke-RestMethod -Method Get -Uri $Relesevalue -Headers @{Authorization=("Basic {0}" -f $Base64AuthInfo)}
    #Write-Host $ReleaseData1;

}


#$ID = $ReleaseData.value.id
#Write-Host $ID
#for($i=0;$i -lt $Releasescount;$i++)
foreach($i in $Releasescount.)
{
$ID = $ReleaseData.value.id
$Relesevalue = "https://vsrm.dev.azure.com/dynamicscrm/onecrm/_apis/release/releases/'$ID'?$expand=all&api-version=6.0-preview"
Write-Host $Relesevalue
$ReleaseData1 = Invoke-RestMethod -Method Get -Uri $Releasevalue -Headers @{Authorization=("Basic {0}" -f $Base64AuthInfo)}
Write-Host $ReleaseData1
}

#>

