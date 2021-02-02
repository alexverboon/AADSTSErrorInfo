function Get-AADSTSError{
<#
.Synopsis
   Get-AADSTSError
.DESCRIPTION
   Get-AADSTSError performs a lookup for the specified AADSTS error code and returns  error code description and remeidiation information
.PARAMETER ErrorCode
    The AADSTS error code

    A list of documented error codes can be found here: https://docs.microsoft.com/en-us/azure/active-directory/develop/reference-aadsts-error-codes#aadsts-error-codes

.EXAMPLE
   Get-AADSTSError -ErrorCode AADSTS50076

   ErrorCode   : 50076
   Description : Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor 
                 authentication to access '{resource}'.
   Remediation: User needs to perform multi-factor authentication. There could be multiple things requiring multi-factor, e.g. Conditional Access 
                 policies, per-user enforcement, requested by client, among others.

#>
    [CmdletBinding()]
    Param
    (
        # The AADSTS Error code to lookup
        [Parameter(Mandatory=$true)]
        [string]$ErrorCode
    )

    Begin
    {
        $AllProtocols = [System.Net.SecurityProtocolType]'Tls,Tls11,Tls12,Tls13' 
        [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
        $Data = [System.Collections.ArrayList]::new()
        $Data.PSObject.TypeNames.Insert(0,'AADSTS.ErrorInfo')
        $uri  = "https://login.microsoftonline.com/error"
        $body = "code=$ErrorCode"
    }
    Process
    {
        Try{
            $request = Invoke-RestMethod -Uri $uri -Body $body -Method Post 
            #credits for the web scraping hint - https://www.pipehow.tech/invoke-webscrape/            
            $CodePattern = '<table><tr><td>Error Code</td><td>(?<Code>.*)</td></tr><tr><td>Message'
            # pattern when the result includes Remediation info
            $MessagePattern1 = '<tr><td>Message</td><td>(?<Message1>.*)</td></tr><tr><td>Remediation'
            # pattern when there is no remediation info
            $MessagePattern2 =  '<tr><td>Message</td><td>(?<Message2>.*)</td></tr></table></body>'
            $RemediationPattern = '</td></tr><tr><td>Remediation</td><td>(?<Remediation>.*)</td></tr></table></body>'
            $Patterns = "$CodePattern","$MessagePattern1","$MessagePattern2","$RemediationPattern"
            $ResultData = forEach ($patt in $Patterns)
            {
                ($request | Select-String $patt -AllMatches).Matches
            }

            $OutMessage1 = $null
            $OutMessage2 = $null
            $OutRemediation = $null
            $OutCode = $null

            foreach ($result in $ResultData)
            {
                If (($result.Groups.Where{$_.Name -like 'Code'}).Value -notlike ""){
                    $OutCode = ($result.Groups.Where{$_.Name -like 'Code'}).Value 
                }

                If (($result.Groups.Where{$_.Name -like 'Remediation'}).Value -notlike ""){
                    $OutRemediation = ($result.Groups.Where{$_.Name -like 'Remediation'}).Value
                }

                If (($result.Groups.Where{$_.Name -like 'Message1'}).Value -notlike ""){
                    $OutMessage1 = ($result.Groups.Where{$_.Name -like 'Message1'}).Value 
                }

                If (($result.Groups.Where{$_.Name -like 'Message2'}).Value -notlike ""){
                    $OutMessage2 = ($result.Groups.Where{$_.Name -like 'Message2'}).Value 
                }
             }
        
            If($OutCode -like "")
            {
                Write-Verbose "Error code: $ErrorCode not found" 
                $object = [PSCustomObject]@{
                    PSTypeName  = "AADSTS.ErrorInfo"
                    ErrorCode   = $ErrorCode
                    Description = "not found"
                    Remediation = ""
            }
            [void]$Data.Add($object)
        }
        Else
            {
                Write-Verbose "Error code: $ErrorCode found" 
                $object = [PSCustomObject]@{
                    PSTypeName  = "AADSTS.ErrorInfo"
                    ErrorCode   = $OutCode
                    Description = If ($OutRemediation -notlike "") {$OutMessage1} Else {$OutMessage2}
                    Remediation = $OutRemediation
                }
                [void]$Data.Add($object)
            }
        $Data 
        }
        Catch{
            Write-Error "Error retrieving AADSTS Error information [$_]"
        }  
    }
    End
    {}
}
                      