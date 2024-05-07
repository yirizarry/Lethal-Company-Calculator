# Powershell script to calculate OT for Lethal Company
# made by zarrycherry

try {
    $continue = $true
    while($continue)
    {
        # Prompts user input for credit amount of scrap sold and current quota and stores
        # the results in their respective variables
        
        $itemsSold = Read-Host "Enter the credit amount of Scrap sold "
        $quota = Read-Host "Enter the current quota "
        
        # evaluates whether the string input value contains any numbers between 0-9, 
        # with ^ checking the beginning of the string and until the end, + indicates multiple values
        if ($itemsSold -match '^[0-9]+$') 
        {
            if ($quota -match '^[0-9]+$')
            {
                # Formula to calculate OT bonus itemsSold subracted by quota divided by 5 and substracted by 15 
                $OT = ([float]$itemsSold - [float]$quota) / 5 - 15

                # conditional statement checks whether the OT bonus is above 0
                # if it is less than 0 or equal to 0 the player is informed that he 
                # wont receive an OT bonus
                if ([float]$OT -le 0)
                {
                    Write-Host -ForegroundColor DarkRed "No Overtime Bonus received"
                    $continue = $false
                } else {
                    $OT = [math]::Round($OT,2)
                    # informs user how much credits the OT bonus is
                    Write-Host -ForegroundColor DarkGreen "The calculated OT bonus is: $OT credits"

                    # summarizes the total, since value of the prompts was originally
                    # saved as a string we have to specifically cast these values to integers
                    $total = [float]$itemsSold + [float]$OT
                    $total = [math]::Round($total,2)
                    Write-Host -ForegroundColor DarkGreen "The total of the items sold and OT bonus is: $total credits"
                    $continue = $false
                }
            } else {
                    Write-Host -ForegroundColor DarkRed "Wrong input, ensure input only contains positive integers. Try again."
            }   
        } else {
            Write-Host -ForegroundColor DarkRed "Wrong input, ensure input only contains positive integers. Try again."
        }
    } 
}
catch {
    Write-Host  -ForegroundColor DarkRed "Error: $($PSItem.ToString())"
    Write-Host "$($PSItem.ScriptStackTrace)"
}

