# $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Add('Country')

function Add-DefaultPropertySetProperty {
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
                $Obj.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Add($Prop)
            }
        }
    }

    End {}
}
