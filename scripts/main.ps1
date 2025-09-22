#Requires -Modules GitHub

$scriptName = $MyInvocation.MyCommand.Name
Write-Debug "[$scriptName] - Start"

$Lock = $env:PSMODULE_TEMPLATE_ACTION_INPUT_Lock ?? 'false'

LogGroup 'terraform init' {
    terraform init -lock="$Lock"
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
}

Write-Debug "[$scriptName] - End"
