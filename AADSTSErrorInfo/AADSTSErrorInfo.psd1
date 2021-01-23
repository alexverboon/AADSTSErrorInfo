@{
	# Script module or binary module file associated with this manifest
	RootModule = 'AADSTSErrorInfo.psm1'
	
	# Version number of this module.
	ModuleVersion = '1.0.0'
	
	# ID used to uniquely identify this module
	GUID = '279fd865-b77f-4d5b-9dc6-b9dbb37a1ce1'
	
	# Author of this module
	Author = 'Alex Verboon'
	
	# Company or vendor of this module
	CompanyName = ''
	
	# Copyright statement for this module
	Copyright = 'Copyright (c) 2021 AlexVerboon'
	
	# Description of the functionality provided by this module
	Description = 'Azure AD Authentication and authorization error lookup tool'
	
	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '5.0'
	
	# Modules that must be imported into the global environment prior to importing this module
	# RequiredModules = @(@{ ModuleName='PSFramework'; ModuleVersion='1.4.150' })
	
	# Assemblies that must be loaded prior to importing this module
	# RequiredAssemblies = @('bin\AZADError.dll')
	
	# Type files (.ps1xml) to be loaded when importing this module
	# Expensive for import time, no more than one should be used.
	# TypesToProcess = @('xml\AZADError.Types.ps1xml')
	
	# Format files (.ps1xml) to be loaded when importing this module.
	# Expensive for import time, no more than one should be used.
	# FormatsToProcess = @('xml\AZADError.Format.ps1xml')
	
	# Functions to export from this module
	FunctionsToExport = 'Get-AADSTSError'
	
	# Cmdlets to export from this module
	CmdletsToExport = ''
	
	# Variables to export from this module
	VariablesToExport = ''
	
	# Aliases to export from this module
	AliasesToExport = ''
	
	# List of all files packaged with this module
	FileList = @()
	
	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{
		
		#Support for PowerShellGet galleries.
		PSData = @{
			
			# Tags applied to this module. These help with module discovery in online galleries.
			Tags = @('AADSTS',"AzureAD","ErrorCode")
			
			# A URL to the license for this module.
			LicenseUri = 'https://github.com/alexverboon/AADSTSErrorInfo/blob/main/LICENSE'
			
			# A URL to the main website for this project.
			ProjectUri = 'https://github.com/alexverboon/AADSTSErrorInfo'
			
			# A URL to an icon representing this module.
			# IconUri = ''
			
			# ReleaseNotes of this module
			# ReleaseNotes = ''
			
		} # End of PSData hashtable
		
	} # End of PrivateData hashtable
}