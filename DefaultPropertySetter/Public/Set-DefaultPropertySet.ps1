# Replaces data on an existing resource or creates a resource that contains some data.

function Set-DefaultPropertySet {
    [CmdletBinding()]
    Param (
        # Parameter help description
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [PSCustomObject[]] $Object,

        # Parameter help description
        [Parameter(Mandatory)]
        [String[]] $DisplaySet,

        [Switch] $Force
    )

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
