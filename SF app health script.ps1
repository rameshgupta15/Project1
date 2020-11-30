Connect-ServiceFabricCluster -ConnectionEndpoint oc-ppe-ppe2-nam-eus-dns-0.eastus.cloudapp.azure.com:19000 -KeepAliveIntervalInSec 10 -X509Credential -ServerCommonName cluster.oc.crmlivetie.com -FindType FindBySubjectName -FindValue cluster.oc.crmlivetie.com -StoreLocation CurrentUser -StoreName My
#to check health of nodes
$nodes = Get-ServiceFabricNode

Foreach($node in $nodes)
{
    Write-Host $node.NodeName
    Write-Host $node.HealthState
}
#to check CPU health
#$Cluster = Get-SCVMHostCluster -Name "oc-prod-public-apj-sea-dns-0.southeastasia.cloudapp.azure.com:19000"
#Get-SCPerformanceData -VMHostCluster $Cluster -PerformanceCounter "MemoryUsage" -Timeframe "Day"

#to check health of services
$applications = Get-ServiceFabricApplication

Foreach($app in $applications)
{
    write-host $app.ApplicationName
    write-host $app.ApplicationTypeVersion
    write-host $app.HealthState

    $services =  Get-ServiceFabricService -ApplicationName $app.ApplicationName

    Foreach($service in $services)
        {
        write-host "  $($service.ServiceName.AbsoluteUri)"
        write-host "  $($service.ServiceManifestVersion)"
        write-host "  $($service.HealthState)"
        }
write-host
}
