# posh-gitmoji

posh-gitmoji makes it easier to use [gitmoji](https://github.com/carloscuesta/gitmoji/) in your terminal. It work's best with the [Windows Terminal](https://github.com/microsoft/terminal) for it's emoji support so you can see the emojis rendered before you make your commits.

![Commands](./docs/src/assets/images/gitmoji-commands-full.png)

# Installation

```powershell
Install-Module posh-gitmoji
```

Now you can type `gitmoji <tab>` and `<tab>` to autocomplete any gitmoji

## Additional stuff (Optional)

First install dependencies:

- [Windows Terminal](https://github.com/microsoft/terminal)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) _(optional)_

```powershell
# Run as admin
choco install -y microsoft-windows-terminal
choco install -y azure-cli
```

To autocomplete Azure DevOps story IDs you need to setup your default azure devops organization and project:

```powershell
az extension add --name azure-devops
az login
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
