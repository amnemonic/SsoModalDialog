# SsoModalDialog
Universal SSO Modal window to use in your application

# Usage

`SsoModalDialog.exe <SSO Url Address> [<SearchString>] [<SSO Title>]`

* `<Se<archString>` defaults to `SAMLResponse`
* `<SSO Title>` defaults to `Login`

## Python
You can test SAMLresponse using this great site: [stubidp.sustainsys.com](https://stubidp.sustainsys.com/) and below code. Just select one predefined Identity from list and press Login button.
```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import subprocess
import urllib.parse
from base64 import b64decode


cmd = 'SsoModalDialog.exe "https://stubidp.sustainsys.com/"'
returned_output = subprocess.check_output(cmd).decode("utf-8")


for l in returned_output.split("\r\n"):
    if l.startswith('[SAML]'):
        SAMLresp = urllib.parse.unquote( l.replace('[SAML]SAMLResponse=','') ).strip()

print(b64decode(SAMLresp))
```
## PowerShell
```powershell
Add-Type -Assembly System.Web

$cmd = Invoke-Command -ScriptBlock { .\SsoModalDialog.exe "https://stubidp.sustainsys.com/" }
$returned_output = ([string]$cmd).Split(" ") 

ForEach ($l in $returned_output) {
    if ($l.StartsWith("[SAML]")) {
        $SAMLresp = $l.Replace("[SAML]SAMLResponse=","") 
    }
}
$SAMLresp_urlDecoded  = [System.Web.HttpUtility]::UrlDecode($SAMLresp)
$SAMLresp_b64_decoded = [System.Convert]::FromBase64String($SAMLresp_urlDecoded.trim([char]0x00)) #dont know why yet but there is null char at the end
$SAMLresp_asString    = [System.Text.Encoding]::UTF8.GetString($SAMLresp_b64_decoded)

Write-Host $SAMLresp_asString
```

# Credits
Icon from http://icons8.com/ ([iconarchive.com](http://www.iconarchive.com/show/windows-8-icons-by-icons8/User-Interface-Login-icon.html))
