# Create/Update asset
# Banner

Write-Host @"
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⢀⣠⡔⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⡾⣻⡿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣿⠟⢋⣾⣿⠁
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣶⣿⣿⠟⢁⣴⣿⣿⠃⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⡿⠋⠀⣠⣿⣿⣿⠃⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⣿⣿⣿⣿⠟⠋⠀⢠⣾⣿⣿⣿⠃⠀⠀
⠀⠀⠀⠀⢀⣠⣴⣿⣿⣿⣿⣿⣿⠟⠁⠀⢀⣴⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀  _ _______ ______ _               
⠀⠀⠠⣶⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⣠⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀| |__   __|  ____| |              
⠀⠀⠀⠀⠈⠉⠙⠛⠟⠋⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀| |  | |  | |__  | | _____      __
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠻⠿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀| |  | |  |  __| | |/ _ \ \ /\ / /
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡶⠀⠀⠈⠉⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀| |  | |  | |    | | (_) \ V  V / 
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀|_|  |_|  |_|    |_|\___/ \_/\_/  
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"@ -ForegroundColor blue

Write-Host @"
###################################################################
########### Welcome to the ITFlow asset reporter script ###########
###################################################################
"@ -ForegroundColor DarkGreen

# API Key
$apiKey = Read-Host "Please enter the API key"

# Client ID
$ClientID = Read-Host "Please enter the client ID"

# Asset ID
$AssetID = Read-Host "If updating existing asset, Please enter the Asset ID. Otherwise hit Enter"

# Pre URL
$PreURL = "https://"

# Domain/subdomain **UPDATE IT WITH YOUR OWN DOMAIN/SUBDOMAIN**
$siteUrl = "itflow.your-domain.com"

# PC name, for example: DESKTOP-OU4FVQU
$name = (Get-WmiObject win32_computersystem).Name

# Manufacturer
$manufacturer = (Get-WmiObject win32_computersystem).manufacturer

# Model Number
$model = (Get-WmiObject win32_computersystem).model

# Serial Number
$SerialNumber = (Get-WmiObject -class win32_bios).SerialNumber

# Operating System
$OperatinSystem = (Get-WmiObject Win32_OperatingSystem).Caption

# Mac Address | This should work most of the time
$MacAddress = Get-NetAdapter |
Where-Object {$_.Status -eq "Up" -and $_.InterfaceDescription -notlike "*Virtual*" -and $_.Speed -gt 0} |
Sort-Object -Property Speed -Descending |
Select-Object -First 1 -ExpandProperty MacAddress

# type desktop/laptop/server
$type = ""
$systemType = (Get-WmiObject -Class win32_systemenclosure).SecurityStatus
 
if ($systemType -eq 0) {
$type = "Other"
}
elseif ($systemType -eq 1) {
$type = "Desktop"
}
elseif ($systemType -eq 2) {
$type = "Laptop"
}
elseif ($systemType -eq 3) {
$type = "Desktop"
}
elseif ($systemType -eq 4) {
$type = "Server"
}
elseif ($systemType -eq 5) {
$type = "Server"
}
elseif ($systemType -eq 6) {
$type = "Desktop"
}
elseif ($systemType -eq 7) {
$type = "Server"
}
elseif ($systemType -eq 8) {
$type = "Other"
}
else {
$type = "Other"
}


# Data
$body = @"
{
    "api_key" : "$apiKey",
    "asset_id" : "$AssetID",
    "asset_name" : "$name",
    "asset_type" : "$type",
    "asset_make" : "$manufacturer",
    "asset_model" : "$model",
    "asset_serial" : "$SerialNumber",
    "asset_os" : "$OperatinSystem",
    "asset_ip" : "",
    "asset_mac" : "$MacAddress",
    "asset_status" : "Deployed",
    "asset_purchase_date" : "",
    "asset_warranty_expire" : "",
    "asset_install_date" : "",
    "asset_notes" : "",
    "asset_vendor_id" : "",
    "asset_location_id" : "",
    "asset_contact_id" : "",
    "asset_network_id" : "",
    "client_id" : "$ClientID"
}
"@

# Module / Endpoint
if ($AssetID -eq "") {
$module = "/api/v1/assets/create.php"
}
else {
$module = "/api/v1/assets/update.php"
}


# Build URI from defined data
$uri = $PreURL + $SiteUrl + $module

# Request
Invoke-WebRequest -Method Post -Uri $uri -Body $body

Write-host "The info of this $type has been uploaded to $SiteUrl successfully!" -ForegroundColor Green
Read-Host "Press Enter to close"
