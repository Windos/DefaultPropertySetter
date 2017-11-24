function Clear-DefaultPropertySet {
    <#
    .SYNOPSIS
    Removes all Properties from the Default Display Property Set of an Object.

    .DESCRIPTION
    The Clear-DefaultPropertySet function removes all Properties from the Default
    Display Property Set of a PSCustomObject or collection of PSCustomObjects.

    .PARAMETER Object
    PSCustomObject(s) with an existing Default Display Property Set.

    .EXAMPLE
    An example

    .LINK
    https://github.com/Windos/DefaultPropertySetter
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [PSCustomObject[]] $Object
    )

    Begin {}

    Process {
        foreach ($Obj in $Object) {
            $Obj.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Clear()
        }
    }

    End {}
}
