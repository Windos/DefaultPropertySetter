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
            if ($Obj.PSStandardMembers) {
                foreach ($Prop in $Property) {
                    $Obj.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Add($Prop)
                }
            } else {
                $ErrorMsg = 'Cannot add Properties as a Default Display Property Set does not exist on the Object. '
                $ErrorMsg += 'Please run the Set-DefaultPropertySet function instead.'
                Write-Error -Message $ErrorMsg -Category InvalidOperation
            }
        }
    }

    End {}
}
