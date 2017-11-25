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
    Clear-DefaultPropertySet -Object $DemoObject1

    This command clears the properties from $DemoObject1's Default Display
    Property Set.

    .EXAMPLE
    $DemoObject1, $DemoObject2 | Clear-DefaultPropertySet

    This command clears the properties from both $DemoObject1 and $DemoObject2's
    Default Display Property Set.

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
