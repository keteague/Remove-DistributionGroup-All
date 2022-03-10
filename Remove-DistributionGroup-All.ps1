$email = Read-Host "Please provide a user's email address to remove from all distribution groups"

$mailbox = Get-Mailbox -Identity $email

$DN=$mailbox.DistinguishedName

$Filter = "Members -like ""$DN"""

$DistributionGroupsList = Get-DistributionGroup -ResultSize Unlimited -Filter $Filter

Write-host `n
Write-host "Listing all Distribution Groups:"
Write-host `n
$DistributionGroupsList | ft

$answer = Read-Host "Would you like to proceed and remove $email from all distribution groups ( y / n )?" 

While ("y","n" -notcontains $answer) {
    $answer = Read-Host "Would you like to proceed and remove $email from all distribution groups ( y / n )?"
    }

If ($answer -eq 'y') {

    ForEach ($item in $DistributionGroupsList) {
        Remove-DistributionGroupMember -Identity $item.DisplayName –Member $email –BypassSecurityGroupManagerCheck -Confirm:$false
    }
    
    Write-host `n
    Write-host "Successfully removed"

    Remove-Variable * -ErrorAction SilentlyContinue
    }

Else

    {
    Remove-Variable * -ErrorAction SilentlyContinue
    }
