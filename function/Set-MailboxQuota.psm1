function Set-MailboxQuota {
    <#
	.SYNOPSIS
    Gère le quota des boîtes mail Exchange Online d'un groupe de distribution Ad Azure
	
	.PARAMETER GroupeObjectId
        ObjectId du groupe (disponible via Azure AD)
	
	.PARAMETER WarningQuota
        Quota à partir duquel une alerte est donnée

	.PARAMETER SendQuota
		Quota à partir duquel l'utilisateur ne peut plus envoyer de mail

	.PARAMETER SendReceiveQuota
		Quota à partir duquel l'utilisateur ne peut plus envoyer ni recevoir de mail

	.PARAMETER ShowInfo
		Si actif, montre le nom des utilisateurs ainsi que leur quota (s'ils ont été modifiés part la fonction)
	
	.EXAMPLE
		PS C:\> SetMailboxQuota -CredentialPath C:\PATH\cred.cred -GroupeObjectId 'e332211a-XXXX-XXXX-XXXX-XXXXXXXXXXXX' -WarningQuota "1,9 GB" -SendQuota "2 GB" -SendReceiveQuota "5 GB" -ShowInfo
        Définit le quota du groupe de distribution ayant l'ObjectId 'e332211a-XXXX-XXXX-XXXX-XXXXXXXXXXXX' à 1,9 GB, 2 GB et 5 GB. montre également les utilisateurs mis à jours.
	#>

    [CmdletBinding()]
    param (
        # ObjectId du groupe
        [Parameter(Mandatory = $true)]
        [string]$GroupeObjectId,

        # Quota d'avertissement
        [Parameter(Mandatory = $true)]
        [string]$WarningQuota,

        # Quota de suspension d'envoi
        [Parameter(Mandatory = $true)]
        [string]$SendQuota,

        # Quota de suspension d'envoi et de réception
        [Parameter(Mandatory = $true)]
        [string]$SendReceiveQuota,

        # Montre les infos des boîtes mails
        [Parameter(Mandatory = $false)]
        [switch]$ShowInfo
    )

    # Récupérer toutes les adresses e-mail du groupe
    $GroupeMembers = Get-AzureADGroupMember -ObjectId $GroupeObjectId

    # Pour chaque boîte mail on définit son quota (Avertissement, bloquage d'envoi et bloquage d'envoi et de récéption)
    if ($GroupeMembers.count) {
        #Vérifier si le groupe contient quelque chose
        $GroupeMembers | ForEach-Object {

            # Récupération de la boîte mail du membre du groupe
            $Mailbox = Get-Mailbox -Identity $_.ObjectId

            # Si la boîte mail n'a pas le même quota que celui fixé, on le met à jour
            if ($Mailbox.ProhibitSendQuota -notlike "$SendQuota*") {
                Set-Mailbox -Identity $_.ObjectId -IssueWarningQuota $WarningQuota -ProhibitSendQuota $SendQuota -ProhibitSendReceiveQuota $SendReceiveQuota -UseDatabaseQuotaDefaults:$false
            }
            # Verbose
            if ($ShowInfo) {
                Write-Host "$($_.UserPrincipalName) `t`t ==> `t`t $SendQuota"
            }
        }
    }

}

