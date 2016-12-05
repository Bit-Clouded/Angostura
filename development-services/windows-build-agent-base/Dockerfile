FROM microsoft/windowsservercore:10.0.14393.447

RUN mkdir c:\workspace
WORKDIR c:\\workspace
ADD ./Install-FromWebWithProcessBlocking.ps1 ./

SHELL ["powershell"]
RUN .\Install-FromWebWithProcessBlocking.ps1 -url "http://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_amd64_en-US.msi"
RUN .\Install-FromWebWithProcessBlocking.ps1 -url "https://nodejs.org/dist/v6.9.1/node-v6.9.1-x64.msi"
RUN .\Install-FromWebWithProcessBlocking.ps1 -url "https://github.com/git-for-windows/git/releases/download/v2.11.0.windows.1/Git-2.11.0-64-bit.exe" -argstrings "/Silent"
RUN .\Install-FromWebWithProcessBlocking.ps1 -url "https://download.microsoft.com/download/E/E/D/EEDF18A8-4AED-4CE0-BEBE-70A83094FC5A/BuildTools_Full.exe" -argstrings "/Silent","/Full"
RUN .\Install-FromWebWithProcessBlocking.ps1 -url "http://download.microsoft.com/download/9/6/0/96075294-6820-4F01-924A-474E0023E407/NDP451-KB2861696-x86-x64-DevPack.exe" -argstrings "/Quiet","/NoRestart"
# Java is needed for both jenkins and gocd
RUN .\Install-FromWebWithProcessBlocking.ps1 -url "http://javadl.oracle.com/webapps/download/AutoDL?BundleId=216434" -filename java-installer.exe -argstrings "STATIC=0","WEB_JAVA=0","/s"
# AWS CLI, duh...
RUN .\Install-FromWebWithProcessBlocking.ps1 -url "http://sdk-for-net.amazonwebservices.com/latest/AWSToolsAndSDKForNet.msi" -argstrings "/qb","/norestart"

# Set PATH
RUN setx PATH '%PATH%;C:\\Program Files (x86)\\MSBuild\\14.0\\Bin\\msbuild.exe;C:\\Program Files (x86)\\Git\\bin;C:\\Program Files\\nodejs'
# Windows Features
RUN Install-WindowsFeature NET-Framework-45-ASPNET,Web-Asp-Net45
# Additional ASP.Net stuff
RUN Invoke-WebRequest "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile "C:\workspace\nuget.exe" -UseBasicParsing  
RUN mkdir -force 'C:\\Program Files (x86)\\MSBuild\\Microsoft\\VisualStudio\\v14.0'; \
    cd 'C:\\Program Files (x86)\\MSBuild\\Microsoft\\VisualStudio\\v14.0'; \ 
    Start-Process -FilePath "C:\workspace\nuget.exe" -ArgumentList "Install","MSBuild.Microsoft.VisualStudio.Web.targets","-Version","14.0.0.3" -PassThru -Wait  
RUN mv \
    'C:\\Program Files (x86)\\MSBuild\\Microsoft\\VisualStudio\\v14.0\\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3\\tools\\VSToolsPath\\*' \
    'C:\\Program Files (x86)\\MSBuild\\Microsoft\\VisualStudio\\v14.0\\'
RUN .'C:\\Program Files\\Microsoft\\Web Platform Installer\\WebPiCmd.exe' /Install /Products:'WDeploy36' /AcceptEULA