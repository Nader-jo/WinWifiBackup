netsh wlan export profile key=clear
powershell -Command "
Select-String -Path Wi*.xml -Pattern 'keyMaterial' > Wi-Fi-PASS; `
Get-Content 'Wi-Fi-PASS' | `
ForEach-Object { `
    \$parts = \$_ -split ':\d+:\s+|<keyMaterial>|</keyMaterial>'; `
    if (\$parts.Length -eq 4) { `
        [PSCustomObject]@{ 
            name = \$parts[0].Trim().Replace('.xml', '').Replace('WiFi-', ''); 
            password = \$parts[2].Trim() 
        } 
    } 
} | ConvertTo-Json | Set-Content 'WIFI-Pass.json'
"
