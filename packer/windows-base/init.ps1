$wrParameters = @{
    Uri = 'https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/AmazonCloudWatchAgent.zip'
    OutFile = "$env:TEMP\AmazonCloudWatchAgent.zip"
}

try { Invoke-WebRequest @wrParameters} 
catch { "Download cloudwatch agent failed." }


try { Expand-Archive -Path "$env:TEMP\AmazonCloudWatchAgent.zip" -DestinationPath "$env:TEMP\AmazonCloudWatchAgent"} 
catch { "Expand Archive failed" }



try { Set-Location -Path "$env:TEMP\AmazonCloudWatchAgent" } 
catch { "Set location failed" }


try { .\install.ps1 } 
catch { "Cloud watch agent installation failed" }



$wr2Parameters = @{
    Uri = 'https://prod-cicdshared-utility-1hzwhron259mj.s3-eu-west-1.amazonaws.com/CloudWatchAgentConfig/agent-config.json'
    OutFile = "C:\Program Files\Amazon\AmazonCloudWatchAgent\agent-config.json"
}


try { Invoke-WebRequest @wr2Parameters} 
catch { "Download cloudwatch agent config file failed." }


$wr3Parameters = @{
    Uri = 'https://prod-cicdshared-utility-1hzwhron259mj.s3-eu-west-1.amazonaws.com/CloudWatchAgentConfig/configureCloudWatch.ps1'
    OutFile = "C:\Program Files\Amazon\AmazonCloudWatchAgent\configureCloudWatch.ps1"
}


try { Invoke-WebRequest @wr3Parameters} 
catch { "Download cloudwatch agent config script." }