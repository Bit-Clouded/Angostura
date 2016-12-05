param(
    [string]$url,
    [string[]]$argstrings = "/qn",
    [string]$filename
)

if ([string]::IsNullOrWhiteSpace($filename)) {
    $urlSegments = $url.Split('/')
    $filename = $urlSegments[$urlSegments.Count - 1]
}
$fullpath = "$env:TEMP\$filename"
Invoke-WebRequest $url -OutFile $fullpath
Start-Process -FilePath $fullpath -ArgumentList $argstrings -PassThru -Wait
Remove-Item $fullpath -Force