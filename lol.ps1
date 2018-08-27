$Env:OLDPWD = $null
function Set-LocationImproved
{
    $CurrentDirectory = (Get-Location).Path

    if ($args.Count -eq 0)
    {
        Set-Location -Path $HOME
    }
    elseif ($args[0] -eq "-")
    {
        if ($Env:OLDPWD -ne $null)
        {
            Set-Location -Path $Env:OLDPWD
        }
    }
    elseif ($args[0] -is [string] -and ([string]$args[0]).StartsWith('~'))
    {
        Set-Location -Path ($args[0] -replace "^~\\*\/*","$HOME\")
    }
    else
    {
        Set-Location @args
    }

    $Env:OLDPWD = $CurrentDirectory
}

if (Test-Path -Path Alias:\cd)
{
    Remove-Item -Path Alias:\cd
}
Set-Alias -Name "cd" -Value "Set-LocationImproved"
