#Requires -Modules GitHub

[CmdletBinding()]
param(
    [Parameter()]
    [string] $Lock = $env:PSMODULE_TEMPLATE_ACTION_INPUT_Lock ?? 'false'
)

begin {
    $scriptName = $MyInvocation.MyCommand.Name
    Write-Debug "[$scriptName] - Start"
}

process {
    LogGroup 'Terraform Init' {
        terraform init -lock=$Lock
        if ($LASTEXITCODE -ne 0) {
            exit $LASTEXITCODE
        }
    }
}

end {
    Write-Debug "[$scriptName] - End"
}
