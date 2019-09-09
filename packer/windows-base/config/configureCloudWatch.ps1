Param([parameter(Mandatory=$true)]
   [string]$inputLogGroupName)


$cloudWatchAgentFolder = "C:\Program Files\Amazon\AmazonCloudWatchAgent"
$CloudWatchAgentCtl = "$cloudWatchAgentFolder\amazon-cloudwatch-agent-ctl.ps1"
$cloudwatchConfig = "$cloudWatchAgentFolder\agent-config.json"
$serviceName = "AmazonCloudWatchAgent"
$searchFor= "{LogGroupName}"



#config substitution
((Get-Content -path $cloudwatchConfig -Raw) -replace $searchFor,$inputLogGroupName) | Set-Content -Path $cloudwatchConfig

#pass config to the windows service (starts the service also)
."$CloudWatchAgentCtl" -a fetch-config -m ec2 -c file:"$cloudwatchConfig" -s

#set windows service to have delayed start - non delayed start will fail

cmd.exe /c sc.exe config $serviceName start= delayed-auto  