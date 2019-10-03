# Installation

First install dependencies

```powershell
Install-Module Configuration -Scope CurrentUser
```

And if you'd like to autocomplete Azure DevOps story IDs your need the azure cli as well:
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

Then install the module:

```powershell
Install-Module posh-gitmoji -Scope CurrentUser
```

By default the module will try and fetch the stories from _a certain AreaPath_ in your default az organization.
To specify which area path run the following:

```powershell
gitmoji -AreaPath Example\Area
```
