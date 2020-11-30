#create folder and copy artifact for services
$ServicesArtifact = @{
'\\usoe.gbl\public\builds\branches\crm.omnichannel.agentservice_release_2009.1\15_0_20317_1_2020_11_12_e4ff5934_release_7206708'= 'ocagt'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.operatinghours_release_2009.1\15_0_20310_1_2020_11_05_fef45736_release_7171489'= 'ocoh'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.agentuiservice_release_2009.1\15_0_20310_2_2020_11_05_3d051007_release_7171487'= 'ocaui'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.analytics_release_2009.1\1_0_014010001_alpha_4590fc9c_7151587'= 'ocanlytc'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.botagentservice_release_2009.1\15_0_20321_1_2020_11_16_c217d11c_release_7222986'= 'ocbas'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.channelconnector_release_2009.1\2020_11_11_b482ad233_release_signed_official_2020_11_11_2_7204151'= 'ocasync'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.channelconnector_release_2009.1\2020_09_20_d95c9ace2_release_signed_official_2020_11_16_1_7222991'= 'occonn'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.chatorchestrator_release_2009.1\2020_11_11_4930e447_release_signed_official_2020_11_11_1_7202753'= 'occhat'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.conversationapi_release_2009.1\15_0_20307_1_2020_11_02_4eb98196_release_7153773'= 'ocapi'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.conversationenrichments_release_2009.1\2020_09_17_1b23e95_release_signed_official_2020_11_05_1_7171479'= 'occonvenrichments'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.customer_release_2009.1\15_0_20310_1_2020_11_05_8f54385e_release_7171478'= 'occus'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.licensing_release_2009.1\15_0_20310_1_2020_11_05_8db37d14_release_7171477'= 'oclic'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.livefeed_release_2009.1\15_0_20316_2_2020_11_11_a14772fd_release_7199572'= 'oclivefeed'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.messaging_release_2009.1\2020_11_11_f529673_release_signed_official_2020_11_16_1_7223009'= 'ocmsg'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.ocprovisioning_release_2009.1\2020_11_23_dbe4af46_release_signed_official_2020_11_23_4_7261630'= 'ocprov'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.presence_release_2009.1\15_0_20317_1_2020_11_12_1ad42e23_release_7206623'= 'ocpres'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.routing_release_2009.1\15_0_20307_1_2020_11_02_7d4e90af_release_7153782'= 'ocroute'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.ruleengine_release_2009.1\15_0_20310_1_2020_11_05_edf882a1_release_7171508'= 'ocrule'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.sentimentanalysis_release_2009.1\2020_11_10_04aabcb_release_signed_official_2020_11_10_2_7192462'= 'ocss'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.skillbasedrouting_release_2009.1\15_0_20310_1_2020_11_05_d1cf074d_release_7171503'= 'ocsbr'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.storage.cdsflush_release_2009.1\15_0_20317_2_2020_11_12_d4e20937_release_7208769'= 'occds'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.storage.dsfsync_release_2009.1\15_0_20317_2_2020_11_12_1632b99d_release_7208855'= 'ocdsf'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.storage.server_release_2009.1\15_0_20317_2_2020_11_12_35d855f8_release_7205992'= 'ocsts'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.telemetry.maservice_release_2009.1\1_0_014040001_alpha_8cb6fca4_7171500'= 'ocma'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.transcript_release_2009.1\15_0_20295_1_2020_10_21_8fe5a16b_release_7095074'= 'octranscript'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.workdistribution_release_2009.1\15_0_20316_1_2020_11_11_c858cf17_release_7199122'= 'ocwds'
 }

Foreach($path in $ServicesArtifact.Keys){
    $destination = $ServicesArtifact[$path]
    $service = New-Item -Path C:\GccServices\2010\$destination\pkg -ItemType directory
    Robocopy.exe /e $path $service
}


#create folder and copy artifact for Blob
$BlobArtifact = @{
'\\usoe.gbl\public\builds\branches\crm.omnichannel.analytics.azurefunctions_release_2009.1\1_0_014040001_alpha_2df34738_7171486' = 'ocazf'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.conversationcontrol_release_2009.1\2020_11_11_2b6cf9a51_release_signed_official_2020_11_11_5_7204333' = 'convctrl'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.livechatwidget_release_2009.1\2020_11_05_8ace8144_release_signed_official_2020_11_05_2_7169167' = 'oclcw'
'\\usoe.gbl\public\builds\branches\crm.omnichannel.productivitytools_release_2009.1\15_0_20332_2_2020_11_27_e8a29b2f_release_7280346' = 'productivitytools'
}

Foreach($blobpath in $BlobArtifact.Keys){
     $blobdest = $BlobArtifact[$blobpath]  
     $blob = New-Item -Path C:\GccServices\2010\$blobdest
     Robocopy.exe /e $blobpath $blob
}