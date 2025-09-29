# Define the OU distinguished name
$OU = "OU=YourOU,DC=domain,DC=com"

# Get all users in the OU
$Users = Get-ADUser -SearchBase $OU -Filter * 

# Prepare results
$Results = foreach ($User in $Users) {
    $Groups = Get-ADPrincipalGroupMembership $User | Select-Object -ExpandProperty SamAccountName
    [PSCustomObject]@{
        Username = $User.SamAccountName
        Groups   = $Groups -join ';'
    }
}

# Export to CSV
$Results | Export-Csv -Path "C:\Path\To\Your\Users.csv" -NoTypeInformation