# Sets a resource back to its original state.

function Reset-DefaultPropertySet {
    [CmdletBinding()]
    param (
        # comment based parameter help
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
