function Remove-DefaultPropertySetProperty {
    <#
    .SYNOPSIS
    Removes Properties from the Default Display Property Set of an Object.

    .DESCRIPTION
    The Remove-DefaultPropertySetProperty function removes Properties from the
    Default Display Property Set of a PSCustomObject or collection of PSCustomObjects.

    .PARAMETER Object
    PSCustomObject(s) with an existing Default Display Property Set.

    .PARAMETER Property
    The name of the properties to be removed from the Default Display Property Set.

    .EXAMPLE
    An example

    .LINK
    https://github.com/Windos/DefaultPropertySetter
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [PSCustomObject[]] $Object,

        [Parameter(Mandatory)]
        [String[]] $Property
    )

    Begin {}

    Process {
        foreach ($Obj in $Object) {
            foreach ($Prop in $Property) {
                $null = $Obj.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Remove($Prop)
            }
        }
    }

    End {}
}
