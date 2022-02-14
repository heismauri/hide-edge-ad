# Open a new PS window if not openned as administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
  Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File $PSCommandPath" -Verb RunAs
  Exit
}

Write-Host "Hiding 'Web browsing: Restore recommended' suggestion in Control Panel."

# Get ViveTool's latest release
$ViVeToolGitHub = Invoke-WebRequest -Uri "https://api.github.com/repos/thebookisclosed/ViVe/releases/latest"
$ViVeToolResponse = ConvertFrom-Json $([String]::new($ViVeToolGitHub.Content))
$ViVeToolUrl = $ViVeToolResponse.assets.browser_download_url

# Downloading and unzipping the tool
Import-Module BitsTransfer
Start-BitsTransfer -Source $ViVeToolUrl -Destination ViVeTool.zip
Expand-Archive ViVeTool.zip

# Disabling Edge ad
./ViVeTool/ViVeTool.exe addconfig 23531064 1 | Out-Null

# Deleting ViVeTool
Remove-Item ViVeTool -Recurse
Remove-Item ViVeTool.zip

Write-Host "Hidden 'Web browsing: Restore recommended' suggestion in Control Panel."
