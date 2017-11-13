# Sets a resource back to its original state.

function Get-DefaultPropertySet {
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
            [PSCustomObject] @{
                DisplaySet = $Obj.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames
            }
        }
    }

    End {}
}
