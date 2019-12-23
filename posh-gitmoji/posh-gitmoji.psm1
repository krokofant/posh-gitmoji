$script:EMOJIS = [pscustomobject[]]@(
    @{emoji = "🎨"; code = "art"; desc = "Improving structure / format of the code." },
    @{emoji = "⚡️"; code = "zap"; desc = "Improving performance." },
    @{emoji = "🔥"; code = "fire"; desc = "Removing code or files." },
    @{emoji = "🐛"; code = "bug"; desc = "Fixing a bug." },
    @{emoji = "🚑"; code = "ambulance"; desc = "Critical hotfix." },
    @{emoji = "✨"; code = "sparkles"; desc = "Introducing new features." },
    @{emoji = "📝"; code = "pencil"; desc = "Writing docs." },
    @{emoji = "🚀"; code = "rocket"; desc = "Deploying stuff." },
    @{emoji = "💄"; code = "lipstick"; desc = "Updating the UI and style files." },
    @{emoji = "🎉"; code = "tada"; desc = "Initial commit." },
    @{emoji = "✅"; code = "white_check_mark"; desc = "Updating tests." },
    @{emoji = "🔒"; code = "lock"; desc = "Fixing security issues." },
    @{emoji = "🍎"; code = "apple"; desc = "Fixing something on macOS." },
    @{emoji = "🐧"; code = "penguin"; desc = "Fixing something on Linux." },
    @{emoji = "🏁"; code = "checkered_flag"; desc = "Fixing something on Windows." },
    @{emoji = "🤖"; code = "robot"; desc = "Fixing something on Android." },
    @{emoji = "🍏"; code = "green_apple"; desc = "Fixing something on iOS." },
    @{emoji = "🔖"; code = "bookmark"; desc = "Releasing / Version tags." },
    @{emoji = "🚨"; code = "rotating_light"; desc = "Removing linter warnings." },
    @{emoji = "🚧"; code = "construction"; desc = "Work in progress." },
    @{emoji = "💚"; code = "green_heart"; desc = "Fixing CI Build." },
    @{emoji = "⬇️"; code = "arrow_down"; desc = "Downgrading dependencies." },
    @{emoji = "⬆️"; code = "arrow_up"; desc = "Upgrading dependencies." },
    @{emoji = "📌"; code = "pushpin"; desc = "Pinning dependencies to specific versions." },
    @{emoji = "👷"; code = "construction_worker"; desc = "Adding CI build system." },
    @{emoji = "📈"; code = "chart_with_upwards_trend"; desc = "Adding analytics or tracking code." },
    @{emoji = "♻️"; code = "recycle"; desc = "Refactoring code." },
    @{emoji = "🐳"; code = "whale"; desc = "Work about Docker." },
    @{emoji = "➕"; code = "heavy_plus_sign"; desc = "Adding a dependency." },
    @{emoji = "➖"; code = "heavy_minus_sign"; desc = "Removing a dependency." },
    @{emoji = "🔧"; code = "wrench"; desc = "Changing configuration files." },
    @{emoji = "🌐"; code = "globe_with_meridians"; desc = "Internationalization and localization." },
    @{emoji = "✏️"; code = "pencil2"; desc = "Fixing typos." },
    @{emoji = "💩"; code = "poop"; desc = "Writing bad code that needs to be improved." },
    @{emoji = "⏪"; code = "rewind"; desc = "Reverting changes." },
    @{emoji = "🔀"; code = "twisted_rightwards_arrows"; desc = "Merging branches." },
    @{emoji = "📦"; code = "package"; desc = "Updating compiled files or packages." },
    @{emoji = "👽"; code = "alien"; desc = "Updating code due to external API changes." },
    @{emoji = "🚚"; code = "truck"; desc = "Moving or renaming files." },
    @{emoji = "📄"; code = "page_facing_up"; desc = "Adding or updating license." },
    @{emoji = "💥"; code = "boom"; desc = "Introducing breaking changes." },
    @{emoji = "🍱"; code = "bento"; desc = "Adding or updating assets." },
    @{emoji = "👌"; code = "ok_hand"; desc = "Updating code due to code review changes." },
    @{emoji = "♿️"; code = "wheelchair"; desc = "Improving accessibility." },
    @{emoji = "💡"; code = "bulb"; desc = "Documenting source code." },
    @{emoji = "🍻"; code = "beers"; desc = "Writing code drunkenly." },
    @{emoji = "💬"; code = "speech_balloon"; desc = "Updating text and literals." },
    @{emoji = "🗃"; code = "card_file_box"; desc = "Performing database related changes." },
    @{emoji = "🔊"; code = "loud_sound"; desc = "Adding logs." },
    @{emoji = "🔇"; code = "mute"; desc = "Removing logs." },
    @{emoji = "👥"; code = "busts_in_silhouette"; desc = "Adding contributor(s)." },
    @{emoji = "🚸"; code = "children_crossing"; desc = "Improving user experience / usability." },
    @{emoji = "🏗"; code = "building_construction"; desc = "Making architectural changes." },
    @{emoji = "📱"; code = "iphone"; desc = "Working on responsive design." },
    @{emoji = "🤡"; code = "clown_face"; desc = "Mocking things." },
    @{emoji = "🥚"; code = "egg"; desc = "Adding an easter egg." },
    @{emoji = "🙈"; code = "see_no_evil"; desc = "Adding or updating a .gitignore file" },
    @{emoji = "📸"; code = "camera_flash"; desc = "Adding or updating snapshots" },
    @{emoji = "⚗"; code = "alembic"; desc = "Experimenting new things" },
    @{emoji = "🔍"; code = "mag"; desc = "Improving SEO" },
    @{emoji = "☸️"; code = "wheel_of_dharma"; desc = "Work about Kubernetes" },
    @{emoji = "🏷️"; code = "label"; desc = "Adding or updating types (Flow, TypeScript)" },
    @{emoji = "🌱"; code = "seedling"; desc = "Adding or updating seed files" },
    @{emoji = "🚩"; code = "triangular_flag_on_post"; desc = "Adding, updating, or removing feature flags" },
    @{emoji = "🥅"; code = "goal_net"; desc = "Catching errors" },
    @{emoji = "💫"; code = "dizzy"; desc = "Adding or updating animations and transitions" }
)

