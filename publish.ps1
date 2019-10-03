function LoadDotEnv {
    $config = [hashtable]@{ }
    Get-Content "$PSScriptRoot\.env" -ErrorAction Ignore | ForEach-Object {
        $kv = $_.Split('=', 2);
        $config.$($kv[0]) = $kv[1]
    }
    return $config
}

Publish-Module `
    -Path $PSScriptRoot\posh-gitmoji `
    -NuGetApiKey (LoadDotEnv).Key
