# Voltcore Engineering Solutions
## Phase 2 Project — Windows Server & Active Directory
### Systems Administration Roadmap — Personal Edition 2026

---

## Company Overview

**Company Name:** Voltcore Engineering Solutions
**Domain:** voltcore.co.za
**Industry:** Electrical Infrastructure, Industrial Automation, IT Systems Integration
**Size:** 80 employees
**Offices:** Durban HQ (57 employees) | Johannesburg Branch (23 employees)

Voltcore Engineering Solutions is a South African engineering firm specialising in electrical infrastructure projects, industrial automation systems, and IT network integration for the mining, manufacturing, and commercial sectors. The company operates across two offices — headquarters in Durban managing core engineering and business operations, and a branch in Johannesburg handling Gauteng-based clients, government tenders, and field operations across the northern regions.

The IT department is responsible for all internal systems, user management, security, and infrastructure across both offices.

---

## Office Structure

### Durban HQ — Primary Site
**Domain Controller:** DC01-DBN.voltcore.co.za
**Location:** Durban, KwaZulu-Natal
**Employees:** 57

### Johannesburg Branch — Secondary Site
**Domain Controller:** DC02-JHB.voltcore.co.za
**Location:** Johannesburg, Gauteng
**Employees:** 23

---

## Department Structure

| Department | Headcount | Location | Notes |
|---|---|---|---|
| Executive | 5 | Durban HQ | CEO, CFO, COO, 2 Personal Assistants |
| Finance | 8 | Durban HQ | Accounts, payroll, budgeting |
| Human Resources | 5 | Durban HQ | Recruitment, onboarding, records |
| IT | 7 | Split (4 DBN / 3 JHB) | Sysadmins, helpdesk, infrastructure |
| Electrical Engineering | 20 | Durban HQ | Core business, design and projects |
| Industrial Automation | 15 | Split (9 DBN / 6 JHB) | PLC, SCADA, building management |
| Field Operations | 10 | Johannesburg Branch | On-site work, installations, commissioning |
| Sales and Proposals | 10 | Split (6 DBN / 4 JHB) | Client engagement, tender submissions |

---

## Naming Conventions

Consistent naming is how IT departments manage infrastructure at scale. Every object in Voltcore's AD environment follows a standard.

### Domain Controllers

```
DC01-DBN.voltcore.co.za    Durban primary Domain Controller
DC02-JHB.voltcore.co.za    Johannesburg Domain Controller
```

### Workstations

```
DBN-WS-001    Durban Workstation 1
DBN-WS-002    Durban Workstation 2
JHB-WS-001    Johannesburg Workstation 1
JHB-WS-002    Johannesburg Workstation 2
```

### User Accounts

```
firstname.lastname@voltcore.co.za
```

Example: `sipho.nkosi@voltcore.co.za`

### Security Groups

```
GRP-Department-Access
```

Examples:
```
GRP-Finance-Access
GRP-Engineering-Files
GRP-IT-Admins
GRP-Executive-VPN
GRP-FieldOps-RemoteAccess
```

---

## Lab Environment

| Machine | Role | IP Address | OS |
|---|---|---|---|
| Host Machine | Daily driver | 192.168.56.1 | Ubuntu 25.10 |
| Ubuntu Server | Linux lab server | 192.168.56.104 | Ubuntu Server 24.04 LTS |
| DC01-DBN | Durban Domain Controller | 192.168.56.102 | Windows Server 2022 |
| DBN-WS-001 | Durban Workstation | 192.168.56.??? | Windows 11 Enterprise |
| DC02-JHB | Johannesburg DC (Phase 2 advanced) | 192.168.56.??? | Windows Server 2022 |

**Note:** DC02-JHB is introduced when reaching AD Sites and Replication. Do not stand it up until the Durban environment is fully working.

---

## Organisational Unit Structure

OUs are how AD organises objects for policy application and delegation. Voltcore's OU structure follows function first, location second.

```
voltcore.co.za
├── _Admin
│   ├── Service Accounts
│   └── Admin Users
├── Durban
│   ├── Users
│   │   ├── Executive
│   │   ├── Finance
│   │   ├── Human Resources
│   │   ├── IT
│   │   ├── Electrical Engineering
│   │   ├── Industrial Automation
│   │   └── Sales and Proposals
│   ├── Computers
│   └── Groups
└── Johannesburg
    ├── Users
    │   ├── IT
    │   ├── Industrial Automation
    │   ├── Field Operations
    │   └── Sales and Proposals
    ├── Computers
    └── Groups
```

---

