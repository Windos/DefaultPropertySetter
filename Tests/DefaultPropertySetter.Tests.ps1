Import-Module DefaultPropertySetter

Describe 'DefaultPropertySetter Module' {
    Context 'General' {
        It 'exports all expected functions' {
            @(Get-Command -Module DefaultPropertySetter).Length | Should Be 5
        }
    }
}

Describe 'Add-DefaultPropertySetProperty' {
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

    $defaultDisplaySet = 'PC'
    $defaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet',[string[]]$defaultDisplaySet)
    $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)

    $DemoObject1 | Add-Member MemberSet PSStandardMembers $PSStandardMembers
    $DemoObject2 | Add-Member MemberSet PSStandardMembers $PSStandardMembers

    Context 'Object supplied as an argument' {
        It 'should not throw an error' {
            { Add-DefaultPropertySetProperty -Object $DemoObject1 -Property 'Name', 'Date' } | Should Not Throw
        }
        It 'should result in 3 references properties' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 3
        }
    }

    $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Remove('Name')
    $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Remove('Date')

    Context 'Object supplied via pipeline' {
        It 'should not throw an error' {
            { $DemoObject1, $DemoObject2 | Add-DefaultPropertySetProperty -Property 'Date' } | Should Not Throw
        }
        It 'should result in 2 references properties on $DemoObject1' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 2
        }
        It 'should result in 2 references properties on $DemoObject2' {
            @($DemoObject2.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 2
        }
    }

    Context 'Invalid Operation' {
        It 'should throw an arror' {
            { $DemoObject3 | Add-DefaultPropertySetProperty -Property 'Name' } | Should Throw
        }
    }
}
