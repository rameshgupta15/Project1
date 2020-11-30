Param (
$PAT = "ax6wpu33g6ixr7kasym37uhj2wzvwzahkmgojrlvc5we7hqgxyja"
)
#$List = "$(PendingBranchCutRepoList)"
#$List = $List.Replace(" ","").Split(",")
$List = "ocapi_Release"
Function CreateBug($repoName)
{
    #Logic to create a bug
    $Year  = (Get-Date).Year
    $Month = (Get-Culture).DateTimeFormat.GetMonthName((Get-Date).Month)
    $currentMonth = Get-Date -UFormat %m
    $YearForMonth = $Year.ToString().Substring(0,2)
    $IterationPath = "OneCRM\\Train\\$Year\\$YearForMonth"+$currentMonth
    $Title = "Pending build for the month, year of " + $Month + "," + $Year + " during branch cut "+ "for the repo " + $repoName
    $Base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "",$PAT)))
    $URI= 'https://dynamicscrm.visualstudio.com/DefaultCollection/OneCRM/_apis/wit/workitems/$bug?api-version=6.0'
    $AreaPath = 'OneCRM\\CRM\\Service\\OmniChannel\\Horizontal Pillars'
    $BugIssueType = "Environment Issue"
    $HowFound = "Health Monitoring"
    $Regression = "No"
    $Release = "Internal"
    $body="[
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.Title`",
    `"value`": `"$($Title)`"
  },{
    `"op`": `"add`",
    `"path`": `"/fields/CRMAgile.BugIssueType`",
    `"value`": `"$($BugIssueType)`"
  },{
    `"op`": `"add`",
    `"path`": `"/fields/CRMAgile.HowFoundCategory`",
    `"value`": `"$($HowFound)`"
  },{
    `"op`": `"add`",
    `"path`": `"/fields/Microsoft.VSTS.Common.Regression`",
    `"value`": `"$($Regression)`"
  },{
    `"op`": `"add`",
    `"path`": `"/fields/System.AreaPath`",
    `"value`": `'$($AreaPath)`'
  },{
    `"op`": `"add`",
    `"path`": `"/fields/System.IterationPath`",
    `"value`": `"$($IterationPath)`"
  },{
    `"op`": `"add`",
    `"path`": `"/fields/CRMAgile.Release`",
    `"value`": `"$($Release)`"
  }
]"
    $result= Invoke-RestMethod -Uri $URI -Method PATCH -Body $body -ContentType "application/json-patch+json" -Headers @{Authorization=("Basic {0}" -f $Base64AuthInfo)}
    Start-Sleep -Seconds 10
    $BugId = $result.id
    Write-Host "Bug $BugId created for build $repoName"   
}
Write-Host $result
foreach($Repo in $List)
{
    $Repo
    #Call create bug function
    CreateBug -repoName $Repo
}