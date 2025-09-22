#Requires -Modules GitHub

[CmdletBinding()]
param(
    [Parameter()]
    [string] $Lock = $env:PSMODULE_TEMPLATE_ACTION_INPUT_Lock ?? 'false'
)

LogGroup 'Terraform Init' {
    terraform init -lock="$Lock"
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
}
