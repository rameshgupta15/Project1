#create folders for services
$ServicesArtifact = "
\\usoe.gbl\public\builds\branches\crm.omnichannel.agentservice_release_2009.1\15_0_20317_1_2020_11_12_e4ff5934_release_7206708\outputs\build\TeDCServiceFabricArtifact,
\usoe.gbl\public\builds\branches\crm.omnichannel.operatinghours_release_2009.1\15_0_20310_1_2020_11_05_fef45736_release_7171489\outputs\build\TeDCServiceFabricArtifact
"
# check if $ServicesArtifact and $services size/length are equal.

#for($i=0; $i -le $ServicesArtifact.Length; $i++){
#    $SA = $ServicesArtifact[$i]
#    $service = $services[$i]
#}
$ServicesArtifact = $ServicesArtifact.Replace(" ","").Split(",")
$services = "ocagt,ocoh,ocaui,ocanlytc,ocbas,ocasync,occonn,occhat,ocapi,occonvenrichments,occus,oclic,oclivefeed,ocmsg,ocprov,ocpres,ocroute,ocrule,ocss,ocsbr,occds,ocdsf,ocsts,ocma,octranscript,ocwds"
$services = $services.Replace(" ","").Split(",")






Foreach($i in $services){
    New-Item -Path C:\GccServices\2010\$i\pkg -ItemType directory
    Foreach ($k in $ServicesArtifact){
        Robocopy.exe /e $k C:\GccServices\2010\$i\pkg
    }
}
#create folders for blob
$BlobArtifact = ""
$BlobArtifact = $BlobArtifact.Replace(" ","").Split(",")
$blob = "ocazf,convctrl,oclcw,productivitytools"
$blob = $blob.Replace(" ","").Split(",")
Foreach($j in $blob){
    New-Item -Path C:\GccServices\2010\$j -ItemType directory
    Foreach ($l in $ServicesArtifact){
        Robocopy.exe /e $l C:\GccServices\2010\$j
    }
}
