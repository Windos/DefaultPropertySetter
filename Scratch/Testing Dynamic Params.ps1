function Set-DefaultPropertySet {
    [CmdletBinding()]
    Param (
        # Parameter help description
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [PSCustomObject[]] $Object,

        # Parameter help description
        #[Parameter(Mandatory)]
        #[String[]] $DisplaySet,

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
    }

    Process {
        $MyInvocation.BoundParameters.Item('Object')[0] | Get-Member -MemberType Properties | Select -ExpandProperty Name
    }

    End {}
}