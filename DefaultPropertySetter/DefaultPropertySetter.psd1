@{
    RootModule = 'DefaultPropertySetter.psm1'
    ModuleVersion = '0.0.1'
    GUID = 'df8f0a4e-1e59-422b-9873-41db5cdbc890'
    Author = 'Joshua (Windos) King'
    CompanyName = 'king.geek.nz'
    Copyright = '(c) 2017 Joshua (Windos) King. All rights reserved.'
    Description = 'PowerShell module for setting default property sets on custom objects.'
    PowerShellVersion = '3.0'
    FunctionsToExport = 'Add-DefaultPropertySetProperty',
                        'Clear-DefaultPropertySet',
                        'Get-DefaultPropertySet',
                        'Remove-DefaultPropertySetProperty',
                        'Set-DefaultPropertySet'
    CmdletsToExport = @()
    AliasesToExport = @()
    PrivateData = @{
        PSData = @{
            Tags = @('Utilities', 'Helper', 'PSCustomObject', 'Formatting')
            LicenseUri = 'https://github.com/Windos/DefaultPropertySetter/blob/master/LICENSE'
            ProjectUri = 'https://github.com/Windos/DefaultPropertySetter'
            # IconUri = ''
            ReleaseNotes = '
* 0.0.1
    * Initial release
'
        }
    }
}
