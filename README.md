# EXCO-Mailbox-Group-Storage-Limit
Powershell function that allow you to easily change Storage limite of an Azure AD group

# Prerequisite
Install AzureAD and ExchangeOnline's modules with :

```powershell
# Install ExchangeOnline module
Install-Module -Name ExchangeOnlineManagemen

# Install AzureAD module
Install-Module -Name AzureAD
```

Create a .cred file with the credential of your admin account :

```powershell
$Path = Read-Host "Path"
Get-Credential | Export-CliXml -Path "$Path\pass.cred"
```

Get your users in a specific group (one for thoses with 2Go, one for others with 5Go etc....)

Recommended : Using dynamic membership rules on AzureAD and extendedAttributeX to easily sort all users.


