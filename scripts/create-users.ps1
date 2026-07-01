$users = Import-Csv -Path "$env:USERPROFILE\Documents\voltcore-users.csv"

foreach ($user in $users) {

    # Skip empty rows
    if (-not $user.FirstName) { continue }

    # Build username
    $username = "$($user.FirstName.ToLower()).$($user.LastName.ToLower())"
    $upn = "$username@voltcore.co.za"

    # Skip if user already exists
    if (Get-ADUser -Filter "SamAccountName -eq '$username'" -ErrorAction SilentlyContinue) {
        Write-Host "Skipped (already exists): $upn"
        continue
    }

    # Create OU if it does not exist
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$($user.OU)'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $user.Department -Path "OU=Users,OU=$($user.Office),DC=voltcore,DC=co,DC=za" -ErrorAction SilentlyContinue
    }

    # Create the user
    New-ADUser `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -Name "$($user.FirstName) $($user.LastName)" `
        -SamAccountName $username `
        -UserPrincipalName $upn `
        -Department $user.Department `
        -Office $user.Office `
        -Title $user.JobTitle `
        -Path $user.OU `
        -AccountPassword (ConvertTo-SecureString "Voltcore@2026!" -AsPlainText -Force) `
        -Enabled $true `
        -ErrorAction SilentlyContinue

    Write-Host "Created: $upn"
}

Write-Host "Done."