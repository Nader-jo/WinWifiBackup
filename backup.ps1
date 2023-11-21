netsh wlan export profile key=clear
# First, search for 'keyMaterial' in files and redirect output to 'Wi-Fi-PASS'
Select-String -Path $env:temp/Wi*.xml -Pattern 'keyMaterial' > $env:temp/Wi-Fi-PASS

# Then, process 'Wi-Fi-PASS' to create and save JSON
Get-Content "$env:temp/Wi-Fi-PASS" | ForEach-Object {
    $parts = $_ -split ':\d+:\s+|<keyMaterial>|</keyMaterial>'
    if ($parts.Length -eq 4) {
        [PSCustomObject]@{
            name = $parts[0].Trim().Replace('.xml', '').Replace('WiFi-', '')
            password = $parts[2].Trim()
        }
    }
} | ConvertTo-Json | Set-Content "$env:temp/WIFI-Pass.json"
