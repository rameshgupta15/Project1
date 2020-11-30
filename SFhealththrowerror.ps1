#checking node and app health
Connect-ServiceFabricCluster -ConnectionEndpoint oc-ppe-ppe2-nam-wus-dns-0.westus2.cloudapp.azure.com:19000 -KeepAliveIntervalInSec 10 -X509Credential -ServerCommonName service.oc.crmlivetie.com -FindType FindBySubjectName -FindValue cluster.oc.crmlivetie.com -StoreLocation CurrentUser -StoreName My
#to check health of nodes
$nodeerror = "One or more nodes are either in Warning or in Error state, please apply fix"
$nodeFlag = "False"
$nodes = Get-ServiceFabricNode
$count = 0
Foreach($node in $nodes)
{
    Write-Host $node.NodeName
    Write-Host $node.HealthState
    $count += 1
    if($node.HealthState -eq "Error" -or $node.HealthState -eq "Warning"){
            $nodeFlag = "True"
            $errorednodes = $node.NodeName
            $healthnodes = $node.HealthState    
            #Write-Host Warning or error nodes are: $node.NodeName
            #throw $nodeerror
            #Write-Error $nodeerror
        }
    
}

Write-Host "Total number of nodes: $count"
#to check health of services
$count1 = 0
$Serviceseror = "One or more services are either in Warning or Error state, please apply fix"
$serviceflag = "False"
$applications = Get-ServiceFabricApplication

Foreach($app in $applications)
{
write-host $app.ApplicationName
write-host $app.ApplicationTypeVersion
write-host $app.HealthState
$count1 += 1
if($app.HealthState -eq "Error" -or $app.HealthState -eq "Warning"){
        $serviceflag = "True"
        $erroredservice = $app.ApplicationName
        $erroredhealth = $app.HealthState
        #Write-Host Warning or errored serices are : $app.ApplicationName
        #throw $Serviceseror
        #Write-Error $Serviceseror
    }

$services =  Get-ServiceFabricService -ApplicationName $app.ApplicationName

        Foreach($service in $services)
        {
        write-host "  $($service.ServiceName.AbsoluteUri)"
        write-host "  $($service.ServiceManifestVersion)"
        write-host "  $($service.HealthState)"
        }
write-host
}

Write-Host "Total number of services: $count1"
Write-Host "Error or warning nodes: $errorednodes "
Write-Host $healthnodes
if($nodeFlag -eq "True"){
    throw $nodeerror
    Write-Error $nodeerror
}

Write-Host "Error or warning services: $erroredservice "
Write-Host $erroredhealth
if($serviceflag -eq "True"){
    throw $Serviceseror
    Write-Error $Serviceseror
}