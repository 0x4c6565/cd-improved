$Env:OLDPWD = $null
function Set-LocationImproved
{
    $CurrentOldPWD = $Env:OLDPWD
    $Env:OLDPWD = (Get-Location).Path

    if ($args.Count -eq 0)
    {
        Set-Location -Path $HOME
        return
    }

    if ($args[0] -eq "-")
    {
        if ($CurrentOldPWD -ne $null)
        {
            Set-Location -Path $CurrentOldPWD
        }
        return
    }

    if ($args[0] -is [string] -and ([string]$args[0]).StartsWith('~'))
    {
        Set-Location -Path ($args[0] -replace "^~\\*\/*", "$HOME\")
        return
    }

    Set-Location @args
}

if (Test-Path -Path Alias:\cd)
{
    Remove-Item -Path Alias:\cd
}
Set-Alias -Name "cd" -Value "Set-LocationImproved"
