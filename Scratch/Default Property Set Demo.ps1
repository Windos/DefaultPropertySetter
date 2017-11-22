$DemoObject1 = [PSCustomObject] @{
    Name = 'Demo 1'
    Time = Get-Date -DisplayHint Time
    Date = Get-Date -DisplayHint Date
    Country = 'NZ'
    PC = 'Desktop'
}

$DemoObject2 = [PSCustomObject] @{
    Name = 'Demo 2'
    Time = Get-Date -DisplayHint Time
    Date = Get-Date -DisplayHint Date
    Country = 'US'
    PC = 'Laptop'
}

$DemoObject3 = [PSCustomObject] @{
    Name = 'Demo 3'
    Time = Get-Date -DisplayHint Time
    Date = Get-Date -DisplayHint Date
    Country = 'AU'
    PC = 'Server'
}

$defaultDisplaySet = 'Name', 'Time'
$defaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet(‘DefaultDisplayPropertySet’,[string[]]$defaultDisplaySet)
$PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)

$DemoObject1 | Add-Member MemberSet PSStandardMembers $PSStandardMembers -Force

$DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames