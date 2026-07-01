# Top level OUs
New-ADOrganizationalUnit -Name "Durban" -Path "DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Johannesburg" -Path "DC=voltcore,DC=co,DC=za"

# Durban sub OUs
New-ADOrganizationalUnit -Name "Users" -Path "OU=Durban,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Computers" -Path "OU=Durban,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=Durban,DC=voltcore,DC=co,DC=za"

# Durban department OUs inside Users
New-ADOrganizationalUnit -Name "Executive" -Path "OU=Users,OU=Durban,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Finance" -Path "OU=Users,OU=Durban,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Human Resources" -Path "OU=Users,OU=Durban,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "IT" -Path "OU=Users,OU=Durban,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Electrical Engineering" -Path "OU=Users,OU=Durban,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Industrial Automation" -Path "OU=Users,OU=Durban,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Sales and Proposals" -Path "OU=Users,OU=Durban,DC=voltcore,DC=co,DC=za"

# Johannesburg sub OUs
New-ADOrganizationalUnit -Name "Users" -Path "OU=Johannesburg,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Computers" -Path "OU=Johannesburg,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=Johannesburg,DC=voltcore,DC=co,DC=za"

# Johannesburg department OUs inside Users
New-ADOrganizationalUnit -Name "IT" -Path "OU=Users,OU=Johannesburg,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Industrial Automation" -Path "OU=Users,OU=Johannesburg,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Field Operations" -Path "OU=Users,OU=Johannesburg,DC=voltcore,DC=co,DC=za"
New-ADOrganizationalUnit -Name "Sales and Proposals" -Path "OU=Users,OU=Johannesburg,DC=voltcore,DC=co,DC=za"

Write-Host "All OUs created successfully"