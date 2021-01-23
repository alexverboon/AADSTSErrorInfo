# AADSTSErrorInfo

[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.1+-purple.svg)](https://github.com/PowerShell/PowerShell) ![Cross Platform](https://img.shields.io/badge/platform-windows-lightgrey)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/AADSTSErrorInfo)](https://www.powershellgallery.com/packages/PSMDATP) [![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/AADSTSErrorInfo)](https://www.powershellgallery.com/packages/AADSTSErrorInfo)

The AADSTSErrorInfo PowerShell Module provides a quick and easy way to
lookup **Azure AD Authentication and authorization error codes** and retrieve AADSTS descriptions, fixes, and some suggested workarounds.

Error codes and messages are subject to change so the documentation [here](https://docs.microsoft.com/en-us/azure/active-directory/develop/reference-aadsts-error-codes#aadsts-error-codes)

might not always be up to date. Using the AADSTSErrorInfo module will get you up to date information directly from the error page.

[https://login.microsoftonline.com/error](https://login.microsoftonline.com/error)

## Getting started

Run the following command to install the AADSTSErrorInfo PowerShell module

```powershell
Install-Module -Name AADSTSErrorInfo

```

List the included functions

```powershell
get-command -Module AADSTSErrorInfo

```

Lookup an error code

```powershell
Get-AADSTSError -ErrorCode 16000

```

When the error code is found the script returns the Error Code, Description and Remediation information

```powershell
ErrorCode   : 16000
Description : Either multiple user identities are available for the current request or selected account is not supported for the scenario.
Remediation : N/A - Hide in logs
```

## Release Notes

| Version |    Date    |                           Notes                                |
| ------- | ---------- | -------------------------------------------------------------- |
| 0.0.1   | 18.01.2021 | Initial Release                                                |

## Credits

[@FredWeinmann](https://twitter.com/FredWeinmann) This module was created using the [PSModuleDevelopment](https://psframework.org/documentation/quickstart/psmoduledevelopment.html)
