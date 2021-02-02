# AADSTSErrorInfo

[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.1-purple.svg)](https://github.com/PowerShell/PowerShell) [![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-7-purple.svg)](https://github.com/PowerShell/PowerShell)
![Cross Platform](https://img.shields.io/badge/platform-windows-lightgrey)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/AADSTSErrorInfo)](https://www.powershellgallery.com/packages/PSMDATP) [![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/AADSTSErrorInfo)](https://www.powershellgallery.com/packages/AADSTSErrorInfo)
[![License](https://img.shields.io/github/license/alexverboon/AADSTSErrorInfo)

## Introduction

The AADSTSErrorInfo PowerShell Module provides a quick and easy way to
lookup **Azure AD Authentication and authorization error codes** and retrieve AADSTS descriptions, fixes, and when available suggested workarounds or recommendations.

Error codes and messages are subject to change, the documentation [here](https://docs.microsoft.com/en-us/azure/active-directory/develop/reference-aadsts-error-codes#aadsts-error-codes) might not always be up to date. Using the AADSTSErrorInfo module will get you up to date information directly from the error page.

[https://login.microsoftonline.com/error](https://login.microsoftonline.com/error)

## Getting started

Run the following command to install the AADSTSErrorInfo PowerShell module

```powershell
Install-Module -Name AADSTSErrorInfo -Scope CurrentUser

```

List the included functions (currently there is just one)

```powershell
get-command -Module AADSTSErrorInfo
```

Lookup an error code

```powershell
Get-AADSTSError -ErrorCode 50076 |fl
```

When the error code is found the script returns the Error Code, Description and Remediation information

```powershell
ErrorCode   : 50076
Description : Due to a configuration change made by your administrator, or because you moved to a new location, you
              must use multi-factor authentication to access '{resource}'.
Remediation : User needs to perform multi-factor authentication. There could be multiple things requiring
              multi-factor, e.g. Conditional Access policies, per-user enforcement, requested by client, among others.
```

## Release Notes

| Version |    Date    |                           Notes                                |
| ------- | ---------- | -------------------------------------------------------------- |
| 0.0.1   | 18.01.2021 | Initial version                                                |
| 0.0.2   | 22.01.2021 | minor updates                                                  |
| 0.0.3   | 01.02.2021 | Added support for PowerShell 7                                 |

## Credits

[@FredWeinmann](https://twitter.com/FredWeinmann) This module was created using the [PSModuleDevelopment](https://psframework.org/documentation/quickstart/psmoduledevelopment.html)

[@PalmEmanuel](https://twitter.com/palmemanuel) for his blog post (https://www.pipehow.tech/invoke-webscrape/) that inspired me to build a workaround when i found out that the Invoke-WebRequest on PowerShell core does no longer return the ParsedHtml property

## TODO

* Build pipeline

