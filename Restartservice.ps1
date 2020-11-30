$ClusterURL = "oc-test-gccv5-nam-virg-dns-0.usgovvirginia.cloudapp.usgovcloudapi.net:19000"

$ClusterCertThumbprint = "C01E6892018533C742E6E03734EDF6785FF6673F"

$ApplicationName = "fabric:/Microsoft.OmniChannel.DSFSync"

Connect-ServiceFabricCluster -ConnectionEndpoint $ClusterURL -X509Credential -ServerCertThumbprint $ClusterCertThumbprint -FindType FindByThumbprint -FindValue $ClusterCertThumbprint -StoreLocation CurrentUser -StoreName My

Restart-ServiceFabricDeployedCodePackage -NodeName "_gccv5ulto_2" -ApplicationName $ApplicationName -CodePackageName "Code" -ServiceManifestName "DSFClientPkg" -ServicePackageActivationId 0848845c-527a-4e11-a4ff-71f6b3b25cd2 -CommandCompletionMode Verify