## Business Problems That AD Solves

Every AD concept in this project exists because of a real business problem. This section maps problems to solutions so nothing is built without a reason.

| Business Problem | AD Solution | Concept Learned |
|---|---|---|
| 80 employees need accounts — cannot create one by one | PowerShell bulk user creation from CSV | Automation, New-ADUser |
| New employee joins — account must be ready on day one | HR submits onboarding form, IT runs script | Scripted provisioning |
| Employee leaves — access must be revoked immediately across both offices | Disable account in AD — applies everywhere | Centralised identity |
| Finance must not access engineering file shares | Security group permissions on shared folders | NTFS permissions, group-based access |
| Executive laptops must lock after 2 minutes | Group Policy Object applied to Executive OU | GPO, computer policy |
| General staff must not install software | Restrict software installation via GPO | Software restriction policy |
| IT department needs admin rights, nobody else does | IT group added to local Administrators via GPO | Restricted Groups GPO |
| Field engineers need VPN access from sites | VPN access group, GPO pushes VPN client config | Remote access policy |
| Johannesburg users cannot authenticate if Durban DC is down | Second Domain Controller in Johannesburg | AD replication, redundancy |
| Password policy must be enforced across all users | Fine-grained password policy or Default Domain Policy | Password policy GPO |
| Shared drives must be automatically mapped on login | Drive mapping via GPO preferences | GPO preferences |
| New workstation must be configured consistently | GPO applies standard settings on domain join | Computer configuration GPO |

---

## Build Sequence — What to Learn as You Build

Each stage introduces new concepts through the project. Nothing is learned in isolation.

### Stage 1 — Foundation (Days 26-28)
**Build:** Promote Windows Server to Domain Controller for voltcore.co.za

**Learn:**
- What a Domain Controller is and what changes when you promote a server
- DNS role — AD requires DNS, understand why
- The difference between a workgroup and a domain
- What the SYSVOL and NETLOGON shares are

**Deliverable:** DC01-DBN.voltcore.co.za is the authoritative DC for voltcore.co.za

---

### Stage 2 — Organisational Structure (Days 29-30)
**Build:** Create the full OU structure for Voltcore

**Learn:**
- What OUs are and why they exist
- OU design principles — function vs geography
- Delegation of control — giving HR the ability to reset passwords without making them admins
- How OUs affect GPO application

**Deliverable:** Full OU tree matching the Voltcore structure above

---

### Stage 3 — Bulk User Creation (Days 31-32)
**Build:** Create all 80 Voltcore employees using PowerShell and a CSV file

**Learn:**
- New-ADUser, Set-ADUser, Get-ADUser
- Reading from CSV with Import-Csv
- Looping through records and creating accounts in bulk
- Setting user attributes — department, office, job title, manager
- Placing users in the correct OU automatically based on department

**Deliverable:** 80 user accounts created via script, placed in correct OUs, with realistic attributes

**Sample CSV structure:**
```
FirstName,LastName,Department,Office,JobTitle,OU
Sipho,Nkosi,Finance,Durban,Accountant,"OU=Finance,OU=Durban,DC=voltcore,DC=co,DC=za"
Ayanda,Dlamini,IT,Johannesburg,Systems Administrator,"OU=IT,OU=Johannesburg,DC=voltcore,DC=co,DC=za"
```

---

### Stage 4 — Security Groups and Permissions (Days 33-34)
**Build:** Create security groups and assign them to shared folder permissions

**Learn:**
- Security groups vs distribution groups
- Group scope — domain local, global, universal
- NTFS permissions vs Share permissions and why both matter
- Nested groups — putting groups inside groups
- The principle of least privilege applied to file access

**Groups to create:**
```
GRP-Finance-Access          Finance shared drive
GRP-Engineering-Files       Engineering project files
GRP-IT-Admins               Local admin on all workstations
GRP-Executive-VPN           VPN access
GRP-FieldOps-RemoteAccess   Remote desktop to office machines
GRP-AllStaff                General shared resources
```

**Deliverable:** Shared folders created, permissions assigned to groups, users access files through group membership only

---

### Stage 5 — Group Policy (Days 35-37)
**Build:** Create and apply GPOs for real Voltcore business requirements

**Learn:**
- GPO structure — computer configuration vs user configuration
- GPO inheritance and precedence
- Enforced vs block inheritance
- GPO filtering with security groups
- Resultant Set of Policy — seeing what policies actually apply to a user

**GPOs to build:**

