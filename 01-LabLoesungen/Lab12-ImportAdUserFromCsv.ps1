Import-Csv -Path C:\Testfiles\MyNewAdUsers2.csv | ForEach-Object {
            New-ADUser -GivenName $PSItem.GivenName `                       -Surname $PSItem.SurName `                       -Name $PSItem.Name `                       -SamAccountName $PSItem.SamAccountName `
                       -Department $PSItem.Department `                       -Path $PSItem.Path `                       -Enabled $true `                       -AccountPassword (ConvertTo-SecureString $PSItem.Password -AsPlainText -Force)

}