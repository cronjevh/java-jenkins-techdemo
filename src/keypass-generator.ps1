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
        $password = -join (0..$length | % { $characterList | Get-Random })
        [int]$hasLowerChar = $password -cmatch '[a-z]'
        [int]$hasUpperChar = $password -cmatch '[A-Z]'
        [int]$hasDigit = $password -match '[0-9]'
        [int]$hasSymbol = $password.IndexOfAny($symbols) -ne -1

    }
    until (($hasLowerChar + $hasUpperChar + $hasDigit + $hasSymbol) -ge 3)

    $password
}

# Not bothering with error handling - run once script created per cluster
kubectl delete secret sampleapp-secret

$keystorePassVar = $(GeneratePassword -length 20)
kubectl create secret generic sampleapp-secret --from-literal=keystorePass=$keystorePassVar
docker build . -t sampleapp --build-arg $keystorePassVar