| GPO Name | Applied To | What It Does |
|---|---|---|
| Voltcore-Password-Policy | Domain | Minimum 10 chars, complexity, 90 day expiry |
| Voltcore-Executive-Security | Executive OU | Screen lock after 2 minutes, no removable media |
| Voltcore-Software-Restriction | All Staff OU | Block software installation for non-IT users |
| Voltcore-IT-LocalAdmin | IT OU | Add IT group to local Administrators on all machines |
| Voltcore-Drive-Mapping | Department OUs | Map shared drives automatically on login |
| Voltcore-Desktop-Standard | Computers OU | Standard desktop wallpaper, disable control panel |

**Deliverable:** All GPOs created, linked to correct OUs, verified with gpresult on workstation

---

### Stage 6 — Domain Join and Workstation Management (Days 38-39)
**Build:** Join DBN-WS-001 (Windows 11 Enterprise) to voltcore.co.za

**Learn:**
- What happens technically when a machine joins a domain
- The difference between local accounts and domain accounts on a workstation
- How GPOs land on the workstation after domain join
- Computer accounts in AD — machines have accounts too
- Login with domain credentials vs local credentials

**Deliverable:** DBN-WS-001 joined to domain, logged in as a Voltcore domain user, GPOs confirmed applying

---

### Stage 7 — Remote Management (Days 40-41)
**Build:** Manage workstations remotely without physically accessing them

**Learn:**
- Remote Desktop Protocol — RDP
- Windows Remote Management — WinRM
- Remote Server Administration Tools — RSAT
- PowerShell remoting — running commands on remote machines
- Managing multiple machines from one console

**Deliverable:** Manage DBN-WS-001 from DC01-DBN without touching the workstation VM directly

---

### Stage 8 — AD Troubleshooting (Day 42)
**Build:** Break things intentionally and fix them

**Learn:**
- dcdiag — test Domain Controller health
- repadmin — check replication status
- nltest — test secure channel between workstation and DC
- Event Viewer — security and system logs for AD events
- Common AD break scenarios and how to diagnose them

**Things to break:**
- Disconnect workstation from network — what happens to domain login?
- Corrupt a GPO — what does gpresult show?
- Lock out a user account — how to unlock and why lockout happens

**Deliverable:** Break-fix log documenting each scenario, symptom, diagnosis, and resolution

---

### Stage 9 — Johannesburg DC and Replication (Days 43-44)
**Build:** Promote a second Windows Server to DC02-JHB.voltcore.co.za

**Learn:**
- Additional Domain Controllers — why redundancy matters
- AD replication — how changes on one DC reach the other
- AD Sites and Services — telling AD about physical office locations
- Site links — controlling replication traffic between sites
- FSMO roles — which DC is authoritative for what

**Deliverable:** DC02-JHB joined to voltcore.co.za, replication verified between both DCs, Sites configured for Durban and Johannesburg

---

### Stage 10 — Documentation and Runbook (Day 45)
**Build:** Full documentation of the Voltcore AD environment

**Write:**
- Network and AD topology diagram
- OU structure with explanation of design decisions
- Group Policy reference — every GPO, where it applies, what it does
- User provisioning procedure — step by step for new employees
- Offboarding procedure — what to do when an employee leaves
- Troubleshooting guide — common AD problems and fixes
- Recovery procedure — what to do if the DC goes down

**Deliverable:** Complete Voltcore AD runbook that a new IT hire could use to understand and operate the environment

---

## PowerShell Reference — Commands Used in This Project

```powershell
# Create a single user
New-ADUser -Name "Sipho Nkosi" -SamAccountName "sipho.nkosi" -UserPrincipalName "sipho.nkosi@voltcore.co.za" -Path "OU=Finance,OU=Durban,DC=voltcore,DC=co,DC=za" -AccountPassword (ConvertTo-SecureString "Welcome@123" -AsPlainText -Force) -Enabled $true

# Get user details
Get-ADUser -Identity "sipho.nkosi" -Properties *

# Add user to group
Add-ADGroupMember -Identity "GRP-Finance-Access" -Members "sipho.nkosi"

# Disable a user account
Disable-ADAccount -Identity "sipho.nkosi"

# Unlock a locked account
Unlock-ADAccount -Identity "sipho.nkosi"

# Check which groups a user belongs to
Get-ADPrincipalGroupMembership -Identity "sipho.nkosi"

# Force GPO update on a remote machine
Invoke-GPUpdate -Computer "DBN-WS-001" -Force

# Check GPO result for a user
gpresult /r /user voltcore\sipho.nkosi

# Check DC health
dcdiag /v

# Check replication status
repadmin /replsummary
```

---
