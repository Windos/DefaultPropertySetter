function Add-DefaultPropertySetProperty {
    <#
    .SYNOPSIS
    Adds Properties to the Default Display Property Set of an Object.

    .DESCRIPTION
    The Add-DefaultPropertySetProperty function adds Properties to the Default
    Display Property Set of a PSCustomObject or collection of PSCustomObjects.

    If the provided Object does not currently have a Default Display Property
    Set, this function will terminate and advise using the Set-DefaultPropertySet
    function instead.

    .PARAMETER Object
    PSCustomObject(s) with an existing Default Display Property Set.

    .PARAMETER Property
    The name of the properties to be added to the Default Display Property Set.

    .EXAMPLE
    Add-DefaultPropertySetProperty -Object $DemoObject1 -Property 'Name', 'Date'

    This command adds the properties 'Name' and 'Date' to $DemoObject1's Default
    Display Property Set.

    Note that $DemoObject1 should already have a Default Display Property Set,
    otherwise this function will generate an error.

    .EXAMPLE
    $DemoObject1, $DemoObject2 | Add-DefaultPropertySetProperty -Property 'Date'

    This command takes two objects as input from the pipeline and adds the property
    'Date' to both of their Default Display Property Sets.

    Note that $DemoObject1 should already have a Default Display Property Set,
    otherwise this function will generate an error.

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
            if ($Obj.PSStandardMembers) {
                foreach ($Prop in $Property) {
                    $Obj.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Add($Prop)
                }
            } else {
                $ErrorMsg = 'Cannot add Properties as a Default Display Property Set does not exist on the Object. '
                $ErrorMsg += 'Please run the Set-DefaultPropertySet function instead.'
                throw $ErrorMsg
            }
        }
    }

    End {}
}
