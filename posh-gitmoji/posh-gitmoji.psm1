[pscustomobject[]]$script:EMOJIS = (Get-Content $PSScriptRoot/gitmojis.json | ConvertFrom-Json).gitmojis

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
        [string]$Story = $null
    )
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
    $abbreviations = $script:EMOJIS | Where-Object { ($_.description -split ' ' -replace '(?<=\w).','' -join '').ToUpper().Contains($wordToComplete) } | ForEach-Object $RenderHint
    @($codeMatches) + $codeContains + $descContains + $abbreviations | Sort-Object -Unique
}
Register-ArgumentCompleter -CommandName gitmoji -ParameterName Type -ScriptBlock $gitmojiTypeCompleter


Export-ModuleMember -Function @(
    "gitmoji"
)