$script:Config = @{
    AreaPath = ""
}

$ConfigLocation = Join-Path $PSScriptRoot "gitmoji.config.json"
function SaveConfig { Set-Content $ConfigLocation (ConvertTo-Json $script:Config); return }
function ReloadConfig { $script:Config = ConvertFrom-Json (Get-Content -Raw $ConfigLocation); return }

if (Test-Path $ConfigLocation) { ReloadConfig }

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
        [string]$Type,
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
    $command = "git commit $(if($All){'-a '})-m `"$Type $($(if($Story){"#$Story "}))$Message`""
    Write-Host "> " -ForegroundColor DarkBlue -NoNewline
    Write-Host $command -ForegroundColor Yellow
    Invoke-Expression $command
}

$gitmojiTypeCompleter = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    [scriptblock]$RenderHint = { "$($_.emoji) <# $($_.desc) #> " }
    if ($wordToComplete.Length -eq 0) {
        return $script:EMOJIS | ForEach-Object $RenderHint
    }
    $codeMatches = $script:EMOJIS | Where-Object { ($_.code).StartsWith($wordToComplete) } | ForEach-Object $RenderHint
    $codeContains = $script:EMOJIS | Where-Object { ($_.code) -match "$wordToComplete" } | ForEach-Object $RenderHint
    $descContains = $script:EMOJIS | Where-Object { ($_.desc) -match "$wordToComplete" } | ForEach-Object $RenderHint
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
