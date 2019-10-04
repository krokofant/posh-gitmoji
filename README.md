# Installation

First install dependencies, [the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

```powershell
# Run as admin
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'
az login
```

To autocomplete Azure DevOps story IDs you need to setup your default azure devops organization and project:

```powershell
az devops configure --defaults organization=$(Read-Host DefaultOrganizationURL) project=$(Read-Host DefaultProjectName)
```

Then install the module:

```powershell
Install-Module posh-gitmoji -Scope CurrentUser
```

By default the module will try and fetch the stories from _a certain AreaPath_ in your default az organization.
To specify which area path run the following:

```powershell
gitmoji -AreaPath Example\Area
```
