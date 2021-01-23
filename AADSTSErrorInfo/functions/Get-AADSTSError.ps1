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
        $Data = [System.Collections.ArrayList]::new()
        $Data.PSObject.TypeNames.Insert(0,'AADSTS.ErrorInfo')
        $uri  = "https://login.microsoftonline.com/error"
        $body = "code=$ErrorCode"
    }
    Process
    {
        Try{
            $request = Invoke-WebRequest -Uri $uri -Body $body -Method Post 
            $result = @(Get-AADSTSHtmlInfo -page $request)
            If($request.RawContent -like "*Code not found!*")
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
                    ErrorCode   = (($result.0).1)[0]
                    Description = (($result.0).1)[1]
                    Remediation = If ([string]::IsNullOrEmpty( (($result.0).1)[2])) {""} Else { (($result.0).1)[2] }
                }
                [void]$Data.Add($object)
                
            }
        # $Data.PSObject.TypeNames.Insert(0,'AADSTS.ErrorInfo')
        $Data 
        }
        Catch{
            Write-Error "Error retrieving AADSTS Error information [$_]"
        }  
    }
    End
    {}
}
                      