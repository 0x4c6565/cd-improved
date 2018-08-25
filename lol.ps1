$Global:PreviousDirectory = $null
function Set-LocationImproved
{
    if ($args.Count -eq 0)
    {
        Set-Location -Path $HOME
        return
    }

    $CurrentDirectory = (Get-Location).Path

    if ($args[0] -eq "-")
    {
        if ($Global:PreviousDirectory -ne $null)
        {
            Set-Location -Path $PreviousDirectory
        }
    }
    elseif ($args[0] -is [string] -and ([string]$args[0]).StartsWith('~'))
    {
        Set-Location -Path ($args[0] -replace "^~\\?/?","$HOME\")
    }
    else
    {
        Set-Location -Path $args[0]
    }

    $Global:PreviousDirectory = $CurrentDirectory
}

if (Test-Path -Path Alias:\cd)
{
    Remove-Item -Path Alias:\cd
}
Set-Alias -Name "cd" -Value "Set-LocationImproved"
