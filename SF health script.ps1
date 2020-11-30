$ClusterThumbprint = "2600FDDB297A26D1BF9B3370C8EF4B6ED5DD7B98"
$ClientThumbprint = "8AE28131BABA6ABC80E411E2030B7BA0E8895C15"

Connect-ServiceFabricCluster -ConnectionEndpoint oc-ppe-ppe2-nam-eus-dns-0.eastus.cloudapp.azure.com:19000 -KeepAliveIntervalInSec 10 -X509Credential ServerCertThumbprint $ClusterThumbprint -FindType FindByThumbprint -FindValue $ClientThumbprint -StoreLocation CurrentUser -StoreName My

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