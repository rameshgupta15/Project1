#create the new release
$PAT = "oyv6sxjey67yuyec7pdyzkmiuzyol6l6ibcmtyug7cw57nydgcoq"
$releaseDefinationId = 4515

$Base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "",$PAT)))
$releasemetadata =
                  @{
            definitionId=$releaseDefinationId
            name= "OCDailyM Automation - Demo"
            environments= 
    {
      name= "OCDailymIntegration_ServiceIntegration_Selenium_Playwright"}
            reason="schedule"
            isDraft= "false"
            description=$releaseComment
            manualEnvironments= "null"
                  }

$body = $releasemetadata | ConvertTo-Json -Depth 5


#$uri = "https://vsrm.dev.azure.com/dynamicscrm/OneCRM/_apis/Release/definitions/{0}?api-version=5.1" -f $releaseDefinationId

$uri = "https://vsrm.dev.azure.com/dynamicscrm/OneCRM/_apis/release/releases?api-version=6.0"
Write-Host "URL: $uri"
$result = Invoke-RestMethod -Uri $uri -Method POST -ContentType "application/json" -Body $body -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}
#Write-Host $result
$releaseID = $result.id
Write-Host "Release: $releaseID created successfully "


#Trigger the newly created release
$Releaseurl= "https://vsrm.dev.azure.com/dynamicscrm/OneCRM/_apis/Release/releases/$releaseID" 
Write-Host $Releaseurl
$releaseresponse = Invoke-RestMethod -Method Get -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -ContentType application/json -Uri $Releaseurl
#$name = $releaseresponse.environments.name;
#Write-Host $name

$firstEnvironment = $releaseresponse.environments.id;
Write-Host " Id for Release Stage is :"+  $firstEnvironment



#Create the JSON body for the deployment:

$deploymentbody = @" 
{"status": "inprogress"} 
"@

#Invoke the REST method to deploy the release:
#$DeployUrl = "https://vsrm.dev.azure.com/dynamicscrm/OneCRM/_apis/Release/releases/$releaseID/environments/$firstEnvironment?api-version=6.0-preview.6"
$DeployUrl = "https://vsrm.dev.azure.com/dynamicscrm/OneCRM/_apis/release/releases/$releaseID/environments/"+$firstEnvironment+"?api-version=3.2-preview"  
$DeployRelease = Invoke-RestMethod -Method Patch -ContentType application/json -Uri $DeployUrl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Body $deploymentbody


write-host "Request submitted for Running Release: $releaseID "

