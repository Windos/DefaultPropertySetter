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
    An example

    .LINK
    https://github.com/Windos/DefaultPropertySetter
    #>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [PSCustomObject[]] $Object,

        [Switch] $Force
    )

    DynamicParam {
        $ParamAttrib  = New-Object System.Management.Automation.ParameterAttribute
        $ParamAttrib.Mandatory  = $true
        $ParamAttrib.ParameterSetName  = '__AllParameterSets'
        $AttribColl = New-Object  System.Collections.ObjectModel.Collection[System.Attribute]
        $AttribColl.Add($ParamAttrib)

        $AvailablePropertyNames = $MyInvocation.BoundParameters.Item('Object')[0] | Get-Member -MemberType Properties | Select -ExpandProperty Name
        $AttribColl.Add((New-Object  System.Management.Automation.ValidateSetAttribute($AvailablePropertyNames)))

        $RuntimeParam  = New-Object System.Management.Automation.RuntimeDefinedParameter('DisplaySet',  [string[]], $AttribColl)
        $RuntimeParamDic  = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        $RuntimeParamDic.Add('DisplaySet',  $RuntimeParam)

        return  $RuntimeParamDic
    }

    Begin {
        $DefaultDisplaySet = $DisplaySet
        $DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet(‘DefaultDisplayPropertySet’,[string[]]$DefaultDisplaySet)
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
                    Write-Error -Exception 'Cannot set a Default Property Set on one or more object because a Default Property Set already exists. To overwrite the Property Set, add the Force parameter to your command.'
                    Continue
                }
            }
        }
    }

    End {}
}
