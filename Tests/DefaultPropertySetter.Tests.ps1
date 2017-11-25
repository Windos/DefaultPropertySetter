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
        It 'should result in 3 referenced properties' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 3
        }
    }

    $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Remove('Name')
    $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Remove('Date')

    Context 'Object supplied via pipeline' {
        It 'should not throw an error' {
            { $DemoObject1, $DemoObject2 | Add-DefaultPropertySetProperty -Property 'Date' } | Should Not Throw
        }
        It 'should result in 2 referenced properties on $DemoObject1' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 2
        }
        It 'should result in 2 referenced properties on $DemoObject2' {
            @($DemoObject2.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 2
        }
    }

    Context 'Invalid Operation' {
        It 'should throw an arror' {
            { $DemoObject3 | Add-DefaultPropertySetProperty -Property 'Name' } | Should Throw
        }
    }
}

Describe 'Clear-DefaultPropertySet' {
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

    $defaultDisplaySet = 'Name', 'Date', 'PC'
    $defaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet',[string[]]$defaultDisplaySet)
    $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)

    $DemoObject1 | Add-Member MemberSet PSStandardMembers $PSStandardMembers
    $DemoObject2 | Add-Member MemberSet PSStandardMembers $PSStandardMembers

    Context 'Object supplied as an argument' {
        It 'should start with 3 referenced properties' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 3
        }
        It 'should not throw an error' {
            { Clear-DefaultPropertySet -Object $DemoObject1 } | Should Not Throw
        }
        It 'should result in 0 referenced properties' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 0
        }
    }

    $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Add('Name')
    $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Add('Date')
    $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Add('PC')

    Context 'Object supplied via pipeline' {
        It 'should start with 3 referenced properties on $DemoObject1' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 3
        }
        It 'should start with 3 referenced properties on $DemoObject2' {
            @($DemoObject2.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 3
        }
        It 'should not throw an error' {
            { $DemoObject1, $DemoObject2 | Clear-DefaultPropertySet } | Should Not Throw
        }
        It 'should result in 0 referenced properties on $DemoObject1' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 0
        }
        It 'should result in 0 referenced properties on $DemoObject2' {
            @($DemoObject2.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 0
        }
    }
}

Describe 'Get-DefaultPropertySet' {
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

    $defaultDisplaySet = 'Name', 'Date', 'PC'
    $defaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet',[string[]]$defaultDisplaySet)
    $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)

    $DemoObject1 | Add-Member MemberSet PSStandardMembers $PSStandardMembers
    $DemoObject2 | Add-Member MemberSet PSStandardMembers $PSStandardMembers

    Context 'Object supplied as an argument' {
        It 'should not throw an error' {
            { Get-DefaultPropertySet -Object $DemoObject1 } | Should Not Throw
        }
        It 'should return 1 object' {
            @(Get-DefaultPropertySet -Object $DemoObject1).Length | Should Be 1
        }
        It 'should return 3 referenced properties' {
            @((Get-DefaultPropertySet -Object $DemoObject1).DisplaySet).Length | Should Be 3
        }
    }

    Context 'Object supplied via pipeline' {
        It 'should not throw an error' {
            { $DemoObject1, $DemoObject2 | Get-DefaultPropertySet } | Should Not Throw
        }
        It 'should return 2 object' {
            @($DemoObject1, $DemoObject2 | Get-DefaultPropertySet).Length | Should Be 2
        }
        It 'should return 6 referenced properties' {
            @(($DemoObject1, $DemoObject2 | Get-DefaultPropertySet).DisplaySet).Length | Should Be 6
        }
    }
}

Describe 'Remove-DefaultPropertySetProperty' {
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

    $defaultDisplaySet = 'Name', 'Date', 'PC'
    $defaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet',[string[]]$defaultDisplaySet)
    $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)

    $DemoObject1 | Add-Member MemberSet PSStandardMembers $PSStandardMembers
    $DemoObject2 | Add-Member MemberSet PSStandardMembers $PSStandardMembers

    Context 'Object supplied as an argument' {
        It 'should start with 3 referenced properties' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 3
        }
        It 'should not throw an error' {
            { Remove-DefaultPropertySetProperty -Object $DemoObject1 -Property 'Name', 'Date' } | Should Not Throw
        }
        It 'should result in 1 referenced properties' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 1
        }
    }

    $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Add('Name')
    $DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames.Add('Date')

    Context 'Object supplied via pipeline' {
        It 'should start with 3 referenced properties on $DemoObject1' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 3
        }
        It 'should start with 3 referenced properties on $DemoObject2' {
            @($DemoObject2.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 3
        }
        It 'should not throw an error' {
            { $DemoObject1, $DemoObject2 | Remove-DefaultPropertySetProperty -Property 'Date' } | Should Not Throw
        }
        It 'should result in 2 referenced properties on $DemoObject1' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 2
        }
        It 'should result in 2 referenced properties on $DemoObject2' {
            @($DemoObject2.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 2
        }
    }
}

Describe 'Set-DefaultPropertySet' {
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

    Context 'Object supplied as an argument' {
        It 'should start with no PSStandardMembers' {
            $DemoObject1.PSStandardMembers -eq $null | Should be $true
        }
        It 'should not throw an error' {
            { Set-DefaultPropertySet -Object $DemoObject1 -DisplaySet 'Name', 'Date' } | Should Not Throw
        }
        It 'should result in 2 referenced properties' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 2
        }
    }

    Context 'Re-Running on object supplied as an argument' {
        It 'should start with PSStandardMembers' {
            $DemoObject1.PSStandardMembers -ne $null | Should be $true
        }
        It 'should throw an error, re-running without Force switch' {
            { Set-DefaultPropertySet -Object $DemoObject1 -DisplaySet 'Name', 'Date', 'PC' } | Should Throw
        }
        It 'should now throw an error, re-running with Force switch' {
            { Set-DefaultPropertySet -Object $DemoObject1 -DisplaySet 'Name', 'Date', 'PC' -Force } | Should Not Throw
        }
        It 'should result in 3 referenced properties' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 3
        }
    }

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

    Context 'Object supplied via pipeline' {
        It 'should start with no PSStandardMembers on $DemoObject1' {
            $DemoObject1.PSStandardMembers -eq $null | Should be $true
        }
        It 'should start with no PSStandardMembers on $DemoObject2' {
            $DemoObject2.PSStandardMembers -eq $null | Should be $true
        }
        It 'should not throw an error' {
            { $DemoObject1, $DemoObject2 | Set-DefaultPropertySet -DisplaySet 'Name', 'Date' } | Should Not Throw
        }
        It 'should result in 2 referenced properties on $DemoObject1' {
            @($DemoObject1.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 2
        }
        It 'should result in 2 referenced properties on $DemoObject2' {
            @($DemoObject2.PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames).Length | Should Be 2
        }
    }
}
