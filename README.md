# Terraform Init GitHub Action

This action runs `terraform init` in a specified working directory as part of your IaC pipeline. It wraps a reusable PowerShell-based composite action that can optionally install/update the required supporting PowerShell module version, control prerelease usage, toggle locking behavior, and provide debug/verbose output for easier troubleshooting.

## Features

- Executes `terraform init` in a chosen working directory (`WorkingDirectory` input; defaults to the repository root).
- Optional state lock control via the `Lock` input.
- Supports explicit module `Version` and allowing prereleases with `Prerelease`.
- Adjustable verbosity: `Debug` and `Verbose` flags.
- Pure composite action (no container) for fast startup.

## Inputs

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| `Lock` | No | `false` | Whether to lock the state file when running `terraform init`. Accepts `true` or `false`. |
| `Debug` | No | `false` | Enable debug output (adds diagnostic logging). |
| `Verbose` | No | `false` | Enable verbose output for more detailed operational logs. |
| `Version` | No | (none) | Exact version of the GitHub PowerShell module to install/use. If omitted, the module's default resolution logic applies. |
| `Prerelease` | No | `false` | Allow prerelease versions when resolving the module, if available. |
| `WorkingDirectory` | No | `${{ github.workspace }}` | Directory from which `terraform init` will be executed. |

## Outputs

This action does not currently set any explicit outputs.

## Secrets

No secrets are required. Provide any Terraform backend authentication separately (e.g., through environment variables, OpenID Connect, or other mechanism) before invoking this action.

## Example Usage

Minimal example (uses defaults):

```yaml
name: Terraform Init
on:
	workflow_dispatch:
	push:
		branches: [ main ]

jobs:
	init:
		runs-on: ubuntu-latest
		steps:
			- name: Checkout
				uses: actions/checkout@v4

			- name: Set up Terraform
				uses: hashicorp/setup-terraform@v3
				with:
					terraform_version: 1.9.2

			- name: Terraform Init
				uses: TFActions/Terraform-Init@v1
				with:
					WorkingDirectory: ./infra
```

With optional flags:

```yaml
- name: Terraform Init (Verbose + Lock + Specific Module Version)
	uses: TFActions/Terraform-Init@v1
	with:
		WorkingDirectory: ./infra
		Lock: true
		Verbose: true
		Debug: false
		Version: 1.2.3
		Prerelease: false
```

## Contributing

Issues and pull requests are welcome. Please open an issue describing enhancements or problems before large changes.

## License

Licensed under the terms of the `LICENSE` file in this repository.

