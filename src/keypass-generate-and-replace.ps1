# To be run manually to create a secret in the local k8s default namespace to use with ssl

# Random password generator for PowershellCore from https://dev.to/onlyann/user-password-generation-in-powershell-core-1g91

$symbols = '!@#$%^&*'.ToCharArray()
$characterList = 'a'..'z' + 'A'..'Z' + '0'..'9' + $symbols

function GeneratePassword {
    param(
        [ValidateRange(12, 256)]
        [int] 
        $length = 14
    )

    do {
        $password = -join (0..$length | ForEach-Object { $characterList | Get-Random })
        [int]$hasLowerChar = $password -cmatch '[a-z]'
        [int]$hasUpperChar = $password -cmatch '[A-Z]'
        [int]$hasDigit = $password -match '[0-9]'
        [int]$hasSymbol = $password.IndexOfAny($symbols) -ne -1

    }
    until (($hasLowerChar + $hasUpperChar + $hasDigit + $hasSymbol) -ge 3)

    $password
}

Write-Host 'Generating random keystorePass value'
$keystorePassVar = $(GeneratePassword -length 20)

Write-Host 'Doing variable replacement of keystorePass for text value __changeme__'
$stringToReplace = '__changeme__'
$filesToReplace = Get-ChildItem -Recurse -Path mavenitis | Select-String $stringToReplace | Select-Object -Unique Path

foreach ($file in $filesToReplace.Path) {
    ((Get-Content -path $file) -replace ($stringToReplace, $keystorePassVar)) | Set-Content -Path $file
}

Write-Host 'Agent secret stored temporarily in ephemeral agent storage to be applied in a later step with kubectl'
$keystorePassVar | Out-File keystorePass

