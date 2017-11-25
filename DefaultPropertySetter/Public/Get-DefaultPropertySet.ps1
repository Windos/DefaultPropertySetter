function Get-DefaultPropertySet {
    <#
    .SYNOPSIS
    Gets all Properties from the Default Display Property Set of an Object.

    .DESCRIPTION
    The Get-DefaultPropertySet function gets all Properties from the Default
    Display Property Set of a PSCustomObject or collection of PSCustomObjects.

    .PARAMETER Object
    PSCustomObject(s) with an existing Default Display Property Set.

    .EXAMPLE
    Get-DefaultPropertySet -Object $DemoObject1

    This example lists the properties included in $DemoObject1's Default Display
    Property Set.

    .EXAMPLE
    $DemoObject1, $DemoObject2 | Get-DefaultPropertySet

    This example lists the properties included in both $DemoObject1 and
    $DemoObject2's Default Display Property Set.

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
            [PSCustomObject] @{
                DisplaySet = $Obj.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames
            }
        }
    }

    End {}
}
