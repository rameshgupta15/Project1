$PAT = "2e4sqiczdxry6t5ihbozmnu2ppcuqx266nnyoaf2npc3g6phuyma"

$BranchName = "master"
$BranchNameToLock = "refs/heads/releases/temp1"
$OutputBranchName = "releases/temp1"
$Tag = "ReadyForOCQE"
Write-Host "Getting tagged build";

#$token = $env:SYSTEM_ACCESSTOKEN

#$headers = @{"Authorization" = "Bearer $token"}
$headers = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "",$PAT)))

# Create Web client - used to downlaod files
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("Authorization", $headers["Authorization"])

$tag = $env:Tag
$queryOrderBy = "finishTimeDescending";
$numberOfBuilds = 1;

$getBuildUrl = ("https://dynamicscrm.visualstudio.com/{0}/_apis/build/builds?definitions={1}&branchName={2}&repositoryId={3}&repositoryType=TfsGit&tagFilters={4}&queryOrder={5}&maxBuildsPerDefinition={6}&resultFilter=succeeded" -f
 $env:RELEASE_ARTIFACTS_OCAGT_CDPX_RELEASE_PROJECTID,
 $env:RELEASE_ARTIFACTS_OCAGT_CDPX_RELEASE_DEFINITIONID,
 ("refs/heads/{0}" -f $env:BRANCHNAME),
 $env:RELEASE_ARTIFACTS_OCAGT_CDPX_RELEASE_REPOSITORY_ID,
 $tag,
 $queryOrderBy,
 $numberOfBuilds); 

    $build= Invoke-RestMethod -Method Get -Headers $headers -Uri $getBuildUrl; 
    Write-Host "Get Build URL: $getBuildUrl";
 $buildId = $build.value[0].sourceVersion;
    Write-Host "buildId : $buildId";

$uri = ("https://dynamicscrm.visualstudio.com/{0}/_apis/git/repositories/{1}/refs?api-version=1.0" -f
 $env:RELEASE_ARTIFACTS_OCAGT_CDPX_RELEASE_PROJECTID,
 $env:RELEASE_ARTIFACTS_OCAGT_CDPX_RELEASE_REPOSITORY_ID);

[array]$requestList = @();
$requestObj = New-Object -TypeName psobject;
$requestObj | Add-Member -MemberType NoteProperty -Name "name" -Value ('refs/heads/{0}' -f $env:OutputBranchName);
$requestObj | Add-Member -MemberType NoteProperty -Name "oldObjectId" -Value "0000000000000000000000000000000000000000";
$requestObj | Add-Member -MemberType NoteProperty -Name "newObjectId" -Value  $buildId;
$requestList += @($requestObj);

$body = ConvertTo-Json -InputObject @($requestList);
Write-Host $body;

$response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $body -ContentType application/json;

Write-Host $response;



#Manually trigger build
Write-Host "Manually trigger build";

$triggerBuildUri =  ("https://dynamicscrm.visualstudio.com/{0}/_apis/build/builds?api-version=4.1" -f
 $env:RELEASE_ARTIFACTS_OCAGT_CDPX_RELEASE_PROJECTID);

Write-Host $triggerBuildUri;

$definition = New-Object -TypeName psobject;
$definition | Add-Member -MemberType NoteProperty -Name "id" -Value $env:RELEASE_ARTIFACTS_OCAGT_CDPX_RELEASE_DEFINITIONID;
$requestObj = New-Object -TypeName psobject;
$requestObj | Add-Member -MemberType NoteProperty -Name "sourceBranch" -Value ('refs/heads/{0}' -f $env:OutputBranchName);
$requestObj | Add-Member -MemberType NoteProperty -Name "definition" -Value $definition;

$triggerBuildBody = $requestObj|ConvertTo-Json   -Depth 100;
Write-Host $triggerBuildBody ;

$triggerBuildResponse= Invoke-RestMethod -Uri $triggerBuildUri -Headers $headers -Method Post -Body $triggerBuildBody -ContentType application/json;

Write-Host $triggerBuildResponse;
