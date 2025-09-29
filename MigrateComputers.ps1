# Define the OU distinguished name
$OU = "OU=YourOU,DC=domain,DC=com"

# Get all computers in the OU
$Computers = Get-ADComputer -SearchBase $OU -Filter * 

# Prepare results
$Results = foreach ($Computer in $Computers) {
    $Groups = Get-ADPrincipalGroupMembership $Computer | Select-Object -ExpandProperty SamAccountName
    [PSCustomObject]@{
        ComputerName = $Computer.Name
        Groups       = $Groups -join ';'
    }
}

# Export to CSV
$Results | Export-Csv -Path "C:\Path\To\Your\Computers.csv" -NoTypeInformation