 $VerbosePreference = "continue"

 #Path concatenation
 $var1 = 'test2.log'
 $var2 = 'C:\'
 #$deployPath = Join-Path -Path $var2 -ChildPath $var1
 $path = Join-Path $var2 $var1
  Write-Verbose $path

  #Send power shell logging to a file
  Start-Transcript -Path ($path) 

 #Creating a self signed certificate
 #Install it in windows certificate store - Intermediate Certificate Authorities
 $cert = New-SelfSignedCertificate -DnsName $env:COMPUTERNAME  -CertStoreLocation 'Cert:\LocalMachine\My'
 $thumbprint = $cert.Thumbprint
 Write-Verbose "Self-signed SSL certificate generated; thumbprint: $thumbprint"

 #Set timezone
 (tzutil /s "India Standard Time")
 #Retrieve system time zone
 $timeZone = $(tzutil /g)
 Write-Verbose $timeZone
 (tzutil /s "AUS Eastern Standard Time")
 #tsutil /l - lists all the timezones

 #Read properties from file
 $props = Get-Content -Path ".\src\properties.txt" -Raw | ConvertFrom-StringData
 Write-Verbose "$($props.'field1') And $($props.'field2')"
 Write-Verbose "$((Get-Content -Path ".\src\properties.txt" -Raw | ConvertFrom-StringData).'field1')"

 #Read a json file { "field1":"value1", "field2":"value2" }
 $jsonVar = Get-Content -Path ".\src\json.txt" -Raw | ConvertFrom-Json
 Write-Verbose "$($jsonVar.field1) And $($jsonVar.field2)"