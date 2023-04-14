Import-Module dbatools
Get-DbaService
Export-DbaLogin -SqlInstance $instance -Path C:\temp\logins.sql
Connect-DbaInstance -SqlInstance "localhost\sqlexpress"
New-DbaDatabase -SqlInstance "localhost\sqlexpress" -Name "KExchange1"
$cols = @( )
$cols += @{
    Name              = 'Id'
    Type              = 'varchar'
    MaxLength         = 36
    DefaultExpression = 'NEWID()'
}
$cols += @{
    Name          = 'Since'
    Type          = 'datetime2'
    DefaultString = '2021-12-31'
}
New-DbaDbTable -SqlInstance "localhost\sqlexpress" -Database "KExchange1" -Name "KETable1" -ColumnMap $cols
Write-DbaDbTableData