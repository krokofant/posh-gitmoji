[pscustomobject[]]$script:EMOJIS = (Get-Content $PSScriptRoot/gitmojis.json | ConvertFrom-Json).gitmojis

$script:Config = @{
    AreaPath = ""
}

$ConfigLocation = "$env:USERPROFILE/.config/posh-gitmoji/config.json"
function SaveConfig { Set-Content $ConfigLocation (ConvertTo-Json $script:Config); return }
function ReloadConfig { $script:Config = ConvertFrom-Json (Get-Content -Raw $ConfigLocation); return }

if (!(Test-Path $ConfigLocation)) {
    New-Item -ItemType Directory "$ConfigLocation/.." -ErrorAction Ignore
    SaveConfig
}
ReloadConfig

$script:LastAzureQueryDate = $null
[System.Management.Automation.Job]$script:AzureQueryJob = $null
function GetAzureQueryString {
    @"
Select [System.Id], [System.Title], [System.State], [System.AreaPath] From WorkItems Where [State] = 'Developing' AND [System.AreaPath] = '$($script:Config.AreaPath)' order by [System.CreatedDate] desc
"@
}


function GetActiveStories {
    if (($null -eq $script:LastAzureQueryDate) -or (($(Get-Date) - $script:LastAzureQueryDate).TotalSeconds -gt 60) ) {
        $script:AzureQueryJob = Start-Job -InputObject $(GetAzureQueryString) -ScriptBlock { [pscustomobject[]]$items = az boards query --wiql $input | ConvertFrom-Json; $items | ForEach-Object { [pscustomobject]@{id = $_.fields.'System.Id'; title = $_.fields.'System.Title'; } } }
        $script:LastAzureQueryDate = Get-Date
        $script:AzureQueryJob | Wait-Job | Out-Null
        return Receive-Job $script:AzureQueryJob -Keep
    }
    return Receive-Job $script:AzureQueryJob -Keep
}

function gitmoji {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]]$Type,
        [Parameter()]
        [string]$Message,
        [Parameter()]
        [switch]$All,
        [Parameter()]
        [string]$Story = $null,
        [string]$AreaPath
    )
    if ($AreaPath) {
        $script:Config.AreaPath = $AreaPath
        SaveConfig
        return
    }
    $command = "git commit $(if($All){'-a '})-m `"$($Type -join '') $($(if($Story){"#$Story "}))$Message`""
    Write-Host "> " -ForegroundColor DarkBlue -NoNewline
    Write-Host $command -ForegroundColor Yellow
    Invoke-Expression $command
}

$gitmojiTypeCompleter = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    [scriptblock]$RenderHint = { "$($_.emoji) <# $($_.description) #> " }
    if ($wordToComplete.Length -eq 0) {
        return $script:EMOJIS | ForEach-Object $RenderHint
    }
    $codeMatches = $script:EMOJIS | Where-Object { ($_.code).StartsWith($wordToComplete) } | ForEach-Object $RenderHint
    $codeContains = $script:EMOJIS | Where-Object { ($_.code) -match "$wordToComplete" } | ForEach-Object $RenderHint
    $descContains = $script:EMOJIS | Where-Object { ($_.description) -match "$wordToComplete" } | ForEach-Object $RenderHint
    @($codeMatches) + $codeContains + $descContains | Sort-Object -Unique
}
Register-ArgumentCompleter -CommandName gitmoji -ParameterName Type -ScriptBlock $gitmojiTypeCompleter

$storyIdCompleter = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    [scriptblock]$RenderHint = { "'$($_.id)' <# $($_.title) #> " }
    return GetActiveStories | ForEach-Object $RenderHint
}
Register-ArgumentCompleter -CommandName gitmoji -ParameterName Story -ScriptBlock $storyIdCompleter


Export-ModuleMember -Function @(
    "gitmoji"
)
