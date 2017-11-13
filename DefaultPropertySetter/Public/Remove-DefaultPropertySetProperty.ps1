# $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Remove('Country')

function Remove-DefaultPropertySetProperty {
    [CmdletBinding()]
    param (
        # comment based parameter help
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
