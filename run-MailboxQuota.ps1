Import-Module -Name '.\function\Set-MailboxQuota.psm1'

# Import des identifiants administrateur 365
$Credential = Import-CliXml -Path '.\PATH\TO\cred.cred'


# Connexion à Exchange Online
Connect-ExchangeOnline -Credential $Credential
# Connexion à Azure AD
Connect-AzureAD -Credential $Credential

# 2 GB
Set-MailboxQuota -GroupeObjectId 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX' -WarningQuota "1.9 GB" -SendQuota "2 GB" -SendReceiveQuota "5 GB" -ShowInfo
# 5 GB
Set-MailboxQuota -GroupeObjectId 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX' -WarningQuota "4.8 GB" -SendQuota "5 GB" -SendReceiveQuota "10 GB" -ShowInfo
# 10 GB
Set-MailboxQuota -GroupeObjectId 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX' -WarningQuota "9.5 GB" -SendQuota "10 GB" -SendReceiveQuota "20 GB" -ShowInfo
# 20 GB
Set-MailboxQuota -GroupeObjectId 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX' -WarningQuota "19 GB" -SendQuota "20 GB" -SendReceiveQuota "50 GB" -ShowInfo    

# Fin de session Exchange Online (Sans demande de confirmation)
Disconnect-ExchangeOnline -Confirm:$false
# Fin de session AD Azure (Sans demande de confirmation)
Disconnect-AzureAD -Confirm:$false

Read-Host -Prompt "Press any key to continue"
