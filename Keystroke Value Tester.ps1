#[Enum]::GetNames([System.Management.Automation.Host.ControlKeyStates])


<#
DO {
WRite-Host "Press a Key..."
$KeyPress = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
$KeyPress | Format-Table

}until ($keypress.key -eq "123123")

#>

Function ReadKeyCHAR { # KeyMode1 - Has a Timeout Function: One keystroke only, No Enter Required (Uses $Host.UI.RawUI.ReadKey)
    Param(
    $TimeToWait = 60,
    $DefaultKeystroke = 'Q')

    $StartTime = Get-Date
    $TimeOut = New-TimeSpan -Seconds $TimeToWait

    Write-Host "Begin"
    $Prompt = "Press a key..."



    While (-not $host.ui.RawUI.KeyAvailable) {
    $CurrentTime = Get-Date 
        IF ($CurrentTime -gt $startTime + $TimeOut) {Break}
    }

    IF ($host.ui.RawUI.KeyAvailable) {
        DO {$Script:response = $host.ui.RawUI.ReadKey("IncludeKeyDown,NoEcho");$K = $Response.Character;Write-Host "The Value of K is: $K"} UNTIL ($K -gt "0")
    }
        
    #Write-Host "Your Response Record is: " -f Red
    #$Response.character
    
    Write-Output "Your Keystroke record is: ";$Response | Format-Table
    
    [string]$K = $Response.Character
    Write-Host -no "The Value of K is:" -f Red;Write-Host $K  -f Green
    ReadKeyCHAR
}

Function ReadKeyRAW { # KeyMode1 - Has a Timeout Function: One keystroke only, No Enter Required (Uses $Host.UI.RawUI.ReadKey)
    
    Write-Host "Begin"
    $Prompt = "Press a key..."
       
        DO {[array]$Response = $host.ui.RawUI.ReadKey("IncludeKeyDown,NoEcho");$Response} UNTIL ($Response.Character -eq "q")
    
    If ($Response.Character -eq "q") {CLS;ReadKeyRAW}
    
    $Global:K = $Response.Character

    #;Set-Variable -Name K -Value $Response.Character
    
        Write-Host ""
        Start-Sleep -Milliseconds 250
        Write-Host "################################################"
        Write-Host -no "Attributes of Response are: " -F Red;Get-Variable -Name Response | Select *;Start-Sleep -Milliseconds 500
        Write-Host "################################################"
        Write-Host -no "Attributes of K are: " -F Red;Get-Variable -Name K | Select *;Start-Sleep -Milliseconds 500
        Write-Host "################################################"
        Write-Host "The Response Record Values are: " -F Red;$Response
        
    
        
    #Write-Host "Your Response Record is: " -f Red
    #$Response.character
    
    Write-Output "Your Keystroke record is: ";$Response | Format-Table 
    
    Write-Host -no "The Value of K is:" -f Red;Write-Host $K -f Green
    ReadKeyRAW
}

Function ReadKeyMenu {

    Write-Host "This must NOT be run in ISE" -F Red

    Write-Host ""
    Write-Host "Please make a choice from the following:"
    Write-Host "Hit R for RAW Read"
    Write-Host "Hit C for CHAR Read"
    Write-Host ""
    $choice = Read-Host "Selection?"
    SwitchTo
}    
    
Function SwitchTo {    
        Switch ($choice) {
            R {ReadKeyRAW}
            C {ReadKeyCHAR}
            Default {ReadKeyMenu}
        }
}

ReadKeyMenu
