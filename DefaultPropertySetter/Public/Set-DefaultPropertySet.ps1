function Set-DefaultPropertySet {
    <#
    .SYNOPSIS
    Sets the Default Display Property Set of an Object.

    .DESCRIPTION
    The Set-DefaultPropertySet function sets the Default Display Property Set
    of a PSCustomObject or collection of PSCustomObjects.

    The Force switch can be specified to overwrite an existing Default Display
    Property Set.

    .PARAMETER Object
    PSCustomObject(s) with an existing Default Display Property Set.

    .PARAMETER Property
    The name of the properties to be included with the Default Display Property
    Set.

    Only paramater names that exist on the first input Object are valid.

    .PARAMETER Force
    Specifies that an existing Default Display Property Set can be overwritten.

    .EXAMPLE
    Set-DefaultPropertySet -Object $DemoObject1 -DisplaySet 'Name', 'Date'

    This command adds a Default Display Property Set to $DemoObject1 containing
    the properties 'Name' and 'Date'.

    .EXAMPLE
    $DemoObject1, $DemoObject2 | Set-DefaultPropertySet -DisplaySet 'Name', 'Date'

    This command takes two objects as input from the pipeline and adds a Default
    Display Property Set to both objects containing the properties 'Name' and 'Date'.

    .LINK
    https://github.com/Windos/DefaultPropertySetter
    #>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [PSCustomObject[]] $Object,

        [Parameter(Mandatory)]
        [String[]] $DisplaySet,

        [Switch] $Force
    )

    Begin {
        $DefaultDisplaySet = $DisplaySet
        $DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet',[string[]]$DefaultDisplaySet)
        $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($DefaultDisplayPropertySet)
    }

    Process {
        foreach ($Obj in $Object) {
            if ($Force) {
                $Obj | Add-Member MemberSet PSStandardMembers $PSStandardMembers -Force
            } else {
                try {
                    $Obj | Add-Member MemberSet PSStandardMembers $PSStandardMembers -ErrorAction Stop
                } catch [InvalidOperationException] {
                    throw 'Cannot set a Default Property Set on one or more object because a Default Property Set already exists. To overwrite the Property Set, add the Force parameter to your command.'
                    Continue
                }
            }
        }
    }

    End {}
}
